<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ResetPasswordRedirectController extends Controller
{
    public function redirect($token, $email)
    {
        // Log untuk debugging
        \Illuminate\Support\Facades\Log::info("Redirecting to app with token: $token and email: $email");
        
        // Buat URL deep link untuk aplikasi
        $appUrl = "jagajalan://reset-password?token={$token}&email={$email}";
        
        return view('reset_password.redirect', [
            'appUrl' => $appUrl,
            'token' => $token,
            'email' => $email
        ]);
    }
} 