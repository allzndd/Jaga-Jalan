<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class ResetPasswordController extends Controller
{
    public function showResetForm($token)
    {
        try {
            \Illuminate\Support\Facades\Log::info('Received reset token: ' . $token);
            
            $user = User::where('reset_password_token', $token)
                        ->where('reset_password_expires_at', '>', now())
                        ->first();

            if (!$user) {
                \Illuminate\Support\Facades\Log::error('Token tidak ditemukan atau kadaluarsa: ' . $token);
                return view('reset_password.failed', [
                    'message' => 'Link reset password tidak valid atau sudah kadaluarsa'
                ]);
            }

            return view('reset_password.form', [
                'token' => $token,
                'email' => $user->email
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Reset password error: ' . $e->getMessage());
            return view('reset_password.failed', [
                'message' => 'Terjadi kesalahan saat memproses reset password'
            ]);
        }
    }

    public function reset(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'password' => 'required|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return back()->withErrors($validator)->withInput();
        }

        try {
            $user = User::where('reset_password_token', $request->token)
                        ->where('reset_password_expires_at', '>', now())
                        ->first();

            if (!$user) {
                return view('reset_password.failed', [
                    'message' => 'Link reset password tidak valid atau sudah kadaluarsa'
                ]);
            }

            $user->password = Hash::make($request->password);
            $user->reset_password_token = null;
            $user->reset_password_expires_at = null;
            $user->save();

            return view('reset_password.success', [
                'message' => 'Password berhasil diperbarui. Silakan login dengan password baru Anda.'
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Reset password error: ' . $e->getMessage());
            return view('reset_password.failed', [
                'message' => 'Terjadi kesalahan saat memproses reset password'
            ]);
        }
    }
} 