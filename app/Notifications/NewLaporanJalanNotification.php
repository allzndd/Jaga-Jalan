<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\DatabaseMessage;

class NewLaporanJalanNotification extends Notification
{
    use Queueable;

    protected $laporan;

    public function __construct($laporan)
    {
        $this->laporan = $laporan;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'message' => 'Laporan jalan rusak baru: ' . ucfirst($this->laporan->jenis_rusak),
            'laporan_id' => $this->laporan->id,
            'lokasi' => $this->laporan->lokasi,
            'type' => 'jalan'
        ];
    }
} 