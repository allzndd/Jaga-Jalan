<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JenisBencanaSeeder extends Seeder
{
    public function run()
    {
        $jenisBencana = [
            ['nama' => 'Banjir'],
            ['nama' => 'Longsor'],
            ['nama' => 'Erupsi'],
            ['nama' => 'Lahar Panas'],
            ['nama' => 'Lahar Dingin'],
            ['nama' => 'Gempa'],
            ['nama' => 'Angin Topan'],
        ];

        foreach ($jenisBencana as $jenis) {
            DB::table('jenis_bencana')->insert([
                'nama' => $jenis['nama'],
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
} 