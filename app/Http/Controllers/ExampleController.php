<?php

namespace App\Http\Controllers;

use App\Events\NewNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Carbon;

class ExampleController extends Controller
{
    /**
     * Contoh cara membuat notifikasi baru yang akan dikirim secara real-time
     */
    public function createSampleNotification()
    {
        $userId = Auth::id();
        
        // Membuat notifikasi baru di database
        $notificationId = Str::uuid()->toString();
        DB::table('notifications')->insert([
            'id' => $notificationId,
            'type' => 'App\\Notifications\\SampleNotification',
            'notifiable_type' => 'App\\Models\\User',
            'notifiable_id' => $userId,
            'data' => json_encode([
                'message' => 'Ini adalah contoh notifikasi real-time',
                'type' => 'jalan',
                'created_at' => Carbon::now()->toIso8601String()
            ]),
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now(),
        ]);
        
        // Ambil notifikasi yang baru dibuat
        $notification = DB::table('notifications')->where('id', $notificationId)->first();
        
        // Kirim event ke Pusher untuk pembaruan real-time
        event(new NewNotification($notification, $userId));
        
        return response()->json(['success' => true, 'message' => 'Notifikasi berhasil dibuat']);
    }
} 