<?php

namespace App\Http\Middleware;

use App\Models\CMS\Locale;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use Symfony\Component\HttpFoundation\Response;

class SetApiLocale
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // 1. Determine requested language from path, query string, or headers
        $rawLang = $request->route('lang')
            ?? $request->query('lang')
            ?? $request->query('locale')
            ?? $request->header('X-Locale')
            ?? $request->header('Accept-Language')
            ?? config('app.locale', 'en');

        if (is_string($rawLang) && str_contains($rawLang, ',')) {
            $rawLang = explode(',', $rawLang)[0];
        }
        if (is_string($rawLang) && str_contains($rawLang, ';')) {
            $rawLang = explode(';', $rawLang)[0];
        }
        $rawLang = strtolower(trim((string) $rawLang));

        // Fetch valid locales from database table (cached for performance)
        $validLocales = static::getValidLocales();

        $selectedLocale = static::resolveLocale($rawLang, $validLocales);

        App::setLocale($selectedLocale);

        // If lang was captured as a route parameter, forget it so controller actions don't get shifted parameters
        if ($request->route() && $request->route()->hasParameter('lang')) {
            $request->route()->forgetParameter('lang');
        }

        return $next($request);
    }

    /**
     * Fetch active locale codes from database table.
     */
    protected static function getValidLocales(): array
    {
        try {
            return Cache::remember('active_locale_codes', 3600, function () {
                return Locale::pluck('code')->map(fn($c) => strtolower($c))->toArray();
            });
        } catch (\Throwable $e) {
            return ['en'];
        }
    }

    /**
     * Resolve requested lang string to a matching DB locale code or default fallback.
     */
    protected static function resolveLocale(string $requested, array $validLocales): string
    {
        if (empty($validLocales)) {
            return !empty($requested) ? $requested : 'en';
        }

        // 1. Exact match (case insensitive)
        foreach ($validLocales as $code) {
            if ($code === $requested) {
                return $code;
            }
        }

        // 2. Prefix match (e.g., requested "en" matches "en-ae", or requested "en-ae" matches "en")
        $shortRequested = explode('-', str_replace('_', '-', $requested))[0];
        foreach ($validLocales as $code) {
            $shortCode = explode('-', str_replace('_', '-', $code))[0];
            if ($shortCode === $shortRequested) {
                return $code;
            }
        }

        // 3. Fallback: return requested if provided, or default fallback from DB / config
        return !empty($requested) ? $requested : ($validLocales[0] ?? config('app.locale', 'en'));
    }
}
