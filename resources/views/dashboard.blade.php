@extends('layouts.app')

@section('title', 'Dashboard')
@section('page-title', 'Dashboard')

@section('content')
<link href="{{ asset('css/dashboard.css') }}" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<!-- KPI Cards Row -->
<div class="row mb-4" id="kpiCards">
    <div class="col-xl-3 col-md-6 col-6 mb-3">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-gray-800 text-uppercase mb-1">Total Laporan</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                            <span class="all-total">{{ $totalLaporan ?? 0 }}</span>
                            <span class="jalan-total" style="display: none;">{{ $totalLaporanJalan ?? 0 }}</span>
                            <span class="bencana-total" style="display: none;">{{ $totalLaporanBencana ?? 0 }}</span>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-3 col-md-6 col-6 mb-3">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-gray-800 text-uppercase mb-1">Menunggu</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                            <span class="all-menunggu">{{ $menunggu ?? 0 }}</span>
                            <span class="jalan-menunggu" style="display: none;">{{ $menungguJalan ?? 0 }}</span>
                            <span class="bencana-menunggu" style="display: none;">{{ $menungguBencana ?? 0 }}</span>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-clock fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-3 col-md-6 col-6 mb-3">
        <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-gray-800 text-uppercase mb-1">Dalam Proses</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                            <span class="all-proses">{{ $dalamProses ?? 0 }}</span>
                            <span class="jalan-proses" style="display: none;">{{ $dalamProsesJalan ?? 0 }}</span>
                            <span class="bencana-proses" style="display: none;">{{ $dalamProsesBencana ?? 0 }}</span>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-tools fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-xl-3 col-md-6 col-6 mb-3">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-gray-800 text-uppercase mb-1">Selesai</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800">
                            <span class="all-selesai">{{ $selesai ?? 0 }}</span>
                            <span class="jalan-selesai" style="display: none;">{{ $selesaiJalan ?? 0 }}</span>
                            <span class="bencana-selesai" style="display: none;">{{ $selesaiBencana ?? 0 }}</span>
                        </div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Map Section with Title -->
<div class="card shadow mb-4">
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-gray-800">PEMETAAN KERUSAKAN JALAN DAN BENCANA ALAM DI KABUPATEN LUMAJANG</h6>
    </div>
    <div class="card-body">
        <!-- Filter buttons -->
        <div class="mb-3">
            <button id="filterJalan" class="btn btn-outline-primary mr-2">Laporan Jalan</button>
            <button id="filterBencana" class="btn btn-outline-warning">Laporan Bencana</button>
        </div>
        <div id="map"></div>
    </div>
</div>

<!-- Summary Section -->
<!-- <div class="row">
    <div class="col-xl-8 col-lg-7">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Statistik Bulanan</h6>
            </div>
            <div class="card-body">
                <div id="monthlyChart" style="height: 300px;"></div>
            </div>
        </div>
    </div>
    <div class="col-xl-4 col-lg-5">
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Distribusi Jenis Kerusakan</h6>
            </div>
            <div class="card-body">
                <div id="pieChart" style="height: 300px;"></div>
            </div>
        </div>
    </div>
</div> -->
@endsection

