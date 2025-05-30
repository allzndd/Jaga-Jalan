<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Menghapus semua data pengguna sebelumnya
        User::query()->delete();

        // Menambahkan data admin
        User::create([
            'name' => 'Admin BPBD',
            'email' => 'admin1@gmail.com',
            'password' => Hash::make('admin123'),
            'alamat' => 'Alamat Admin 1',
            'tipe_pengguna' => 'admin',
            'instansi' => 'BPBD',
            'jabatan' => 'Kepala Seksi Kedaruratan dan Logistik',
        ]);

        User::create([
            'name' => 'Admin PUPR',
            'email' => 'admin2@gmail.com',
            'password' => Hash::make('admin123'),
            'alamat' => 'Alamat Admin 2',
            'tipe_pengguna' => 'admin',
            'instansi' => 'PUPR',
            'jabatan' => 'Kepala Bidang Bina Marga',
        ]);

        User::create([
            'name' => 'Super Admin',
            'email' => 'superadmin@gmail.com',
            'password' => Hash::make('superadmin123'),
            'alamat' => 'Alamat Super Admin',
            'tipe_pengguna' => 'super admin',
            'instansi' => 'BPBD',
            'jabatan' => 'Koordinator Tim Reaksi Cepat (TRC)',
        ]);

        // Menambahkan data pengguna biasa
        $users = [
            ['name' => 'Ahmad Fauzi', 'email' => 'ahmad.fauzi87@gmail.com', 'alamat' => 'Jl. Gajah Mada No. 23, Lumajang'],
            ['name' => 'Siti Rohmah Wati', 'email' => 'siti.rohmah1992@gmail.com', 'alamat' => 'Perumahan Sukodono Indah Blok C-5, Lumajang'],
            ['name' => 'Budi Santoso', 'email' => 'budi.s@gmail.com', 'alamat' => 'Dusun Krajan RT 03/RW 02, Tempeh'],
            ['name' => 'Dewi Lestari', 'email' => 'dewilestari_90@gmail.com', 'alamat' => 'Jl. Ahmad Yani Km 3, Pasirian'],
            ['name' => 'Eko Prasetyo Nugroho', 'email' => 'eko.pras78@gmail.com', 'alamat' => 'Perum Griya Asri Blok D-12, Kunir'],
            ['name' => 'Fitri Handayani', 'email' => 'fitri.h@gmail.com', 'alamat' => 'Jl. Raya Randuagung No. 45, Randuagung'],
            ['name' => 'Gunawan Saputra', 'email' => 'gunawan_s@gmail.com', 'alamat' => 'Desa Tunjung RT 05/RW 01, Yosowilangun'],
            ['name' => 'Hesti Wahyuni Putri', 'email' => 'hestiwahyuni1995@gmail.com', 'alamat' => 'Jl. Pahlawan No. 17, Pasrujambe'],
            ['name' => 'Indra Wijaya', 'email' => 'indra.wijaya85@gmail.com', 'alamat' => 'Perumahan Senduro Asri Blok F-7, Senduro'],
            ['name' => 'Joko Susilo', 'email' => 'joko_s@gmail.com', 'alamat' => 'Dusun Sumbersari RT 02/RW 03, Candipuro'],
            ['name' => 'Kartika Dewi Anggraini', 'email' => 'kartika.d@gmail.com', 'alamat' => 'Jl. Veteran No. 32, Tekung'],
            ['name' => 'Lukman Hakim', 'email' => 'lukman.h1989@gmail.com', 'alamat' => 'Jl. Wijaya Kusuma Gang 3 No. 12, Padang'],
            ['name' => 'Maria Ulfa Rahmawati', 'email' => 'maria_ulfa@gmail.com', 'alamat' => 'Perum Griya Sukodono Blok A-9, Sukodono'],
            ['name' => 'Nugroho Prabowo', 'email' => 'nugroho.p@gmail.com', 'alamat' => 'Desa Wonorejo RT 04/RW 02, Gucialit'],
            ['name' => 'Okta Sari', 'email' => 'okta.sari93@gmail.com', 'alamat' => 'Jl. Kenanga No. 7, Jatiroto'],
            ['name' => 'Prasetya Adi Nugraha', 'email' => 'prasetya_adi@gmail.com', 'alamat' => 'Dusun Karangsari RT 01/RW 04, Tempursari'],
            ['name' => 'Qorina Setiawati', 'email' => 'qorina.s@gmail.com', 'alamat' => 'Jl. Sumberwuluh Gang Mawar No. 3, Pronojiwo'],
            ['name' => 'Rizky Ramadhan Saputra', 'email' => 'rizky.r1994@gmail.com', 'alamat' => 'Perum Griya Ranuyoso Blok B-15, Ranuyoso'],
            ['name' => 'Sulastri Handayani', 'email' => 'sulastri_h@gmail.com', 'alamat' => 'Jl. Anggrek No. 21, Klakah'],
            ['name' => 'Teguh Wicaksono', 'email' => 'teguh.w88@gmail.com', 'alamat' => 'Desa Kalipepe RT 03/RW 01, Rowokangkung'],
            ['name' => 'Umi Salamah Hidayati', 'email' => 'umi.salamah91@gmail.com', 'alamat' => 'Jl. Mawar No. 9, Kedungjajang'],
            ['name' => 'Vina Melati', 'email' => 'vina_melati@gmail.com', 'alamat' => 'Perumahan Kunir Indah Blok G-3, Kunir'],
            ['name' => 'Wahyudi Syahputra Pratama', 'email' => 'wahyudi.s@gmail.com', 'alamat' => 'Jl. Duren No. 15, Lumajang'],
            ['name' => 'Xaverius Angga', 'email' => 'xave.angga90@gmail.com', 'alamat' => 'Perum Tempeh Permai Blok C-8, Tempeh'],
        ];

        foreach ($users as $user) {
            User::create([
                'name' => $user['name'],
                'email' => $user['email'],
                'password' => Hash::make('password123'),
                'alamat' => $user['alamat'],
                'tipe_pengguna' => 'user',
            ]);
        }
    }
}
