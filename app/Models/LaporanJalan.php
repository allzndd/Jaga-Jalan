<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class LaporanJalan extends Model
{
    use HasFactory;

    protected $table = 'laporan_jalan';

    protected $fillable = [
        'user_id',
        'lokasi',
        'latitude',
        'longitude',
        'alamat',
        'jenis_rusak',
        'deskripsi',
        'foto',
        'status'
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
} 