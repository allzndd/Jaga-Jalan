<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    @auth
    <meta name="user-id" content="{{ Auth::id() }}">
    @endauth
    <title>@yield('title', 'Dashboard Admin')</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="{{ asset('icon/icon.png') }}">
    
    <!-- CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="{{ asset('styles.css') }}">
    <link rel="stylesheet" href="{{ asset('css/sidebar.css') }}">
    <link rel="stylesheet" href="{{ asset('css/header.css') }}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    @stack('styles')
</head>
<body class="font-inter antialiased bg-gray-100 dark:bg-gray-900 text-gray-600 dark:text-gray-400" :class="{ 'sidebar-expanded': sidebarExpanded }" x-data="{ sidebarOpen: false, sidebarExpanded: localStorage.getItem('sidebar-expanded') == 'true' }" x-init="$watch('sidebarExpanded', value => localStorage.setItem('sidebar-expanded', value))">

    <!-- Header dengan memanggil file partial -->
    @include('partials.header')

    <!-- Page wrapper -->
    <div class="flex h-[100dvh] overflow-hidden">
        @include('partials.sidebar', ['variant' => isset($attributes) ? $attributes['sidebarVariant'] : 'defaultVariant'])

        <!-- Area konten -->
        <div class="relative flex flex-col flex-1 overflow-y-auto overflow-x-hidden @if(isset($attributes['background'])){{ $attributes['background'] }}@else{{ 'bg-default' }}@endif" x-ref="contentarea">
            <main class="grow mx-4 my-4">
                @yield('content')
            </main>
        </div>
    </div>

    <!-- @livewireScriptConfig -->

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
    <script>
        // Setup AJAX CSRF token
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        // Fungsi toggle sidebar yang disederhanakan
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('active');
            console.log('Toggle sidebar:', sidebar.classList.contains('active')); // Debug
        }

        // Event listener untuk menutup sidebar saat klik di luar
        document.addEventListener('click', function(e) {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.querySelector('.mobile-toggle');
            
            // Jika klik di luar sidebar dan bukan di toggle button
            if (!sidebar.contains(e.target) && !toggleBtn.contains(e.target)) {
                sidebar.classList.remove('active');
            }
        });

        // Profile dropdown
        document.getElementById('profile-menu').addEventListener('click', function(e) {
            e.stopPropagation();
            const dropdownMenu = document.querySelector('.profile .dropdown-menu');
            dropdownMenu.style.display = dropdownMenu.style.display === 'none' ? 'block' : 'none';
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            const dropdownMenu = document.querySelector('.profile .dropdown-menu');
            const profileMenu = document.getElementById('profile-menu');
            
            if (!profileMenu.contains(e.target)) {
                dropdownMenu.style.display = 'none';
            }
        });
        
        // Event listener untuk notifikasi real-time
        document.addEventListener('notificationReceived', function(e) {
            console.log('Notification received event triggered:', e.detail);
            // Anda bisa menambahkan logika tambahan di sini
            // misalnya memperbarui badge notifikasi atau menampilkan toast notification
        });
    </script>
    
    @stack('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html> 