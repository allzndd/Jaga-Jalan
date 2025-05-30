<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;
use App\Mail\ResetPassword;
use Illuminate\Support\Facades\Hash;

class ForgotPasswordController extends Controller
{
    public function sendResetLink(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
        ], [
            'email.exists' => 'Email tidak terdaftar dalam sistem kami.'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Generate token
            $resetToken = Str::random(64);
            \Illuminate\Support\Facades\Log::info('Generated reset token: ' . $resetToken);

            // Simpan token ke database
            $user = User::where('email', $request->email)->first();
            $user->reset_password_token = $resetToken;
            $user->reset_password_expires_at = now()->addHours(24); // Token berlaku 24 jam
            $user->save();

            \Illuminate\Support\Facades\Log::info('Reset token stored for user: ' . $user->email);

            // Buat URL web yang akan redirect ke aplikasi
            $resetUrl = route('password.reset.redirect', ['token' => $resetToken, 'email' => $user->email]);
            
            // Log URL untuk debugging
            \Illuminate\Support\Facades\Log::info('Reset URL: ' . $resetUrl);

            // Kirim email
            Mail::to($user->email)->send(new ResetPassword($user, $resetUrl));
            \Illuminate\Support\Facades\Log::info('Reset password email sent to: ' . $user->email);

            return response()->json([
                'status' => 'success',
                'message' => 'Link reset password telah dikirim ke email Anda.',
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Reset password error: ' . $e->getMessage());
            \Illuminate\Support\Facades\Log::error('Stack trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'status' => 'error',
                'message' => 'Gagal mengirim email reset password: ' . $e->getMessage()
            ], 500);
        }
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required|string',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Cari user berdasarkan token
            $user = User::where('reset_password_token', $request->token)
                        ->where('reset_password_expires_at', '>', now())
                        ->first();

            if (!$user) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Token tidak valid atau sudah kadaluarsa.'
                ], 400);
            }

            // Update password
            $user->password = Hash::make($request->password);
            $user->reset_password_token = null;
            $user->reset_password_expires_at = null;
            $user->save();

            return response()->json([
                'status' => 'success',
                'message' => 'Password berhasil diperbarui. Silakan login dengan password baru Anda.'
            ]);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Reset password error: ' . $e->getMessage());
            
            return response()->json([
                'status' => 'error',
                'message' => 'Gagal memperbarui password: ' . $e->getMessage()
            ], 500);
        }
    }
} 