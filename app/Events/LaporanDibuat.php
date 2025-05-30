<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Models\User;

class LaporanDibuat implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $laporan;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($laporan)
    {
        $this->laporan = $laporan;
        
        // Send notification to all admins immediately
        $admins = \App\Models\User::where('tipe_pengguna', 'admin')
            ->orWhere('tipe_pengguna', 'super admin')
            ->get();
            
        foreach ($admins as $admin) {
            // Trigger NewNotification event for each admin
            event(new NewNotification([
                'id' => uniqid(),
                'data' => [
                    'message' => 'Laporan baru telah dibuat: ' . ($laporan->jenis_bencana ?? $laporan->jenis_rusak),
                    'type' => isset($laporan->jenis_bencana) ? 'bencana' : 'jalan',
                    'created_at' => now()->toIso8601String()
                ],
                'notifiable_id' => $admin->id,
                'created_at' => now()
            ], $admin->id));
        }
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        // Broadcast to public channel
        return new Channel('laporan-channel');
    }

    /**
     * Get the data to broadcast.
     *
     * @return array
     */
    public function broadcastWith()
    {
        return [
            'laporan' => $this->laporan
        ];
    }
}