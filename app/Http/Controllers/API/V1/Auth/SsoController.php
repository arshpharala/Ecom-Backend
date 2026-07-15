<?php

namespace App\Http\Controllers\API\V1\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class SsoController extends Controller
{
    /**
     * Supported SSO providers.
     */
    protected array $providers = ['google', 'facebook', 'github'];

    /**
     * Return the SSO redirect URL for the given provider.
     *
     * GET /api/v1/auth/sso/{provider}/redirect
     * Response: { success: true, data: { url: "https://accounts.google.com/..." } }
     */
    public function redirect(string $provider): JsonResponse
    {
        if (!$this->isValidProvider($provider)) {
            return response()->json([
                'success' => false,
                'message' => 'Unsupported SSO provider.',
            ], 422);
        }

        if (!$this->isProviderEnabled($provider)) {
            return response()->json([
                'success' => false,
                'message' => ucfirst($provider) . ' login is currently disabled.',
            ], 422);
        }

        $this->configureSocialite($provider);

        $url = Socialite::driver($provider)
            ->stateless()
            ->redirect()
            ->getTargetUrl();

        return response()->json([
            'success' => true,
            'data' => [
                'url' => $url,
            ],
        ]);
    }

    /**
     * Handle the SSO callback from the provider.
     *
     * GET /api/v1/auth/sso/{provider}/callback
     * Redirects to: FRONTEND_URL/auth/callback?token=xxx
     *
     * This endpoint is hit by the OAuth provider after the user authorizes.
     * It finds or creates the user, generates a Sanctum token,
     * and redirects to the React frontend with the token.
     */
    public function callback(string $provider): RedirectResponse|JsonResponse
    {
        $frontendUrl = config('app.frontend_url', 'http://localhost:3000');

        if (!$this->isValidProvider($provider)) {
            return redirect("{$frontendUrl}/auth/callback?error=unsupported_provider&message=" . urlencode('Unsupported SSO provider.'));
        }

        if (!$this->isProviderEnabled($provider)) {
            return redirect("{$frontendUrl}/auth/callback?error=provider_disabled&message=" . urlencode(ucfirst($provider) . ' login is currently disabled.'));
        }

        $this->configureSocialite($provider);

        try {
            $socialUser = Socialite::driver($provider)
                ->stateless()
                ->user();
        } catch (\Exception $e) {
            return redirect("{$frontendUrl}/auth/callback?error=sso_failed&message=" . urlencode('SSO authentication failed. Please try again.'));
        }

        // Find existing user by provider or email
        $user = User::where('provider_name', $provider)
            ->where('provider_id', $socialUser->getId())
            ->first();

        if (!$user) {
            // Check if a user with this email already exists (registered via email)
            $user = User::where('email', $socialUser->getEmail())->first();

            if ($user) {
                // Link the SSO provider to the existing account
                $user->update([
                    'provider_name' => $provider,
                    'provider_id' => $socialUser->getId(),
                    'email_verified_at' => $user->email_verified_at ?? now(),
                ]);
            } else {
                // Create a new user from SSO data
                $user = User::create([
                    'name' => $socialUser->getName() ?? $socialUser->getNickname() ?? 'User',
                    'email' => $socialUser->getEmail(),
                    'password' => null,
                    'provider_name' => $provider,
                    'provider_id' => $socialUser->getId(),
                    'email_verified_at' => now(),
                    'is_active' => true,
                    'is_guest' => false,
                ]);
            }
        }

        if (!$user->is_active) {
            return redirect("{$frontendUrl}/auth/callback?error=account_deactivated&message=" . urlencode('Your account has been deactivated.'));
        }

        // Update last login
        $user->update(['last_login_at' => now()]);

        // Create Sanctum token
        $token = $user->createToken('sso-auth-token')->plainTextToken;

        return redirect("{$frontendUrl}/auth/callback?token={$token}");
    }

    /**
     * Check if the given provider is supported.
     */
    protected function isValidProvider(string $provider): bool
    {
        return in_array($provider, $this->providers);
    }

    /**
     * Check if social login is globally enabled and the specific provider is enabled.
     * Reads from the settings table via the setting() helper.
     */
    protected function isProviderEnabled(string $provider): bool
    {
        // Check global social login toggle
        if (!setting('social_login_enabled')) {
            return false;
        }

        // Check per-provider toggle (e.g. social_login_google, social_login_facebook)
        return (bool) setting("social_login_{$provider}");
    }

    /**
     * Dynamically configure Socialite with credentials from the settings table.
     *
     * Settings keys expected:
     *   {provider}_client_id     (e.g. google_client_id)
     *   {provider}_client_secret (e.g. google_client_secret)
     */
    protected function configureSocialite(string $provider): void
    {
        $clientId = setting("{$provider}_client_id");
        $clientSecret = setting("{$provider}_client_secret");
        $redirectUrl = url("/api/v1/auth/sso/{$provider}/callback");

        config([
            "services.{$provider}.client_id" => $clientId,
            "services.{$provider}.client_secret" => $clientSecret,
            "services.{$provider}.redirect" => $redirectUrl,
        ]);
    }
}
