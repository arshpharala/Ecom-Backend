<?php

use App\Http\Controllers\API\PaypalController;
use App\Http\Controllers\API\TourasController;
use App\Http\Controllers\API\V1\AddressApiController;
use App\Http\Controllers\API\V1\Auth\AuthController;
use App\Http\Controllers\API\V1\Auth\EmailVerificationController;
use App\Http\Controllers\API\V1\Auth\PasswordResetController;
use App\Http\Controllers\API\V1\Auth\SsoController;
use App\Http\Controllers\API\V1\AttributeApiController;
use App\Http\Controllers\API\V1\BannerApiController;
use App\Http\Controllers\API\V1\ContactApiController;
use App\Http\Controllers\API\V1\OrderApiController;
use App\Http\Controllers\API\V1\PageApiController;
use App\Http\Controllers\API\V1\ProductApiController;
use App\Http\Controllers\API\V1\ProfileApiController;
use App\Http\Controllers\API\V1\CartApiController;
use App\Http\Controllers\API\V1\CheckoutApiController;
use Illuminate\Support\Facades\Route;




Route::get('/paypal/success', [PaypalController::class, 'success'])->name('paypal.success');
Route::get('/paypal/cancel', [PaypalController::class, 'cancel'])->name('paypal.cancel');
Route::post('/touras/webhook', [TourasController::class, 'webhook'])->name('touras.webhook');

/*
|--------------------------------------------------------------------------
| Store Front API (for React app)
|--------------------------------------------------------------------------
*/

Route::group(
  ['prefix' => '/v1'],
  function () {
    Route::get('/init', [\App\Http\Controllers\API\V1\CoreApiController::class, 'init']);
    Route::apiResource('banners', BannerApiController::class);
    Route::apiResource('products', ProductApiController::class);
    Route::apiResource('pages', PageApiController::class);
    Route::get('attributes', [AttributeApiController::class, 'index']);

    Route::post('enquiry', [ContactApiController::class, 'store']);

    // Cart & Checkout Routes (Require Session for CartService)
    Route::middleware([\Illuminate\Session\Middleware\StartSession::class])->group(function () {
        Route::prefix('cart')->group(function () {
            Route::get('/', [CartApiController::class, 'index']);
            Route::post('/items', [CartApiController::class, 'addItem']);
            Route::put('/items/{itemId}', [CartApiController::class, 'updateItem']);
            Route::delete('/items/{itemId}', [CartApiController::class, 'removeItem']);
            Route::delete('/', [CartApiController::class, 'clearCart']);
        });

        Route::prefix('checkout')->group(function () {
            Route::post('/', [CheckoutApiController::class, 'checkout']);
            Route::post('/coupon/apply', [CheckoutApiController::class, 'applyCoupon']);
            Route::post('/coupon/remove', [CheckoutApiController::class, 'removeCoupon']);
        });
    });

    /*
    |----------------------------------------------------------------------
    | Authentication Routes
    |----------------------------------------------------------------------
    */

    // Public auth routes (no token required)
    Route::prefix('auth')->group(function () {

      // Registration & Login
      Route::post('/register', [AuthController::class, 'register']);
      Route::post('/login', [AuthController::class, 'login']);

      // Forgot / Reset Password
      Route::post('/forgot-password', [PasswordResetController::class, 'forgotPassword']);
      Route::post('/reset-password', [PasswordResetController::class, 'resetPassword']);

      // SSO (Social Login)
      Route::get('/sso/{provider}/redirect', [SsoController::class, 'redirect']);
      Route::get('/sso/{provider}/callback', [SsoController::class, 'callback']);

      // Email Verification (public — user clicks link from email)
      Route::post('/email/verify', [EmailVerificationController::class, 'verify']);
    });

    // Protected auth routes (token required)
    Route::prefix('auth')->middleware('auth:sanctum')->group(function () {
      Route::post('/logout', [AuthController::class, 'logout']);
      Route::get('/me', [AuthController::class, 'me']);
      Route::put('/profile', [ProfileApiController::class, 'update']);
      Route::apiResource('addresses', AddressApiController::class);
      Route::post('/email/resend', [EmailVerificationController::class, 'resend']);

      Route::get('/orders', [OrderApiController::class, 'index']);
      Route::get('/orders/{id}', [OrderApiController::class, 'show']);
    });
  }
);
