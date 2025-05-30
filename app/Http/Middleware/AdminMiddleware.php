<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // Cek apakah pengguna terautentikasi
        if (Auth::guard('web')->check()) {
            $user = Auth::user();
            if ($user && $user->tipe_pengguna === 'admin') {
                return $next($request); // Izinkan akses jika terautentikasi dan tipe pengguna adalah admin
            }
        }
        
        return redirect()->route('login')->with('error', 'Silakan login terlebih dahulu.'); // Arahkan ke halaman login jika tidak terautentikasi
    }
} 