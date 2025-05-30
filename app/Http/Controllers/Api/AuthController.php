<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Mail;
use App\Mail\EmailVerification;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
            'alamat' => 'required|string'
            // 'telepon' => 'required|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Generate token dan log
            $verificationToken = Str::random(64);
            \Illuminate\Support\Facades\Log::info('Generated token: ' . $verificationToken);

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'alamat' => $request->alamat,
                // 'telepon' => $request->telepon,
                'verification_token' => $verificationToken,
                'is_verified' => false,
                'tipe_pengguna' => 'user'
            ]);

            \Illuminate\Support\Facades\Log::info('User created with email: ' . $user->email);
            \Illuminate\Support\Facades\Log::info('Stored token: ' . $user->verification_token);

            // Generate URL verifikasi
            $verificationUrl = url("/api/verify-email/{$verificationToken}");
            $verificationUrl = str_replace('localhost', '10.10.178.83', $verificationUrl);
            
            \Illuminate\Support\Facades\Log::info('Generated verification URL: ' . $verificationUrl);

            // Kirim email
            Mail::to($user->email)->send(new EmailVerification($user, $verificationUrl));
            \Illuminate\Support\Facades\Log::info('Verification email sent to: ' . $user->email);

            return response()->json([
                'status' => 'success',
                'message' => 'Registrasi berhasil. Silakan cek email Anda untuk verifikasi.',
            ], 201);

        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Registration error: ' . $e->getMessage());
            \Illuminate\Support\Facades\Log::error('Stack trace: ' . $e->getTraceAsString());
            
            return response()->json([
                'status' => 'error',
                'message' => 'Gagal mengirim email verifikasi: ' . $e->getMessage()
            ], 500);
        }
    }

    

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $credentials = $request->only('email', 'password');
        
        // Cek apakah email sudah diverifikasi
        $user = User::where('email', $request->email)->first();
        
        if ($user && !$user->is_verified) {
            return response()->json([
                'status' => 'error',
                'message' => 'Email belum diverifikasi. Silakan cek email Anda untuk verifikasi.',
            ], 401);
        }

        if (!$token = Auth::guard('api')->attempt($credentials)) {
            return response()->json([
                'status' => 'error',
                'message' => 'Email atau password salah',
            ], 401);
        }

        return response()->json([
            'status' => 'success',
            'user' => Auth::guard('api')->user(),
            'token' => $token,
        ]);
    }

    public function logout()
    {
        try {
            // Ambil token saat ini
            $token = JWTAuth::getToken();

            // Invalidasi token saat ini
            JWTAuth::invalidate($token);

            // Jika Anda menggunakan blacklist, Anda bisa menambahkan logika untuk menghapus semua token
            // Misalnya, jika Anda menyimpan token di database, Anda bisa menghapusnya di sini

            return response()->json([
                'status' => 'success',
                'message' => 'Successfully logged out',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Logout failed: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function refresh()
    {
        return response()->json([
            'status' => 'success',
            'user' => Auth::guard('api')->user(),
            'token' => JWTAuth::refresh()
        ]);
    }

    public function loginWithGoogle(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'name' => 'required|string',
            'google_id' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        try {
            // Cek apakah user sudah ada
            $user = User::where('email', $request->email)->first();

            if (!$user) {
                // Jika user belum ada, buat user baru
                $user = User::create([
                    'name' => $request->name,
                    'email' => $request->email,
                    'password' => Hash::make(Str::random(16)), // Password acak
                    'google_id' => $request->google_id,
                    'alamat' => 'Lumajang',
                    'is_verified' => true, // Auto verifikasi untuk login Google
                    'tipe_pengguna' => 'user'
                ]);
            } else {
                // Jika user sudah ada, update google_id
                $user->update([
                    'google_id' => $request->google_id,
                    'is_verified' => true
                ]);
            }

            // Generate token JWT
            $token = JWTAuth::fromUser($user);

            return response()->json([
                'status' => 'success',
                'user' => $user,
                'token' => $token,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Login with Google failed: ' . $e->getMessage()
            ], 500);
        }
    }
} 