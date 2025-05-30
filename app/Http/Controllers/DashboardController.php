<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\DB;
use App\Models\LaporanJalan;
use App\Models\LaporanBencana;
use Carbon\Carbon;
use Illuminate\Support\Collection;

class DashboardController extends BaseController
{
    public function index(Request $request)
    {
        try {
            // Data untuk KPI Cards
            $totalLaporanJalan = LaporanJalan::count();
            $totalLaporanBencana = LaporanBencana::count();
            $totalLaporan = $totalLaporanJalan + $totalLaporanBencana;

            $menungguJalan = LaporanJalan::where('status', 'menunggu')->count();
            $menungguBencana = LaporanBencana::where('status', 'menunggu')->count();
            $menunggu = $menungguJalan + $menungguBencana;

            $dalamProsesJalan = LaporanJalan::where('status', 'dalam_proses')->count();
            $dalamProsesBencana = LaporanBencana::where('status', 'dalam_proses')->count();
            $dalamProses = $dalamProsesJalan + $dalamProsesBencana;

            $selesaiJalan = LaporanJalan::where('status', 'selesai')->count();
            $selesaiBencana = LaporanBencana::where('status', 'selesai')->count();
            $selesai = $selesaiJalan + $selesaiBencana;

            // Persentase perubahan dari bulan lalu
            $laporanJalanBulanLalu = LaporanJalan::whereMonth('created_at', Carbon::now()->subMonth()->month)->count();
            $laporanBencanaBulanLalu = LaporanBencana::whereMonth('created_at', Carbon::now()->subMonth()->month)->count();
            
            $persentaseKenaikanJalan = $laporanJalanBulanLalu > 0 
                ? round((($totalLaporanJalan - $laporanJalanBulanLalu) / $laporanJalanBulanLalu) * 100, 1)
                : 100;
            
            $persentasePenurunanBencana = $laporanBencanaBulanLalu > 0
                ? round((($totalLaporanBencana - $laporanBencanaBulanLalu) / $laporanBencanaBulanLalu) * 100, 1)
                : 0;

            // Data untuk grafik statistik bulanan
            $monthlyData = [];
            for ($i = 5; $i >= 0; $i--) {
                $date = now()->subMonths($i);
                $month = $date->format('M Y');

                $jalanCount = LaporanJalan::whereYear('created_at', $date->year)
                    ->whereMonth('created_at', $date->month)
                    ->count();

                $bencanaCount = LaporanBencana::whereYear('created_at', $date->year)
                    ->whereMonth('created_at', $date->month)
                    ->count();

                $monthlyData[] = [
                    'bulan' => $month,
                    'jalan' => $jalanCount,
                    'bencana' => $bencanaCount
                ];
            }

            // Data untuk grafik distribusi jenis kerusakan
            $distribusiJalan = DB::table('laporan_jalan')
                ->select('jenis_rusak', DB::raw('count(*) as total'))
                ->groupBy('jenis_rusak')
                ->get();

            $distribusiBencana = DB::table('laporan_bencana')
                ->select('jenis_bencana', DB::raw('count(*) as total'))
                ->groupBy('jenis_bencana')
                ->get();

            return view('dashboard', compact(
                'totalLaporan',
                'totalLaporanJalan',
                'totalLaporanBencana',
                'menunggu',
                'menungguJalan',
                'menungguBencana',
                'dalamProses',
                'dalamProsesJalan',
                'dalamProsesBencana',
                'selesai',
                'selesaiJalan',
                'selesaiBencana',
                'persentaseKenaikanJalan',
                'persentasePenurunanBencana',
                'monthlyData',
                'distribusiJalan',
                'distribusiBencana'
            ));
        } catch (\Exception $e) {
            return back()->with('error', 'Terjadi kesalahan saat memuat dashboard: ' . $e->getMessage());
        }
    }

    public function getLaporanJalan()
    {
        try {
            $laporanJalan = DB::table('laporan_jalan')
                ->select('id', 'lokasi', 'latitude', 'longitude', 'jenis_rusak', 'deskripsi', 'foto', 'status')
                ->where('status', 'dalam_proses')
                ->get();

            // Transform foto path menjadi URL lengkap
            $laporanJalan = $laporanJalan->map(function($item) {
                $item->foto_url = $item->foto ? asset('storage/' . $item->foto) : null;
                return $item;
            });

            return response()->json([
                'success' => true,
                'data' => $laporanJalan
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data laporan jalan',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getLaporanBencana()
    {
        try {
            $laporanBencana = DB::table('laporan_bencana')
                ->select('id', 'lokasi', 'latitude', 'longitude', 'jenis_bencana', 'deskripsi', 'foto', 'status')
                ->where('status', 'dalam_proses')
                ->get();

            // Transform foto path menjadi URL lengkap
            $laporanBencana = $laporanBencana->map(function($item) {
                $item->foto_url = $item->foto ? asset('storage/' . $item->foto) : null;
                return $item;
            });

            return response()->json([
                'success' => true,
                'data' => $laporanBencana
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data laporan bencana',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function getRiwayatLaporan()
    {
        try {
            $user_id = Auth::id();

            // Get laporan bencana yang dilaporkan oleh pengguna
            $bencana = DB::table('laporan_bencana')
                ->where('user_id', $user_id)
                ->select('id', 'lokasi', 'latitude', 'longitude', 'jenis_bencana', 'deskripsi', 'foto', 'status', 'created_at')
                ->orderBy('created_at', 'desc')
                ->get()
                ->map(function($item) {
                    $item->foto_url = $item->foto ? asset('storage/' . $item->foto) : null;
                    return $item;
                });

            // Get laporan jalan yang dilaporkan oleh pengguna
            $jalan = DB::table('laporan_jalan')
                ->where('user_id', $user_id)
                ->select('id', 'lokasi', 'latitude', 'longitude', 'jenis_rusak', 'deskripsi', 'foto', 'status', 'created_at')
                ->orderBy('created_at', 'desc')
                ->get()
                ->map(function($item) {
                    $item->foto_url = $item->foto ? asset('storage/' . $item->foto) : null;
                    return $item;
                });

            return response()->json([
                'success' => true,
                'data' => [
                    'bencana' => $bencana,
                    'jalan' => $jalan
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil riwayat laporan',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
