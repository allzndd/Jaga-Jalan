<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
// use App\Models\Admin;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use App\Models\User;

class AdminController extends Controller
{
    public function index()
    {
        $currentAdmin = Auth::guard('admin')->user();
        // Ambil semua pengguna dengan tipe 'admin' dan 'super admin' dari tabel users
        $admins = User::whereIn('tipe_pengguna', ['admin', 'super admin'])->get();
        
        // Tambahkan data untuk dropdown
        $instansiOptions = User::getInstansiOptions();
        $jabatanOptions = User::getJabatanOptions();
        
        return view('admins.index', compact('admins', 'currentAdmin', 'instansiOptions', 'jabatanOptions'));
    }

    public function create()
    {
        return view('admins.create');
    }

    public function store(Request $request)
    {
        try {
            // Cek apakah user adalah super admin
            if (Auth::guard('admin')->user()->tipe_pengguna !== 'super admin') {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Hanya Super Admin yang dapat menambahkan admin baru.'
                ], 403);
            }

            $validator = Validator::make($request->all(), [
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users,email',
                'password' => 'required|string|min:8',
                'alamat' => 'required|string',
                'tipe_pengguna' => 'required|in:admin,super admin',
                'instansi' => 'required|in:BPBD,PUPR',
                'jabatan' => 'required|string',
            ], [
                'name.required' => 'Nama harus diisi',
                'email.required' => 'Email harus diisi',
                'email.email' => 'Format email tidak valid',
                'email.unique' => 'Email sudah digunakan',
                'password.required' => 'Password harus diisi',
                'password.min' => 'Password minimal 8 karakter',
                'alamat.required' => 'Alamat harus diisi',
                'tipe_pengguna.required' => 'Tipe pengguna harus diisi',
                'tipe_pengguna.in' => 'Tipe pengguna tidak valid',
                'instansi.required' => 'Instansi harus diisi',
                'instansi.in' => 'Instansi tidak valid',
                'jabatan.required' => 'Jabatan harus diisi',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'errors' => $validator->errors()
                ], 422);
            }

            // Validasi jabatan sesuai dengan instansi
            $jabatanOptions = User::getJabatanOptions($request->instansi);
            if (!array_key_exists($request->jabatan, $jabatanOptions)) {
                return response()->json([
                    'success' => false,
                    'errors' => ['jabatan' => ['Jabatan tidak valid untuk instansi yang dipilih']]
                ], 422);
            }

            $admin = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'alamat' => $request->alamat,
                'tipe_pengguna' => $request->tipe_pengguna,
                'instansi' => $request->instansi,
                'jabatan' => $request->jabatan,
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Admin berhasil ditambahkan',
                'data' => $admin
            ]);

        } catch (\Exception $e) {
            Log::error('Error saat menambah admin: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan: ' . $e->getMessage()
            ], 500);
        }
    }

    public function edit(User $admin)
    {
        $currentAdmin = Auth::user();
        if ($admin->id === $currentAdmin->id) {
            return redirect()->route('admins.index')
                ->with('error', 'Anda tidak dapat mengedit akun Anda sendiri di sini. Gunakan halaman profile.');
        }
        return view('admins.edit', compact('admin'));
    }

    public function update(Request $request, User $admin)
    {
        $currentAdmin = Auth::user();
        if ($admin->id === $currentAdmin->id) {
            return redirect()->route('admins.index')
                ->with('error', 'Anda tidak dapat mengedit akun Anda sendiri di sini. Gunakan halaman profile.');
        }

        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:admins,email,' . $admin->id,
            'alamat' => 'required|string',
        ]);

        User::where('id', $admin->id)->update([
            'name' => $request->name,
            'email' => $request->email,
            'alamat' => $request->alamat,
        ]);

        return redirect()->route('admins.index')
            ->with('success', 'Admin berhasil diperbarui.');
    }

    public function destroy($id)
    {
        try {
            // Cek apakah user adalah super admin
            if (Auth::guard('admin')->user()->tipe_pengguna !== 'super admin') {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized. Hanya Super Admin yang dapat menghapus admin.'
                ], 403);
            }

            $admin = User::findOrFail($id);
            
            // Prevent deleting self
            if ($admin->id === Auth::guard('admin')->id()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Tidak dapat menghapus akun sendiri'
                ], 403);
            }

            $admin->delete();

            return response()->json([
                'success' => true,
                'message' => 'Admin berhasil dihapus'
            ]);

        } catch (\Exception $e) {
            Log::error('Error saat menghapus admin: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan: ' . $e->getMessage()
            ], 500);
        }
    }

    // Tambahkan method untuk mendapatkan jabatan berdasarkan instansi (untuk AJAX)
    public function getJabatan(Request $request)
    {
        $instansi = $request->instansi;
        $jabatanOptions = User::getJabatanOptions($instansi);
        
        return response()->json([
            'success' => true,
            'data' => $jabatanOptions
        ]);
    }
} 