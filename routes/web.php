<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;


Route::get('/', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'create']);
Route::post('/login', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'store'])->name('login');
Route::post('/logout', [\App\Http\Controllers\Admin\Auth\AuthenticatedSessionController::class, 'destroy'])->name('logout');

Route::get('/session/check', function () {
    return Auth::guard('admin')->check()
        ? response()->noContent(200)
        : response()->noContent(401);
})->name('session.check');
