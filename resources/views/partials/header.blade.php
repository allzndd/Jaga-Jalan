<div class="navbar">
    <div class="container-fluid px-3">
        <div class="toggle-btn" onclick="toggleSidebar()">
            <img src="{{ asset('icon/menu-burger.svg') }}" alt="Menu Toggle" class="menu-burger-icon">
        </div>
        <a href="{{ url()->current() }}" class="dashboard-text no-select">@yield('page-title')</a>
        
        <!-- Menampilkan nama pengguna yang login -->
        @if(Auth::check())
            <div class="notifications-dropdown mr-3">
                <div class="notification-icon" id="notificationDropdown">
                    <i class="fas fa-bell"></i>
                    @php
                        $notifications = \Illuminate\Notifications\DatabaseNotification::where('notifiable_id', Auth::id())
                            ->orderBy('created_at', 'desc')
                            ->get();
                        
                        $unreadCount = $notifications->whereNull('read_at')->count();
                        
                        // Debug untuk melihat data
                        // dd([
                        //     'user_id' => Auth::id(),
                        //     'notifications' => $notifications,
                        //     'unread_count' => $unreadCount
                        // ]);
                    @endphp
                    @if($unreadCount > 0)
                        <span class="badge badge-danger" id="notification-badge">{{ $unreadCount }}</span>
                    @else
                        <span class="badge badge-danger" id="notification-badge" style="display: none;">0</span>
                    @endif
                </div>
                <div class="dropdown-menu notification-menu" style="display: none;">
                    <div class="notification-header">
                        <span>Notifikasi</span>
                        <div class="notification-actions">
                            @if($unreadCount > 0)
                                <a href="#" class="mark-all-read">Tandai sudah dibaca semua</a>
                            @endif
                            <a href="#" class="delete-read-notifications">Hapus yang sudah dibaca</a>
                        </div>
                    </div>
                    <div class="notification-list">
                        @forelse($notifications as $notification)
                            <div class="notification-item {{ is_null($notification->read_at) ? 'unread' : 'read' }}"
                                 data-notification-id="{{ $notification->id }}"
                                 data-type="{{ $notification->data['type'] ?? '' }}">
                                <div class="notification-content">
                                    {{ $notification->data['message'] }}
                                    <small class="text-muted d-block">
                                        {{ \Carbon\Carbon::parse($notification->created_at)->diffForHumans() }}
                                    </small>
                                </div>
                            </div>
                        @empty
                            <div class="no-notifications">
                                Tidak ada notifikasi
                            </div>
                        @endforelse
                    </div>
                </div>
            </div>
        @endif
        
        @if(Auth::check())
            <div class="profile float-right">
                
                <img src="{{ asset('icon/profile.png') }}" alt="Profile" width="40" height="40" id="profile-menu">
                <div class="dropdown-menu" style="display: none;">
                    <a class="dropdown-item" href="/logout" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">Logout</a>
                    <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                        @csrf
                    </form>
                </div>
                <div class="mr-3">{{ Auth::user()->name }}</div>
            </div>
        @else
            <div class="profile float-right">
                <img src="{{ asset('icon/profile.png') }}" alt="Profile" width="40" height="40" id="profile-menu">
                <div class="dropdown-menu" style="display: none;">
                    <a class="dropdown-item" href="/login">Login</a>
                    <a class="dropdown-item" href="/register">Register</a>
                </div>
            </div>
        @endif
        
        <!-- Elemen audio untuk suara notifikasi -->
        <audio id="notification-sound" preload="auto">
            <source src="{{ asset('icon/notifikasi.mp3') }}" type="audio/mpeg">
            <source src="{{ asset('icon/notifikasi.wav') }}" type="audio/wav">
        </audio>
        
        <script src="https://js.pusher.com/7.0/pusher.min.js"></script>
        <script>
            // Script di bawah ini harus ditambahkan di bagian atas untuk memastikan CSRF token tersedia
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            // Inisialisasi Pusher dengan konfigurasi yang benar
            var pusher = new Pusher('d82783da6b2fe32e1dec', {
                cluster: 'ap1',
                authEndpoint: '/broadcasting/auth',
                auth: {
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                },
                // Tambahkan opsi debug untuk melihat log Pusher di console browser
                enabledTransports: ['ws', 'wss'],
                forceTLS: true,
                enableLogging: true
            });

            // Mendengarkan channel publik laporan-channel
            var laporanChannel = pusher.subscribe('laporan-channel');
            laporanChannel.bind('LaporanDibuat', function(data) {
                console.log('Laporan baru diterima:', data);
                showToast('Laporan baru: ' + (data.laporan.jenis_bencana || data.laporan.jenis_rusak || 'Laporan'));
                // Play notification sound
                playNotificationSound();
            });
            
            // Mendengarkan notifikasi real-time pada private channel
            @if(Auth::check())
            console.log('Subscribing to private-notifications.{{ Auth::id() }}');
            var notificationChannel = pusher.subscribe('private-notifications.{{ Auth::id() }}');
            
            notificationChannel.bind('notification.received', function(data) {
                console.log('Notifikasi baru diterima:', data);
                
                // Update badge count
                var badge = document.getElementById('notification-badge');
                var currentCount = parseInt(badge.innerText) || 0;
                badge.innerText = currentCount + 1;
                badge.style.display = 'block';
                
                // Tambahkan notifikasi baru ke daftar
                var notificationList = document.querySelector('.notification-list');
                var noNotificationsMsg = document.querySelector('.no-notifications');
                
                if (noNotificationsMsg) {
                    noNotificationsMsg.remove();
                }
                
                // Format waktu dengan Carbon
                var timeAgo = 'baru saja';
                
                // Buat elemen notifikasi baru
                var newNotification = document.createElement('div');
                newNotification.className = 'notification-item unread';
                newNotification.dataset.notificationId = data.notification.id;
                newNotification.dataset.type = data.notification.data.type || '';
                
                newNotification.innerHTML = `
                    <div class="notification-content">
                        ${data.notification.data.message}
                        <small class="text-muted d-block">${timeAgo}</small>
                    </div>
                `;
                
                // Tambahkan ke awal daftar
                if (notificationList.firstChild) {
                    notificationList.insertBefore(newNotification, notificationList.firstChild);
                } else {
                    notificationList.appendChild(newNotification);
                }
                
                // Tambahkan tombol "Tandai sudah dibaca semua" jika belum ada
                var markAllReadBtn = document.querySelector('.mark-all-read');
                var notificationActions = document.querySelector('.notification-actions');
                if (!markAllReadBtn && notificationActions) {
                    var newMarkAllBtn = document.createElement('a');
                    newMarkAllBtn.href = '#';
                    newMarkAllBtn.className = 'mark-all-read';
                    newMarkAllBtn.innerText = 'Tandai sudah dibaca semua';
                    
                    // Tambahkan event listener ke tombol baru
                    newMarkAllBtn.addEventListener('click', handleMarkAllRead);
                    
                    notificationActions.insertBefore(newMarkAllBtn, notificationActions.firstChild);
                }
                
                // Tambahkan juga event listener untuk notifikasi baru
                newNotification.addEventListener('click', function() {
                    handleNotificationClick(this);
                });
                
                // Tampilkan notifikasi toast
                showToast('Notifikasi baru: ' + data.notification.data.message);
                
                // Play notification sound
                playNotificationSound();
            });

            // Debug untuk pusher errors
            pusher.connection.bind('error', function(err) {
                console.error('Pusher connection error:', err);
            });

            // Debug connection state
            pusher.connection.bind('state_change', function(states) {
                console.log('Pusher state changed from', states.previous, 'to', states.current);
            });
            @endif
            
            // Fungsi untuk memainkan suara notifikasi
            function playNotificationSound() {
                var sound = document.getElementById('notification-sound');
                if (sound) {
                    sound.currentTime = 0; // Reset audio ke awal
                    sound.play().catch(function(error) {
                        console.log('Gagal memainkan suara notifikasi:', error);
                    });
                }
            }
            
            // Fungsi untuk menampilkan toast notifikasi
            function showToast(message) {
                // Cek apakah elemen toast container sudah ada
                var toastContainer = document.getElementById('toast-container');
                if (!toastContainer) {
                    // Buat container untuk toast
                    toastContainer = document.createElement('div');
                    toastContainer.id = 'toast-container';
                    toastContainer.style.position = 'fixed';
                    toastContainer.style.top = '20px';
                    toastContainer.style.right = '20px';
                    toastContainer.style.zIndex = '9999';
                    document.body.appendChild(toastContainer);
                }
                
                // Buat toast notifikasi
                var toast = document.createElement('div');
                toast.className = 'toast-notification';
                toast.innerHTML = message;
                toast.style.backgroundColor = '#F9C416';
                toast.style.color = '#333';
                toast.style.padding = '12px 20px';
                toast.style.borderRadius = '5px';
                toast.style.marginBottom = '10px';
                toast.style.boxShadow = '0 2px 8px rgba(0,0,0,0.2)';
                toast.style.minWidth = '250px';
                toast.style.opacity = '0';
                toast.style.transition = 'opacity 0.3s ease';
                
                // Tambahkan toast ke container
                toastContainer.appendChild(toast);
                
                // Tampilkan toast dengan animasi
                setTimeout(function() {
                    toast.style.opacity = '1';
                }, 10);
                
                // Hilangkan toast setelah 5 detik
                setTimeout(function() {
                    toast.style.opacity = '0';
                    setTimeout(function() {
                        toastContainer.removeChild(toast);
                    }, 300);
                }, 5000);
            }
        </script>
    </div>
