<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Notifications\DatabaseNotification;
use Tymon\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'alamat',
        'tipe_pengguna',
        'instansi',
        'jabatan',
        'is_verified',
        'verification_token',
        'updated_at',
        'role',
        'reset_password_token',
        'reset_password_expires_at'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    public function isAdmin()
    {
        return $this->tipe_pengguna === 'admin' || $this->tipe_pengguna === 'super admin';
    }

    public static function getJabatanOptions($instansi = null)
    {
        $jabatanOptions = [
            'BPBD' => [
                'Kepala Seksi Kedaruratan dan Logistik' => 'Bertanggung jawab atas penanganan darurat bencana.',
                'Operator Pusdalops (Pusat Pengendalian Operasi)' => 'Mengelola data dan sistem informasi kebencanaan.',
                'Staf Kedaruratan dan Rehabilitasi' => 'Memverifikasi laporan masyarakat terkait bencana.',
                'Koordinator Tim Reaksi Cepat (TRC)' => 'Menilai dan menindaklanjuti laporan yang masuk.'
            ],
            'PUPR' => [
                'Kepala Bidang Bina Marga' => 'Bertanggung jawab atas pemeliharaan dan pembangunan jalan.',
                'Kepala Seksi Pemeliharaan Jalan dan Jembatan' => 'Menangani perbaikan jalan berlubang.',
                'Staf Pengawas Infrastruktur' => 'Mengevaluasi kondisi jalan berdasarkan laporan masyarakat.',
                'Operator GIS (Geographic Information System)' => 'Mengelola data berbasis peta (Leaflet.js).'
            ]
        ];
        
        if ($instansi && isset($jabatanOptions[$instansi])) {
            return $jabatanOptions[$instansi];
        }
        
        return $jabatanOptions;
    }

    public static function getInstansiOptions()
    {
        return ['BPBD', 'PUPR'];
    }
}