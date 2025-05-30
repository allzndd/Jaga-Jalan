<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css"> <!-- Tautkan file CSS terpisah -->
</head>

<body>
    <div class="sidebar" id="sidebar">
        <div class="d-flex justify-content-between align-items-center px-3">
            <div class="toggle-btn" onclick="toggleSidebar()">
                <img src="icon/menu-burger.svg" alt="Menu Toggle" class="menu-burger-icon">
            </div>
        </div>
        <div class="menu-text no-select">Menu</div>
        <a href="#" onclick="toggleMenu('dashboard')" id="dashboard-menu">
            <img src="icon/home.svg" alt="Home Icon" class="icon">Dashboard
        </a>
        <div class="submenu" id="dashboard-submenu">
            <a href="/dashboard" id="grafik-menu">Grafik</a>
            <a href="/pemetaan" id="pemetaan-menu">Pemetaan</a>
        </div>
        <a href="#" onclick="toggleMenu('users')" id="users-menu">
            <img src="icon/users-alt.svg" alt="Users Icon" class="icon">User
        </a>
        <div class="submenu" id="users-submenu">
            <a href="/users" id="users-list-menu">Daftar User</a>
        </div>
        <a href="#" onclick="toggleMenu('reports')" id="reports-menu">
            <img src="icon/megaphone.svg" alt="Reports Icon" class="icon">Laporan
        </a>
        <div class="submenu" id="reports-submenu">
            <a href="/bencana" id="reports-list-menu">Laporan Bencana</a>
            <a href="/jalan" id="reports-list-menu">Laporan Jalan</a>
        </div>
        <a href="#" onclick="toggleMenu('admins')" id="admins-menu">
            <img src="icon/users.svg" alt="Admins Icon" class="icon">Admin
        </a>
        <div class="submenu" id="admins-submenu">
            <a href="/admins" id="admins-list-menu">Daftar Admin</a>
        </div>
    </div>

    <div class="main-content" id="main-content">
        <div class="navbar">
            <div class="container">
                <a href="/dashboard" class="dashboard-text no-select">Dashboard</a>
                <div class="profile float-right">
                    <img src="icon/profile.png" alt="Profile" width="40" height="40" id="profile-menu">
                    <div class="dropdown-menu" style="display: none;">
                        <a class="dropdown-item" href="/profile">Profile</a>
                        <a class="dropdown-item" href="/logout" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">Logout</a>
                        <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display: none;">
                            @csrf
                        </form>
                    </div>
                </div>
            </div>  
        </div>


        <div class="container mt-4">
            <div class="map">
                <h4 class="text-center pt-4">Peta Lokasi</h4>
                <!-- Placeholder for Map -->
                <div id="map"></div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('main-content');
            if (sidebar.classList.contains('collapsed')) {
                sidebar.classList.remove('collapsed');
                mainContent.style.marginLeft = '200px';
            } else {
                sidebar.classList.add('collapsed');
                mainContent.style.marginLeft = '50px';
            }
        }


        function toggleMenu(menuId) {
            const submenus = document.querySelectorAll('.submenu');
            const menus = document.querySelectorAll('.sidebar a');
            const activeMenu = document.querySelector('.sidebar a.active');
            const activeSubmenu = document.querySelector('.submenu.show');

            // Hide all submenus and remove active class from all menu items
            submenus.forEach(submenu => submenu.classList.remove('show'));
            menus.forEach(menu => menu.classList.remove('active'));

            const menu = document.getElementById(menuId + '-menu');
            const submenu = document.getElementById(menuId + '-submenu');

            if (activeMenu && activeMenu.id === menuId + '-menu') {
                // If the clicked menu is already active, hide its submenu
                menu.classList.remove('active');
                submenu.classList.add('hide');
                setTimeout(() => submenu.classList.remove('hide'), 300);
            } else {
                // Show the submenu for the clicked menu and hide others
                menu.classList.add('active');
                submenu.classList.remove('hide');
                submenu.classList.add('show');
            }
        }

        function activateMenu(menuId) {
            const menu = document.getElementById(menuId);
            const activeMenu = document.querySelector('.sidebar a.active');
            const activeSubmenu = document.querySelector('.submenu.show');

            if (activeMenu) {
                activeMenu.classList.remove('active');
                if (activeSubmenu) {
                    activeSubmenu.classList.remove('show');
                    activeSubmenu.classList.add('hide');
                }
            }

            menu.classList.add('active');
        }

        document.getElementById('profile-menu').addEventListener('click', function() {
            const dropdownMenu = document.querySelector('.profile .dropdown-menu');
            if (dropdownMenu.style.display === 'none') {
                dropdownMenu.style.display = 'block';
            } else {
                dropdownMenu.style.display = 'none';
            }
        });

        // Add your map initialization code here
        function initMap() {
            var location = {
                lat: -7.9528,
                lng: 113.6875
            }; // Coordinates of Lumajang
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 10,
                center: location
            });
            var marker = new google.maps.Marker({
                position: location,
                map: map
            });
        }
    </script>

    <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>
</body>

</html>