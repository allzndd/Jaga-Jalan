<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class LaporanJalanSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Hapus data yang ada di tabel laporan_jalan saja
        DB::table('laporan_jalan')->truncate();
        
        $data = [
            [-8.2053897448152, 113.17503656814328, 'jalan rusak berat'],
            [-8.20531946878947, 113.17486996814337, 'jalan rusak ringan'],
            [-8.20518307371403, 113.1746476681434, 'jalan rusak ringan'],
            [-8.2049796066537, 113.17374365280199, 'jalan rusak berat'],
            [-8.19928369600686, 113.16667945280189, 'jalan rusak berat'],
            [-8.20372255789147, 113.17254747834295, 'jalan rusak ringan'],
            [-8.19958558703847, 113.16727206307439, 'jalan rusak berat'],
            [-8.19804788185248, 113.16478497173593, 'jalan rusak ringan'],
            [-8.1975984634749, 113.16421648526139, 'jalan rusak berat'],
            [-8.19665386682485, 113.16291014435866, 'jalan rusak berat'],
            [-8.19604539761673, 113.16205990727133, 'jalan rusak berat'],
            [-8.19596197838114, 113.16196819074281, 'jalan rusak berat'],
            [-8.19349754154608, 113.15790825213077, 'jalan rusak berat'],
            [-8.19270764937709, 113.15731441842738, 'jalan rusak berat'],
            [-8.1924730046386, 113.1574317768654, 'jalan rusak berat'],
            [-8.19173189805958, 113.15787069741772, 'jalan rusak berat'],
            [-8.19173189805958, 113.15787069741772, 'jalan rusak ringan'],
            [-8.19173189805958, 113.15787069741772, 'jalan rusak berat'],
            [-8.1844933255441, 113.15410243532753, 'jalan rusak berat'],
            [-8.18182621124981, 113.15457891061641, 'jalan rusak berat'],
            [-8.1837075869878, 113.15414705722526, 'jalan rusak ringan'],
            [-8.20802787237037, 113.17600509980660, 'jalan rusak ringan'],
            [-8.20911162867179, 113.17780845971807, 'jalan rusak ringan'],
            [-8.20947345171917, 113.17782159538099, 'jalan rusak ringan'],
            [-8.20949084571963, 113.17782159537950, 'jalan rusak ringan'],
            [-8.20991171773960, 113.17783313812822, 'jalan rusak ringan'],
            [-8.21171397495305, 113.18258920081308, 'jalan rusak ringan'],
            [-8.21174370488054, 113.18279140966845, 'jalan rusak ringan'],
            [-8.21177168960574, 113.18300309646767, 'jalan rusak berat'],
            [-8.212423443922, 113.18512663270613, 'jalan rusak ringan'],
            [-8.212806409903934, 113.18587999177089, 'jalan rusak berat'],
            [-8.213057385123594, 113.18642874383065, 'jalan rusak ringan'],
            [-8.213206223363539, 113.18698364610107, 'jalan rusak berat'],

        ];

        $now = Carbon::now();

        foreach ($data as $item) {
            DB::table('laporan_jalan')->insert([
                'user_id' => 61,
                'lokasi' => "Lat: {$item[0]}, Lng: {$item[1]}",
                'latitude' => $item[0],
                'longitude' => $item[1],
                'jenis_rusak' => $item[2],
                'deskripsi' => null,
                'foto' => null,
                'status' => 'dalam_proses',
                'created_at' => $now,
                'updated_at' => $now,
            ]);
        }
    }
} 