@push('scripts')
<script>
function initMap() {
    var location = [-8.132932, 113.221684]; // Koordinat Lumajang
    var map = L.map('map').setView(location, 10);

    // Set the bounds for the map
    var bounds = [
        [-7.893539, 112.899152], // Utara-Barat
        [-8.349499, 113.379803]  // Selatan-Timur
    ];
    map.setMaxBounds(bounds);

    map.on('drag', function() {
        map.panInsideBounds(bounds, { animate: false });
    });

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        minZoom: 10.5,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    let markers = [];

    function clearMarkers() {
        markers.forEach(marker => map.removeLayer(marker));
        markers = [];
    }

    function addMarker(data, type) {
        let marker;
        
        if (type === 'jalan') {
            const icon = L.icon({
                iconUrl: data.jenis_rusak === 'jalan rusak ringan' 
                    ? '{{ asset("assets/icons/Jalan_rusak_ringan.png") }}'
                    : '{{ asset("assets/icons/Jalan_rusak_berat.png") }}',
                iconSize: [30, 30],
                iconAnchor: [15, 15],
                popupAnchor: [0, -20]
            });
            marker = L.marker([data.latitude, data.longitude], { icon });
        } else {
            // Icon untuk bencana
            const bencanaIcons = {
                'Banjir': '{{ asset("assets/icons/Banjir.png") }}',
                'Longsor': '{{ asset("assets/icons/Longsor.png") }}',
                'Erupsi': '{{ asset("assets/icons/Erupsi.png") }}',
                'Lahar Panas': '{{ asset("assets/icons/Lahar_Panas.png") }}',
                'Lahar Dingin': '{{ asset("assets/icons/Lahar_Dingin.png") }}',
                'Gempa': '{{ asset("assets/icons/Gempa.png") }}',
                'Angin Topan': '{{ asset("assets/icons/Angin_Topan.png") }}'
            };
            
            const icon = L.divIcon({
                html: `<img src="${bencanaIcons[data.jenis_bencana]}" class="custom-div-icon" style="width: 30px; height: 30px;">`,
                className: 'custom-div-icon',
                iconSize: [30, 30],
                iconAnchor: [15, 15],
                popupAnchor: [0, -20]
            });
            
            marker = L.marker([data.latitude, data.longitude], { icon });
        }

        // Popup content
        const popupContent = `
            <div class="popup-content">
                <h6 class="font-weight-bold">${type === 'jalan' ? data.jenis_rusak : data.jenis_bencana}</h6>
                <p><strong>Lokasi:</strong> ${data.lokasi}</p>
                <p><strong>Status:</strong> ${data.status}</p>
                ${data.deskripsi ? `<p><strong>Deskripsi:</strong> ${data.deskripsi}</p>` : ''}
                ${data.foto_url ? `<img src="${data.foto_url}" class="img-fluid mt-2" style="max-height: 150px;">` : ''}
            </div>
        `;

        marker.bindPopup(popupContent);
        markers.push(marker);
        marker.addTo(map);
    }

    // Event listeners untuk filter
    document.getElementById('filterJalan').addEventListener('click', function() {
        const btn = this;
        clearMarkers();
        
        // Toggle active state
        if (btn.classList.contains('active')) {
            btn.classList.remove('active');
            // Jika tidak ada filter yang aktif, tampilkan semua
            if (!document.getElementById('filterBencana').classList.contains('active')) {
                fetchLaporanJalan();
                fetchLaporanBencana();
                updateKPIDisplay('all'); // Tampilkan semua data KPI
            }
        } else {
            btn.classList.add('active');
            document.getElementById('filterBencana').classList.remove('active');
            fetchLaporanJalan();
            updateKPIDisplay('jalan'); // Tampilkan data KPI jalan saja
        }
    });

    document.getElementById('filterBencana').addEventListener('click', function() {
        const btn = this;
        clearMarkers();
        
        // Toggle active state
        if (btn.classList.contains('active')) {
            btn.classList.remove('active');
            // Jika tidak ada filter yang aktif, tampilkan semua
            if (!document.getElementById('filterJalan').classList.contains('active')) {
                fetchLaporanJalan();
                fetchLaporanBencana();
                updateKPIDisplay('all'); // Tampilkan semua data KPI
            }
        } else {
            btn.classList.add('active');
            document.getElementById('filterJalan').classList.remove('active');
            fetchLaporanBencana();
            updateKPIDisplay('bencana'); // Tampilkan data KPI bencana saja
        }
    });

    // Fetch data laporan
    function fetchLaporanJalan() {
        fetch('/laporan-jalan/data')
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    result.data.forEach(laporan => addMarker(laporan, 'jalan'));
                }
            })
            .catch(error => console.error('Error:', error));
    }

    function fetchLaporanBencana() {
        fetch('/laporan-bencana/data')
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    result.data.forEach(laporan => addMarker(laporan, 'bencana'));
                }
            })
            .catch(error => console.error('Error:', error));
    }

    // Fungsi untuk mengupdate tampilan KPI
    function updateKPIDisplay(type) {
        // Sembunyikan semua span terlebih dahulu
        document.querySelectorAll('[class*="-total"], [class*="-menunggu"], [class*="-proses"], [class*="-selesai"]')
            .forEach(el => el.style.display = 'none');

        // Tampilkan span yang sesuai dengan filter
        if (type === 'all') {
            document.querySelectorAll('.all-total, .all-menunggu, .all-proses, .all-selesai')
                .forEach(el => el.style.display = 'inline');
        } else if (type === 'jalan') {
            document.querySelectorAll('.jalan-total, .jalan-menunggu, .jalan-proses, .jalan-selesai')
                .forEach(el => el.style.display = 'inline');
        } else if (type === 'bencana') {
            document.querySelectorAll('.bencana-total, .bencana-menunggu, .bencana-proses, .bencana-selesai')
                .forEach(el => el.style.display = 'inline');
        }
    }

    // Load semua laporan saat pertama kali
    fetchLaporanJalan();
    fetchLaporanBencana();
}

document.addEventListener('DOMContentLoaded', function() {
    if (window.L) {
        initMap();
    } else {
        console.error("Leaflet library not loaded.");
    }
});
</script>

@endpush