</div>

<style>
.notifications-dropdown {
    position: relative;
    display: inline-block;
}

.notification-icon {
    cursor: pointer;
    padding: 8px;
    position: relative;
}

.notification-icon .badge {
    position: absolute;
    top: 0;
    right: 0;
    font-size: 10px;
}

.notification-menu {
    position: absolute;
    right: 0;
    width: 300px;
    max-height: 400px;
    overflow-y: auto;
    background: white;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    z-index: 1000;
}

.notification-header {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #f8f9fa;
}

.notification-list {
    padding: 0;
}

.notification-item {
    padding: 10px;
    border-bottom: 1px solid #eee;
    cursor: pointer;
}

.notification-item:hover {
    background-color: #f8f9fa;
}

.notification-item.unread {
    background-color: #f0f7ff;
}

.notification-content {
    font-size: 14px;
}

.no-notifications {
    padding: 20px;
    text-align: center;
    color: #666;
}

.mark-all-read {
    color: #007bff;
    font-size: 12px;
    text-decoration: none;
}

.mark-all-read:hover {
    text-decoration: underline;
}

.notification-actions {
    display: flex;
    gap: 10px;
    font-size: 12px;
}

.delete-read-notifications {
    color: #dc3545;
    text-decoration: none;
}

.delete-read-notifications:hover {
    text-decoration: underline;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const notificationDropdown = document.getElementById('notificationDropdown');
    const notificationMenu = document.querySelector('.notification-menu');

    if (notificationDropdown && notificationMenu) {
        notificationDropdown.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            notificationMenu.style.display = notificationMenu.style.display === 'none' ? 'block' : 'none';
        });

        document.addEventListener('click', function(e) {
            if (!e.target.closest('.notifications-dropdown')) {
                notificationMenu.style.display = 'none';
            }
        });
    }

    // Mark notification as read dan redirect
    function handleNotificationClick(item) {
        const notificationId = item.dataset.notificationId;
        const notificationType = item.dataset.type;
        
        // Mark as read
        fetch('/notifications/' + notificationId + '/mark-as-read', {
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': '{{ csrf_token() }}',
                'Content-Type': 'application/json'
            }
        });

        // Redirect berdasarkan tipe notifikasi
        if (notificationType === 'jalan') {
            window.location.href = 'https://jagajalan.oyi.web.id/jalan';
        } else if (notificationType === 'bencana') {
            window.location.href = 'https://jagajalan.oyi.web.id/bencana';
        }
    }
    
    // Attach click handler to all existing notification items
    document.querySelectorAll('.notification-item').forEach(item => {
        item.addEventListener('click', function() {
            handleNotificationClick(this);
        });
    });

    // Tambahkan event listener untuk menandai semua notifikasi sebagai sudah dibaca
    function handleMarkAllRead(e) {
        e.preventDefault();
        fetch('/notifications/mark-all-read', {
            method: 'POST',
            headers: {
                'X-CSRF-TOKEN': '{{ csrf_token() }}',
                'Content-Type': 'application/json'
            }
        }).then(response => {
            if (response.ok) {
                // Update UI
                document.querySelectorAll('.notification-item.unread').forEach(item => {
                    item.classList.remove('unread');
                    item.classList.add('read');
                });
                // Sembunyikan badge notifikasi
                const badge = document.querySelector('.notification-icon .badge');
                if (badge) {
                    badge.innerText = '0';
                    badge.style.display = 'none';
                }
                // Sembunyikan tombol mark-all-read
                const markAllReadBtn = document.querySelector('.mark-all-read');
                if (markAllReadBtn) {
                    markAllReadBtn.style.display = 'none';
                }
            }
        });
    }
    
    const markAllReadBtn = document.querySelector('.mark-all-read');
    if (markAllReadBtn) {
        markAllReadBtn.addEventListener('click', handleMarkAllRead);
    }

    // Tambahkan event listener untuk menghapus notifikasi yang sudah dibaca
    const deleteReadBtn = document.querySelector('.delete-read-notifications');
    if (deleteReadBtn) {
        deleteReadBtn.addEventListener('click', function(e) {
            e.preventDefault();
            if (confirm('Apakah Anda yakin ingin menghapus semua notifikasi yang sudah dibaca?')) {
                fetch('/notifications/delete-read', {
                    method: 'POST',
                    headers: {
                        'X-CSRF-TOKEN': '{{ csrf_token() }}',
                        'Content-Type': 'application/json'
                    }
                }).then(response => {
                    if (response.ok) {
                        // Hapus notifikasi yang sudah dibaca dari tampilan
                        document.querySelectorAll('.notification-item.read').forEach(item => {
                            item.remove();
                        });
                        
                        // Jika tidak ada notifikasi yang tersisa, tampilkan pesan
                        const notificationList = document.querySelector('.notification-list');
                        if (notificationList && notificationList.children.length === 0) {
                            notificationList.innerHTML = '<div class="no-notifications">Tidak ada notifikasi</div>';
                        }
                    }
                });
            }
        });
    }
});
</script> 

