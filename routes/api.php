<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController as ApiAuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\LaporanJalanController;
use App\Http\Controllers\LaporanBencanaController;
use App\Http\Controllers\WeatherController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Api\ForgotPasswordController;

// Public Routes
Route::post('register', [ApiAuthController::class, 'register']);
Route::post('login', [ApiAuthController::class, 'login']);
Route::post('login-google', [ApiAuthController::class, 'loginWithGoogle']);
Route::get('/cuaca', [WeatherController::class, 'getWeather']);
Route::get('verify-email/{token}', [ApiAuthController::class, 'verifyEmail']);
Route::post('logout', [ApiAuthController::class, 'logout']);

// Protected Routes
Route::middleware('jwt.auth')->group(function () {
    Route::post('refresh', [ApiAuthController::class, 'refresh']);
    Route::get('/laporan-jalan', [DashboardController::class, 'getLaporanJalan']);
    Route::get('/laporan-bencana', [DashboardController::class, 'getLaporanBencana']);
    Route::get('/laporan/riwayat', [DashboardController::class, 'getRiwayatLaporan']);
    Route::post('lapor/jalan', [LaporanJalanController::class, 'store']);
    Route::post('lapor/bencana', [LaporanBencanaController::class, 'store']);
});

Route::middleware('auth:api')->group(function () {
    Route::post('/profile/update', [ProfileController::class, 'update']);
});

Route::group(['middleware' => 'api'], function () {
    Route::post('/refresh', [ApiAuthController::class, 'refresh']);
});

// Rute untuk lupa password
Route::post('/forgot-password', [ForgotPasswordController::class, 'sendResetLink']);
Route::post('/reset-password', [ForgotPasswordController::class, 'resetPassword']);