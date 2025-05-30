<div class="sidebar" id="sidebar">
    <!-- <div class="d-flex justify-content-between align-items-center px-3">
        <div class="toggle-btn" onclick="toggleSidebar()">
            <img src="{{ asset('icon/menu-burger.svg') }}" alt="Menu Toggle" class="menu-burger-icon">
        </div>
    </div> -->
    <div class="menu-text no-select">Menu</div>
    <a href="/dashboard" id="dashboard-menu" class="menu-item {{ \Illuminate\Support\Facades\Request::is('dashboard') ? 'active' : '' }}">
        <img src="{{ asset('icon/home.svg') }}" alt="Home Icon" class="home">
        <span>Dashboard</span>
    </a>
    <div class="menu-group">
        <a href="#" id="users-menu" class="menu-item has-submenu {{ \Illuminate\Support\Facades\Request::is('users*') ? 'active' : '' }}" onclick="toggleSubmenu('users')">
            <img src="{{ asset('icon/users-alt.svg') }}" alt="Users Icon" class="icon">
            <span>User</span>
            <i class="submenu-arrow"></i>
        </a>
        <div class="submenu" id="users-submenu" data-menu="users">
            <a href="/users" class="submenu-item {{ \Illuminate\Support\Facades\Request::is('users') ? 'active' : '' }}">Daftar User</a>
        </div>
    </div>
    <div class="menu-group">
        <a href="#" id="reports-menu" class="menu-item has-submenu {{ \Illuminate\Support\Facades\Request::is('bencana') || \Illuminate\Support\Facades\Request::is('jalan') ? 'active' : '' }}" onclick="toggleSubmenu('reports')">
            <img src="{{ asset('icon/megaphone.svg') }}" alt="Reports Icon" class="icon">
            <span>Laporan</span>
            <i class="submenu-arrow"></i>
        </a>
        <div class="submenu" id="reports-submenu" data-menu="reports">
            <a href="/bencana" class="submenu-item {{ \Illuminate\Support\Facades\Request::is('bencana') ? 'active' : '' }}">Laporan Bencana</a>
            <a href="/jalan" class="submenu-item {{ \Illuminate\Support\Facades\Request::is('jalan') ? 'active' : '' }}">Laporan Jalan</a>
        </div>
    </div>
    <div class="menu-group">
        <a href="#" id="admins-menu" class="menu-item has-submenu {{ \Illuminate\Support\Facades\Request::is('admins*') ? 'active' : '' }}" onclick="toggleSubmenu('admins')">
            <img src="{{ asset('icon/users.svg') }}" alt="Admins Icon" class="icon">
            <span>Admin</span>
            <i class="submenu-arrow"></i>
        </a>
        <div class="submenu" id="admins-submenu" data-menu="admins">
            <a href="/admins" class="submenu-item {{ \Illuminate\Support\Facades\Request::is('admins') ? 'active' : '' }}">Daftar Admin</a>
        </div>
    </div>
</div>

<!-- @push('styles')
<style>
.sidebar {
    height: 100vh;
    width: 250px;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #2c3e50;
    color: #ecf0f1;
    transition: all 0.3s ease;
    overflow-y: auto;
    z-index: 1000;
}

.sidebar.collapsed {
    width: 60px;
}

.menu-text {
    padding: 20px 15px;
    font-size: 18px;
    font-weight: 600;
    border-bottom: 1px solid #34495e;
}

/* Style default untuk menu item (non-active) */
.menu-item {
    display: flex;
    align-items: center;
    padding: 12px 15px;
    color: #2c3e50;
    text-decoration: none;
    transition: all 0.3s ease;
    position: relative;
    background-color: transparent;
    margin: 5px 10px;
    border-radius: 10px;
    border: 1px solid transparent;
}

/* Hover effect */
.menu-item:hover {
    background-color: rgba(249, 196, 22, 0.1);
    color: #F9C416;
    text-decoration: none;
}