<script>
setInterval(function() {
  fetch('/get-notifications-count', {
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    var currentCount = parseInt(document.getElementById('notification-badge').innerText || '0');
    console.log('Current count:', currentCount, 'New count:', data.count);
    
    if (data.count > currentCount) {
      // Ada notifikasi baru, play sound dulu baru refresh
      try {
        console.log('Mencoba memainkan suara notifikasi...');
        var sound = document.getElementById('notification-sound');
        if (sound) {
          // Mengatasi masalah autoplay policy
          var playPromise = sound.play();
          
          if (playPromise !== undefined) {
            playPromise.then(() => {
              console.log('Suara notifikasi berhasil diputar');
              // Berikan waktu untuk suara terdengar
              setTimeout(function() {
                console.log('Refreshing halaman...');
                location.reload();
              }, 1500);
            }).catch(error => {
              console.error('Autoplay diblokir atau error:', error);
              // Tetap refresh meskipun suara gagal diputar
              location.reload();
            });
          } else {
            // Browser lama yang tidak mengembalikan promise
            console.log('Browser lama, langsung refresh');
            setTimeout(function() {
              location.reload();
            }, 1000);
          }
        } else {
          console.error('Elemen audio tidak ditemukan!');
          location.reload();
        }
      } catch (e) {
        console.error('Error saat memainkan notifikasi:', e);
        location.reload();
      }
    }
  })
  .catch(error => {
    console.log('Error checking notifications:', error);
  });
}, 3000); // Check setiap 3 detik
</script> 
