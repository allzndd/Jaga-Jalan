@extends('layouts.app')

@section('title', 'Laporan Jalan')
@section('page-title', 'Laporan Jalan')

@section('content')
<div class="map">
    <div class="text-center pt-4 no-select">Pemetaan Kerusakan Jalan Wilayah Kabupaten Lumajang</div>
    <div id="map"></div>
</div>
@endsection

@push('scripts')
<script>
function initMap() {
    var location = [-8.132932, 113.221684]; // Koordinat Lumajang
    var map = L.map('map').setView(location, 10);

    // Set the bounds for the map
    var bounds = [
        [-7.893539, 112.899152], // Utara-Barat (top-left)
        [-8.349499, 113.379803]  // Selatan-Timur (bottom-right)
    ];
    map.setMaxBounds(bounds);

    // Prevent map from moving out of bounds
    map.on('drag', function() {
        map.panInsideBounds(bounds, { animate: false });
    });

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        minZoom: 10.5,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    // Fetch laporan jalan data from API
    fetch('/api/laporan-jalan')
        .then(response => response.json())
        .then(data => {
            data.forEach(laporan => {
                var markerIcon;
                if (laporan.status === 'menunggu' && laporan.jenis_rusak === 'jalan rusak ringan') {
                    markerIcon = 'menunggu_ringan.png';
                } else if (laporan.status === 'menunggu' && laporan.jenis_rusak === 'jalan rusak berat') {
                    markerIcon = 'menunggu_berat.png';
                } else if (laporan.status === 'dalam_proses' && laporan.jenis_rusak === 'jalan rusak ringan') {
                    markerIcon = 'proses_ringan.png';
                } else if (laporan.status === 'dalam_proses' && laporan.jenis_rusak === 'jalan rusak berat') {
                    markerIcon = 'proses_berat.png';
                }

                var customIcon = L.icon({
                    iconUrl: `icon/${markerIcon}`,
                    iconSize: [40, 40],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34],
                    shadowSize: [41, 41]
                });

                L.marker([laporan.latitude, laporan.longitude], { icon: customIcon })
                    .addTo(map)
                    .bindPopup(`Status: ${laporan.status}<br>Jenis Kerusakan: ${laporan.jenis_rusak}`);
            });
        })
        .catch(error => console.error('Error fetching data:', error));
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