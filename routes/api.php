<?php

use App\Http\Controllers\API\PaypalController;
use App\Http\Controllers\API\TourasController;
use App\Http\Controllers\API\V1\AddressApiController;
use App\Http\Controllers\API\V1\Auth\AuthController;
use App\Http\Controllers\API\V1\Auth\EmailVerificationController;
use App\Http\Controllers\API\V1\Auth\PasswordResetController;
use App\Http\Controllers\API\V1\Auth\SsoController;
use App\Http\Controllers\API\V1\BannerApiController;
use App\Http\Controllers\API\V1\ContactApiController;
use App\Http\Controllers\API\V1\OrderApiController;
use App\Http\Controllers\API\V1\PageApiController;
use App\Http\Controllers\API\V1\ProductApiController;
use App\Http\Controllers\API\V1\ProfileApiController;
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

    Route::post('enquiry', [ContactApiController::class, 'store']);

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
