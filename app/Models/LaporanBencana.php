<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class LaporanBencana extends Model
{
    use HasFactory;

    protected $table = 'laporan_bencana';

    protected $fillable = [
        'user_id',
        'lokasi',
        'latitude',
        'longitude',
        'jenis_bencana',
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

    public function admin()
    {
        return $this->belongsTo(Admin::class, 'user_id'); // Jika user_id bisa merujuk ke admin
    }
} 