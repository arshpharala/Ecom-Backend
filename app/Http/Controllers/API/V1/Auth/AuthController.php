<?php

namespace App\Http\Controllers\API\V1\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\API\LoginRequest;
use App\Http\Requests\API\RegisterRequest;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    /**
     * Register a new user account.
     *
     * POST /api/v1/auth/register
     * Body: { name, email, password, password_confirmation }
     */
    public function register(RegisterRequest $request): JsonResponse
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => $request->password,
            'is_active' => true,
            'is_guest' => false,
        ]);

        // Send email verification notification
        // $user->sendEmailVerificationNotification();

        // Create Sanctum token
        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Account created successfully. Please verify your email.',
            'data' => [
                'user' => $this->userResponse($user),
                'token' => $token,
            ],
        ], 201);
    }

    /**
     * Login with email and password.
     *
     * POST /api/v1/auth/login
     * Body: { email, password }
     */
    public function login(LoginRequest $request): JsonResponse
    {
        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid email or password.',
            ], 401);
        }

        if (!$user->is_active) {
            return response()->json([
                'success' => false,
                'message' => 'Your account has been deactivated.',
            ], 403);
        }

        // Check if this is an SSO-only account (no password set)
        if ($user->provider_name && !$user->password) {
            return response()->json([
                'success' => false,
                'message' => 'This account uses social login. Please sign in with ' . ucfirst($user->provider_name) . '.',
            ], 422);
        }

        // Update last login timestamp
        $user->update(['last_login_at' => now()]);

        // Create Sanctum token
        $token = $user->createToken('auth-token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Logged in successfully.',
            'data' => [
                'user' => $this->userResponse($user),
                'token' => $token,
            ],
        ]);
    }

    /**
     * Logout the current user (revoke current token).
     *
     * POST /api/v1/auth/logout
     * Header: Authorization: Bearer {token}
     */
    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logged out successfully.',
        ]);
    }

    /**
     * Get the authenticated user's profile.
     *
     * GET /api/v1/auth/me
     * Header: Authorization: Bearer {token}
     */
    public function me(Request $request): JsonResponse
    {
        return response()->json([
            'success' => true,
            'data' => [
                'user' => $this->userResponse($request->user()),
            ],
        ]);
    }



    /**
     * Format user data for API response.
     */
    protected function userResponse(User $user): array
    {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'phone' => $user->detail ? $user->detail->mobile : null,
            'email_verified' => !is_null($user->email_verified_at),
            'is_sso' => !is_null($user->provider_name),
            'provider' => $user->provider_name,
            'created_at' => $user->created_at,
        ];
    }
}
