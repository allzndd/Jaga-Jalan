<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Events\NewNotification;
use Illuminate\Support\Carbon;
use Illuminate\Http\JsonResponse;

class NotificationController extends Controller
{
    public function getNotificationsCount()
    {
        $count = DB::table('notifications')
            ->where('notifiable_id', Auth::id())
            ->whereNull('read_at')
            ->count();
            
        return response()->json(['count' => $count]);
    }
    
    public function deleteRead()
    {
        DB::table('notifications')
            ->where('notifiable_id', Auth::id())
            ->whereNotNull('read_at')
            ->delete();

        return response()->json(['message' => 'Notifikasi yang sudah dibaca berhasil dihapus']);
    }
    
    public function markAsRead($id)
    {
        $notification = DB::table('notifications')->where('id', $id)->first();
        
        if ($notification && $notification->notifiable_id == Auth::id()) {
            DB::table('notifications')
                ->where('id', $id)
                ->update(['read_at' => Carbon::now()]);
                
            return response()->json(['message' => 'Notifikasi ditandai sebagai sudah dibaca']);
        }
        
        return response()->json(['message' => 'Notifikasi tidak ditemukan'], 404);
    }
    
    public function markAllRead()
    {
        DB::table('notifications')
            ->where('notifiable_id', Auth::id())
            ->whereNull('read_at')
            ->update(['read_at' => Carbon::now()]);
            
        return response()->json(['message' => 'Semua notifikasi ditandai sebagai sudah dibaca']);
    }
} 