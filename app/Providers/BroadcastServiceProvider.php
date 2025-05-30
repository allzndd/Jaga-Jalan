<?php

namespace App\Providers;

use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\ServiceProvider;

class BroadcastServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Broadcast::routes(['middleware' => ['web', 'auth']]);

        // Channel untuk notifikasi pribadi - perhatikan nama channel harus sesuai dengan di JS
        // Pada Pusher, channel private akan otomatis ditambahkan prefix 'private-'
        Broadcast::channel('notifications.{userId}', function ($user, $userId) {
            return (int) $user->id === (int) $userId;
        });

        require base_path('routes/channels.php');
    }
} 