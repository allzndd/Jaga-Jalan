<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\LaporanJalanController;
use App\Http\Controllers\LaporanBencanaController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\VerificationController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Notifications\DatabaseNotification;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ResetPasswordRedirectController;
use App\Http\Controllers\PrivacyPolicyController;
use App\Http\Controllers\ExampleController;

// Web Routes
Route::middleware('web')->group(function () {
    // Guest Routes
    Route::middleware('guest')->group(function () {
        Route::get('/', function () {
            return redirect()->route('login');
        });
        Route::get('login', [AuthController::class, 'showLoginForm'])->name('login');
        Route::post('login', [AuthController::class, 'login']);
        Route::get('register', [AuthController::class, 'showRegisterForm'])->name('register');
        Route::post('register', [AuthController::class, 'register']);
        Route::get('privacy-policy', [PrivacyPolicyController::class, 'index'])->name('privacy-policy');
    });

    // Auth Routes
    Route::middleware('auth')->group(function () {
        Route::post('logout', [AuthController::class, 'logout'])->name('logout');
        Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');
        
        // Profile Routes
        Route::get('/profile', [UserController::class, 'profile'])->name('profile');
        Route::put('/profile', [UserController::class, 'updateProfile'])->name('profile.update');
        Route::put('/profile/password', [UserController::class, 'updatePassword'])->name('profile.password');
        
        // Laporan Routes
        Route::get('/laporanjalan', [LaporanJalanController::class, 'pemetaan'])->name('laporanjalan');
        Route::get('/laporanbencana', [LaporanBencanaController::class, 'pemetaan'])->name('laporanbencana');
        Route::get('/bencana', [LaporanBencanaController::class, 'index'])->name('bencana.index');
        Route::delete('/bencana/{id}', [LaporanBencanaController::class, 'destroy'])->name('bencana.destroy');
        Route::put('/bencana/{id}/status', [LaporanBencanaController::class, 'updateStatus'])->name('bencana.updateStatus');
        Route::get('/jalan', [LaporanJalanController::class, 'index'])->name('jalan.index');
        Route::delete('/jalan/{id}', [LaporanJalanController::class, 'destroy'])->name('jalan.destroy');
        Route::put('/jalan/{id}/status', [LaporanJalanController::class, 'updateStatus'])->name('jalan.updateStatus');
        
        // Route untuk rekap
        Route::get('/bencana/rekap/{format}', [LaporanBencanaController::class, 'rekap'])->name('bencana.rekap');
        Route::get('/jalan/rekap/{format}', [LaporanJalanController::class, 'rekap'])->name('jalan.rekap');
        
        // User dan Admin Routes
        Route::get('/users', [UserController::class, 'index'])->name('users.index');
        Route::delete('/users/{id}', [UserController::class, 'destroy'])->name('users.destroy');
        
        // Admin Routes
        Route::get('/admins', [AdminController::class, 'index'])->name('admins.index');
        Route::post('/admins', [AdminController::class, 'store'])->name('admins.store');
        Route::delete('/admins/{id}', [AdminController::class, 'destroy'])->name('admins.destroy');
        Route::get('/admins/get-jabatan', [AdminController::class, 'getJabatan'])->name('admins.getJabatan');

        // Routes untuk dashboard map
        Route::get('/laporan-jalan/data', [DashboardController::class, 'getLaporanJalan'])->name('laporan.jalan.data');
        Route::get('/laporan-bencana/data', [DashboardController::class, 'getLaporanBencana'])->name('laporan.bencana.data');

        // Tambahkan route ini
        Route::post('/bencana', [LaporanBencanaController::class, 'store'])->name('bencana.store');

        // Rute untuk laporan jalan
        Route::get('/laporan-jalan', [LaporanJalanController::class, 'index'])->name('jalan.index');
        Route::post('/laporan-jalan', [LaporanJalanController::class, 'store'])->name('jalan.store');
        Route::delete('/laporan-jalan/{id}', [LaporanJalanController::class, 'destroy'])->name('jalan.destroy');
        Route::put('/laporan-jalan/{id}/status', [LaporanJalanController::class, 'updateStatus'])->name('jalan.updateStatus');
    });

    // Tambahkan route ini
    Route::get('email/verify/{token}', [VerificationController::class, 'verifyEmail'])
        ->name('email.verify');

    // Notification routes
    Route::middleware(['auth'])->group(function () {
        // Route untuk notifikasi
        Route::post('/notifications/{id}/mark-as-read', [NotificationController::class, 'markAsRead'])->name('notifications.mark-as-read');
        Route::post('/notifications/mark-all-read', [NotificationController::class, 'markAllRead'])->name('notifications.mark-all-read');
        Route::post('/notifications/delete-read', [NotificationController::class, 'deleteRead'])->name('notifications.delete-read');
        
        // Route untuk mendapatkan jumlah notifikasi
        Route::get('/get-notifications-count', [NotificationController::class, 'getNotificationsCount'])->name('notifications.count');
    });

    // Tambahkan route ini
    Route::get('/reset-password-redirect/{token}/{email}', [ResetPasswordRedirectController::class, 'redirect'])
        ->name('password.reset.redirect');

    // Route untuk contoh notifikasi real-time
    Route::get('/create-sample-notification', [ExampleController::class, 'createSampleNotification']);

    // Route untuk autentikasi Pusher channel
    Route::post('broadcasting/auth', function() {
        return Auth::user();
    });
});