/* Active state */
.menu-item.active {
    background-color: #F9C416;
    color: #2c3e50;
    border-color: #F9C416;
    font-weight: 600;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.menu-item img {
    width: 20px;
    height: 20px;
    margin-right: 10px;
    transition: all 0.3s ease;
    opacity: 0.7;
}

.menu-item:hover img {
    opacity: 1;
}

.menu-item.active img {
    opacity: 1;
    filter: brightness(0.8);
}

.menu-item span {
    flex-grow: 1;
    font-weight: 500;
}

.menu-item.active span {
    font-weight: 600;
}

.submenu-arrow {
    border: solid #7c8ca5;
    border-width: 0 2px 2px 0;
    display: inline-block;
    padding: 3px;
    transform: rotate(45deg);
    transition: transform 0.3s ease;
}

.menu-item.active .submenu-arrow {
    transform: rotate(-135deg);
    border-color: #2c3e50;
}

.submenu {
    background-color: transparent;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease;
}

.submenu.show {
    max-height: 200px;
}

/* Style untuk submenu items */
.submenu-item {
    display: block;
    padding: 10px 15px 10px 45px;
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    transition: all 0.3s ease;
    border-left: 4px solid transparent;
}

.submenu-item:hover {
    background-color: rgba(249, 196, 22, 0.1);
    color: #F9C416;
    text-decoration: none;
}

.submenu-item.active {
    background-color: rgba(249, 196, 22, 0.1);
    color: #F9C416;
    border-left: 4px solid #F9C416;
    font-weight: 600;
}

.menu-group {
    border-bottom: 1px solid #34495e;
}

.toggle-btn {
    cursor: pointer;
    padding: 10px;
}

.toggle-btn img {
    width: 24px;
    height: 24px;
    filter: invert(1);
}

.sidebar.collapsed .menu-text,
.sidebar.collapsed .submenu,
.sidebar.collapsed .menu-item span,
.sidebar.collapsed .submenu-arrow {
    display: none;
}

.sidebar.collapsed .menu-item {
    padding: 15px;
    justify-content: center;
}

.sidebar.collapsed .menu-item img {
    margin: 0;
}

@media (max-width: 768px) {
    .sidebar {
        width: 60px;
        transform: translateX(-100%);
    }

    .sidebar.active {
        transform: translateX(0);
    }

    .menu-item {
        padding: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        width: 45px;
        height: 45px;
        margin: 5px auto;
    }

    .menu-item .icon {
        width: 24px;
        height: 24px;
        margin: 0;
    }

    .menu-item span {
        display: none;
    }

    .submenu {
        position: fixed;
        left: 60px;
        background: white;
        width: 180px;
        padding: 8px;
        box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        border-radius: 10px;
        display: none;
    }

    .submenu.show {
        display: block;
    }

    .submenu-item {
        padding: 10px 15px;
        display: block;
        color: #333;
        text-decoration: none;
        border-radius: 5px;
    }

    .submenu-item:hover {
        background-color: #f8f9fa;
    }
}
</style>
@endpush -->

@push('scripts')
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const isMobile = window.innerWidth <= 768;
        checkSidebarCollapse();
        window.addEventListener('resize', checkSidebarCollapse);
        

        function resetActiveStates() {
            document.querySelectorAll('.menu-item').forEach(item => {
                item.classList.remove('active');
            });
            document.querySelectorAll('.submenu-item').forEach(item => {
                item.classList.remove('active');
            });
        }

        function setActiveStatesByPath() {
            resetActiveStates();

            if (currentPath === '/dashboard') {
                document.getElementById('dashboard-menu').classList.add('active');
            }

            const menuMappings = {
                'map': ['/laporanjalan', '/laporanbencana'],
                'users': ['/users'],
                'reports': ['/bencana', '/jalan'],
                'admins': ['/admins']
            };

            for (const [menuId, paths] of Object.entries(menuMappings)) {
                if (paths.some(path => currentPath.startsWith(path))) {
                    const menuItem = document.getElementById(menuId + '-menu');
                    const submenu = document.getElementById(menuId + '-submenu');
                    if (menuItem && submenu) {
                        menuItem.classList.add('active');
                        if (!isMobile) {
                            submenu.classList.add('show');
                        }
                    }
                    const submenuItem = document.querySelector(`.submenu-item[href="${currentPath}"]`);
                    if (submenuItem) {
                        submenuItem.classList.add('active');
                    }
                }
            }
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('main.grow');
            const navbar = document.querySelector('.navbar .dashboard-text');

            sidebar.classList.toggle('collapsed');

            if (window.innerWidth <= 768) {
                // Jika di mode mobile, padding tetap 50px tanpa perubahan
                navbar.style.paddingLeft = '0px';
                mainContent.style.paddingLeft = '0px';
            } else {
                // Jika di mode desktop, padding menyesuaikan kondisi sidebar
                if (sidebar.classList.contains('collapsed')) {
                    navbar.style.paddingLeft = '30px';
                    mainContent.style.paddingLeft = '0px';
                } else {
                    navbar.style.paddingLeft = '190px';
                    mainContent.style.paddingLeft = '220px';
                }
            }
        }


        function toggleSubmenu(menuId) {
            const targetSubmenu = document.getElementById(menuId + '-submenu');
            const allSubmenus = document.querySelectorAll('.submenu');

            allSubmenus.forEach(submenu => {
                if (submenu !== targetSubmenu) {
                    submenu.classList.remove('show');
                }
            });

            if (targetSubmenu) {
                targetSubmenu.classList.toggle('show');
            }
        }

        function checkSidebarCollapse() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('main.grow');
            const navbar = document.querySelector('.navbar .dashboard-text');

            if (window.innerWidth <= 768) {
                sidebar.classList.add('collapsed');
                navbar.style.paddingLeft = '0px';
                mainContent.style.paddingLeft = '0px';
            } else {
                sidebar.classList.remove('collapsed');
                navbar.style.paddingLeft = '190px';
                mainContent.style.paddingLeft = '220px';
            }
        }

        window.addEventListener('resize', function() {
            const newIsMobile = window.innerWidth <= 768;
            if (newIsMobile !== isMobile) {
                location.reload();
            }
        });

        setActiveStatesByPath();

        window.toggleSidebar = toggleSidebar;
        window.toggleSubmenu = toggleSubmenu;

        
    });
</script>
@endpush