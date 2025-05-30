<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use App\Models\LaporanJalan;
use App\Events\LaporanDibuat;
use PDF;
use App\Exports\JalanExport;
use Maatwebsite\Excel\Facades\Excel;

class LaporanJalanController extends Controller
{
    public function pemetaan()
    {
        return view('laporanjalan');
    }
    public function index()
    {
        $laporanJalan = DB::table('laporan_jalan')
            ->join('users', 'laporan_jalan.user_id', '=', 'users.id')
            ->select('laporan_jalan.*', 'users.name as pelapor')
            ->orderBy('created_at', 'desc')
            ->get();

        return view('jalan.index', compact('laporanJalan'));
    }

    public function getLaporanJalan()
    {
        $laporanJalan = DB::table('laporan_jalan')
            ->select('latitude', 'longitude', 'status', 'jenis_rusak')
            ->whereIn('status', ['menunggu', 'dalam_proses'])
            ->get();

        return response()->json($laporanJalan);
    }

    public function updateStatus(Request $request, $id)
    {
        $status = $request->status;
        $allowed_status = ['menunggu', 'dalam_proses', 'selesai'];
        
        if (!in_array($status, $allowed_status)) {
            return response()->json(['success' => false, 'message' => 'Status tidak valid']);
        }

        try {
            DB::table('laporan_jalan')
                ->where('id', $id)
                ->update(['status' => $status]);
            
            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => 'Gagal mengupdate status']);
        }
    }

    public function destroy($id)
    {
        $laporan = DB::table('laporan_jalan')->where('id', $id)->first();
        if ($laporan) {
            // Hapus file foto jika ada
            if ($laporan->foto) {
                $path = public_path('storage/' . $laporan->foto);
                if (file_exists($path)) {
                    unlink($path);
                }
            }
            
            DB::table('laporan_jalan')->where('id', $id)->delete();
            return response()->json(['success' => true]);
        }
        return response()->json(['success' => false]);
    }

    private function checkLaporanLimit($userId)
    {
        // Jika user ID adalah 60, 61, atau 62, tidak ada batasan
        if (in_array($userId, [60, 61, 62])) {
            return true;
        }

        // Hitung jumlah laporan hari ini
        $today = now()->startOfDay();
        $count = DB::table('laporan_jalan')
            ->where('user_id', $userId)
            ->where('created_at', '>=', $today)
            ->count();

        // Batasi 10 laporan per hari
        return $count < 10;
    }

    private function isWithinLumajang($latitude, $longitude)
    {
        // Koordinat batas wilayah Lumajang
        $minLat = -8.5;  // Batas selatan
        $maxLat = -7.8;  // Batas utara
        $minLng = 112.8; // Batas barat
        $maxLng = 113.4; // Batas timur

        return ($latitude >= $minLat && $latitude <= $maxLat) &&
               ($longitude >= $minLng && $longitude <= $maxLng);
    }

    public function store(Request $request)
    {
        try {
            // Validasi koordinat
            if (!$this->isWithinLumajang($request->latitude, $request->longitude)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Lokasi yang dipilih berada di luar wilayah Lumajang'
                ], 400);
            }

            // Cek batasan laporan
            if (!$this->checkLaporanLimit(Auth::id())) {
                return response()->json([
                    'success' => false,
                    'message' => 'Anda telah mencapai batas maksimal laporan hari ini (10 laporan)'
                ], 400);
            }

            // Validasi input
            $request->validate([
                'lokasi' => 'required|string',
                'latitude' => 'required|numeric',
                'longitude' => 'required|numeric',
                'jenis_rusak' => 'required|in:jalan rusak ringan,jalan rusak berat',
                'deskripsi' => 'nullable|string',
                'foto' => 'nullable|image|max:5120', // maksimal 5MB
            ]);

            // Upload foto
            $fotoPath = null;
            if ($request->hasFile('foto')) {
                $foto = $request->file('foto');
                $fileName = time() . '_' . $foto->getClientOriginalName();
                $fotoPath = $foto->storeAs('laporan-jalan', $fileName, 'public');
            }

            // Simpan data ke database
            $laporan = LaporanJalan::create([
                'user_id' => Auth::id(),
                'lokasi' => $request->lokasi,
                'latitude' => $request->latitude,
                'longitude' => $request->longitude,
                'jenis_rusak' => $request->jenis_rusak,
                'deskripsi' => $request->deskripsi,
                'foto' => $fotoPath,
                'status' => 'menunggu',
            ]);

            // Kirim notifikasi ke semua admin
            $admins = \App\Models\User::where('tipe_pengguna', 'admin')->orWhere('tipe_pengguna', 'super admin')->get();
            foreach ($admins as $admin) {
                $admin->notify(new \App\Notifications\NewLaporanJalanNotification($laporan));
            }

            broadcast(new LaporanDibuat($laporan));

            return response()->json([
                'success' => true,
                'message' => 'Laporan berhasil dikirim',
                'data' => [
                    'id' => $laporan->id,
                    'foto_url' => $fotoPath ? asset('storage/' . $fotoPath) : null
                ]
            ], 201);
        } catch (\Exception $e) {
            // Hapus foto jika upload gagal
            if (isset($fotoPath)) {
                Storage::disk('public')->delete($fotoPath);
            }

            return response()->json([
                'success' => false,
                'message' => 'Gagal mengirim laporan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function rekap($format)
    {
        $tahun = request('tahun');
        $bulan = request('bulan');
        
        $query = DB::table('laporan_jalan')
            ->join('users', 'laporan_jalan.user_id', '=', 'users.id')
            ->select('laporan_jalan.*', 'users.name as pelapor');
        
        if ($bulan) {
            $query->whereYear('laporan_jalan.created_at', $tahun)
                  ->whereMonth('laporan_jalan.created_at', $bulan);
        } else {
            $query->whereYear('laporan_jalan.created_at', $tahun);
        }
        
        $data = $query->get();
        
        if ($format === 'pdf') {
            $pdf = PDF::loadView('jalan.rekap', [
                'data' => $data,
                'tahun' => $tahun,
                'bulan' => $bulan
            ]);
            
            return $pdf->download('rekap-jalan-' . ($bulan ? $tahun . '-' . $bulan : $tahun) . '.pdf');
        } else {
            return Excel::download(new JalanExport($data), 'rekap-jalan-' . ($bulan ? $tahun . '-' . $bulan : $tahun) . '.xlsx');
        }
    }
}
