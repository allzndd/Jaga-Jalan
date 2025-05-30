<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    public function run()
    {
        Admin::create([
            'name' => 'Super Admin',
            'email' => 'admin@admin.com',
            'password' => Hash::make('admin123'),
            'alamat' => 'Alamat Admin',
            'telepon' => '08123456789',
            'tipe_pengguna' => 'admin',
        ]);
    }
} 