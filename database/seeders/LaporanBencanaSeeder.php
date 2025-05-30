<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\LaporanBencana;
use Carbon\Carbon;

class LaporanBencanaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        LaporanBencana::create([
            'user_id' => 60,
            'lokasi' => 'Lat: -8.238508511114578, Lng: 113.14954286455946',
            'latitude' => -8.238508511114578,
            'longitude' => 113.14954286455946,
            'jenis_bencana' => 'Angin Topan',
            'status' => 'selesai',
            'created_at' => Carbon::parse('2024-10-08'),
            'updated_at' => Carbon::parse('2024-10-08'),
        ]);
    }
}