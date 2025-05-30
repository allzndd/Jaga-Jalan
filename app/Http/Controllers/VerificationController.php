<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class VerificationController extends Controller
{
    public function verifyEmail($token)
    {
        try {
            \Illuminate\Support\Facades\Log::info('Received verification token: ' . $token);
            
            $user = User::where('verification_token', $token)->first();

            if (!$user) {
                \Illuminate\Support\Facades\Log::error('Token tidak ditemukan: ' . $token);
                return view('verification.failed', [
                    'message' => 'Link verifikasi tidak valid atau sudah kadaluarsa'
                ]);
            }

            $user->is_verified = true;
            $user->email_verified_at = now();
            $user->verification_token = null;
            $user->save();

            \Illuminate\Support\Facades\Log::info('Email berhasil diverifikasi: ' . $user->email);

            return view('verification.success', [
                'name' => $user->name,
                'message' => 'Email berhasil diverifikasi'
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Verification error: ' . $e->getMessage());
            return view('verification.failed', [
                'message' => 'Terjadi kesalahan saat verifikasi'
            ]);
        }
    }
} 