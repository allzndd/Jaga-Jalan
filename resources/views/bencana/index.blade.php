@extends('layouts.app')

@section('title', 'Daftar Laporan Bencana')
@section('page-title', 'Daftar Laporan Bencana')

@section('content')
<div class="container-fluid mt-4">
    <div class="card">
        <div class="card-body">
            <div class="mb-4">
                <button class="btn btn-primary" data-toggle="modal" data-target="#addLaporanModal">
                    <i class="fas fa-plus"></i> Tambah Laporan
                </button>
                <button class="btn btn-success" data-toggle="modal" data-target="#rekapModal">
                    <i class="fas fa-file-export"></i> Rekap Laporan
                </button>
            </div>

            <!-- <h5>Daftar Laporan Bencana</h5> -->
            <div class="table-responsive">
                <table class="table table-hover" id="laporanTable">
                    <thead class="thead-light">
                        <tr>
                            <th>No</th>
                            <th>Pelapor</th>
                            <th>Jenis Bencana</th>
                            <th>Lokasi</th>
                            <th>Status</th>
                            <th>Tanggal</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($laporanBencana as $index => $laporan)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            <td>{{ $laporan->pelapor }}</td>
                            <td>
                                {{ ucfirst($laporan->jenis_bencana) }}
                            </td>
                            <td>
                                {{ $laporan->lokasi }}
                                <button class="btn btn-primary btn-sm view-location" 
                                        data-lat="{{ explode(',', str_replace(['Lat: ', ' Lng: '], '', $laporan->lokasi))[0] }}"
                                        data-lng="{{ explode(',', str_replace(['Lat: ', ' Lng: '], '', $laporan->lokasi))[1] }}"
                                        data-toggle="tooltip" 
                                        title="Lihat Lokasi">
                                    <i class="fas fa-map-marker-alt"></i>
                                </button>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn dropdown-toggle status-btn 
                                        {{ $laporan->status === 'menunggu' ? 'btn-warning' : 
                                           ($laporan->status === 'dalam_proses' ? 'btn-info' : 'btn-success') }}"
                                            type="button"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false"
                                            data-id="{{ $laporan->id }}"
                                            style="width: 140px; text-align: left;">
                                        <i class="fas {{ 
                                            $laporan->status === 'menunggu' ? 'fa-clock' : 
                                            ($laporan->status === 'dalam_proses' ? 'fa-tools' : 'fa-check-circle') 
                                        }} mr-2"></i>
                                        {{ str_replace('_', ' ', ucfirst($laporan->status)) }}
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item status-item {{ $laporan->status === 'menunggu' ? 'active' : '' }}" 
                                           href="#" 
                                           data-status="menunggu">
                                            <i class="fas fa-clock text-warning mr-2"></i>
                                            Menunggu
                                        </a>
                                        <a class="dropdown-item status-item {{ $laporan->status === 'dalam_proses' ? 'active' : '' }}" 
                                           href="#" 
                                           data-status="dalam_proses">
                                            <i class="fas fa-tools text-info mr-2"></i>
                                            Dalam Proses
                                        </a>
                                        <a class="dropdown-item status-item {{ $laporan->status === 'selesai' ? 'active' : '' }}" 
                                           href="#" 
                                           data-status="selesai">
                                            <i class="fas fa-check-circle text-success mr-2"></i>
                                            Selesai
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td>{{ \Carbon\Carbon::parse($laporan->created_at)->format('d M Y H:i') }}</td>
                            <td>
                                <button class="btn btn-info btn-sm view-foto" 
                                        data-foto="{{ $laporan->foto }}"
                                        data-toggle="tooltip" 
                                        title="Lihat Foto"
                                        {{ !$laporan->foto ? 'disabled' : '' }}>
                                    <i class="fas fa-image"></i>
                                </button>
                                <button class="btn btn-danger btn-sm delete-laporan" 
                                        data-id="{{ $laporan->id }}"
                                        data-lokasi="{{ $laporan->lokasi }}"
                                        data-toggle="tooltip" 
                                        title="Hapus Laporan">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal Tambah Laporan -->
<div class="modal fade" id="addLaporanModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Laporan Baru</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addLaporanForm">
                    <div class="form-group">
                        <label>Lokasi</label>
                        <input type="text" class="form-control" name="lokasi" id="lokasi" required readonly>
                    </div>
                    <div class="form-group">
                        <label>Pilih Lokasi di Peta</label>
                        <div id="map" style="height: 300px;"></div>
                    </div>
                    <div class="form-group">
                        <label>Jenis Bencana</label>
                        <select class="form-control" name="jenis_bencana" required>
                            <option value="Banjir">Banjir</option>
                            <option value="Longsor">Longsor</option>
                            <option value="Erupsi">Erupsi</option>
                            <option value="Lahar Panas">Lahar Panas</option>
                            <option value="Lahar Dingin">Lahar Dingin</option>
                            <option value="Gempa">Gempa</option>
                            <option value="Angin Topan">Angin Topan</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Deskripsi</label>
                        <textarea class="form-control" name="deskripsi" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Foto</label>
                        <input type="file" class="form-control" name="foto">
                        <small class="text-muted">Opsional. Format gambar, maksimal 5MB.</small>
                    </div>
                    <input type="hidden" name="latitude" id="latitude" required>
                    <input type="hidden" name="longitude" id="longitude" required>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-primary" id="saveLaporan">Simpan</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Foto -->
<div class="modal fade" id="fotoModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Foto Bencana</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <img id="fotoPreview" src="" alt="Foto Bencana" class="img-fluid">
            </div>
        </div>
    </div>
</div>

<!-- Modal Konfirmasi Hapus -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Konfirmasi Hapus</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus laporan bencana di lokasi <span id="lokasiText"></span>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">Hapus</button>
            </div>
        </div>
    </div>
</div>

<!-- Tambahkan Modal untuk Peta -->
<div class="modal fade" id="locationModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Lokasi Laporan</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="locationMap" style="height: 400px;"></div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Rekap -->
<div class="modal fade" id="rekapModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Rekap Laporan Bencana</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="rekapForm">
                    <div class="form-group">
                        <label>Periode</label>
                        <select class="form-control" name="periode" id="periode" required>
                            <option value="bulan">Bulanan</option>
                            <option value="tahun">Tahunan</option>
                        </select>
                    </div>
                    <div class="form-group" id="bulanGroup">
                        <label>Bulan</label>
                        <select class="form-control" name="bulan" id="bulan">
                            <option value="1">Januari</option>
                            <option value="2">Februari</option>
                            <option value="3">Maret</option>
                            <option value="4">April</option>
                            <option value="5">Mei</option>
                            <option value="6">Juni</option>
                            <option value="7">Juli</option>
                            <option value="8">Agustus</option>
                            <option value="9">September</option>
                            <option value="10">Oktober</option>
                            <option value="11">November</option>
                            <option value="12">Desember</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tahun</label>
                        <select class="form-control" name="tahun" id="tahun" required>
                            @for($i = date('Y'); $i >= date('Y')-5; $i--)
                                <option value="{{ $i }}">{{ $i }}</option>
                            @endfor
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Format Export</label>
                        <select class="form-control" name="format" required>
                            <option value="pdf">PDF</option>
                            <option value="excel">Excel</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-primary" id="exportRekap">Export</button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('styles')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap4.min.css">
<style>
    .card {
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .table thead th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
    }
    .badge {
        padding: 0.5em 0.8em;
        font-size: 85%;
    }
    .btn-sm {
        margin: 0 2px;
    }
    .btn-sm i {
        font-size: 0.9rem;
    }
    
    /* Status button styles */
    .status-btn {
        font-size: 0.9rem;
        padding: 0.375rem 0.75rem;
        color: white !important;
    }
    
    .status-btn::after {
        float: right;
        margin-top: 8px;
    }
    
    .dropdown-item {
        font-size: 0.9rem;
        padding: 0.5rem 1rem;
    }
    
    .dropdown-item.active,
    .dropdown-item:active {
        background-color: #e9ecef;
        color: #212529;
    }
    
    .dropdown-item:hover {
        background-color: #f8f9fa;
    }
    
    /* Responsive table styles */
    .table-responsive {
        padding: 0;
    }
    
    #laporanTable {
        width: 100% !important;
    }
    
    #laporanTable_wrapper .row {
        margin: 0;
        padding: 15px 0;
    }

    /* Modal styles */
    .modal {
        background: rgba(0, 0, 0, 0.5);
    }
    .modal-backdrop {
        display: none;
    }
    .modal-dialog {
        margin: 1.75rem auto;
        z-index: 1100;
    }
    .modal-content {
        position: relative;
        z-index: 1100;
        background: white;
        box-shadow: 0 3px 8px rgba(0,0,0,.3);
    }
    #addAdminModal {
        z-index: 1050;
    }
    #deleteModal {
        z-index: 1050;
    }
    
    /* Foto Modal Styles */
    #fotoModal .modal-dialog {
        max-width: 90%;
        max-height: 90vh;
        margin: 1.75rem auto;
    }
    
    #fotoModal .modal-content {
        max-height: 90vh;
        overflow: hidden;
    }
    
    #fotoModal .modal-body {
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8f9fa;
    }
    
    #fotoModal .img-fluid {
        max-width: 100%;
        max-height: 85vh;
        object-fit: contain;
    }
    
    @media screen and (max-width: 768px) {
        .card-body {
            padding: 0.5rem;
        }
        
        .table td, .table th {
            padding: 0.5rem;
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }
        
        .status-btn {
            font-size: 0.8rem;
            width: 120px !important;
        }
        
        .dropdown-item {
            font-size: 0.8rem;
        }

        #fotoModal .modal-dialog {
            max-width: 95%;
            margin: 0.5rem auto;
        }
        
        #fotoModal .img-fluid {
            max-height: 80vh;
        }
    }
</style>
@endpush

@push('scripts')
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
let laporanIdToDelete = null;
let table = null;
let locationMap = null; // Tambahkan variabel global untuk menyimpan instance peta

$(document).ready(function() {
    // Inisialisasi tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Inisialisasi DataTable
    table = $('#laporanTable').DataTable({
        responsive: true,
        language: {
            url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/id.json'
        },
        columnDefs: [
            { responsivePriority: 1, targets: 0 }, // Nomor
            { responsivePriority: 2, targets: 2 }, // Jenis Bencana
            { responsivePriority: 3, targets: 4 }, // Status
            { responsivePriority: 4, targets: -1 }, // Aksi
            { responsivePriority: 5, targets: 1 }, // Pelapor
            { responsivePriority: 6, targets: 3 }, // Lokasi
            { responsivePriority: 7, targets: 5 }  // Tanggal
        ]
    });

    // Update Status
    $('.status-item').click(function(e) {
        e.preventDefault();
        const status = $(this).data('status');
        const button = $(this).closest('.dropdown').find('.status-btn');
        const laporanId = button.data('id');
        
        $.ajax({
            url: `/bencana/${laporanId}/status`,
            type: 'PUT',
            data: {
                _token: '{{ csrf_token() }}',
                status: status
            },
            success: function(response) {
                if (response.success) {
                    // Update button appearance
                    button.removeClass('btn-warning btn-info btn-success');
                    let newClass = '';
                    let icon = '';
                    
                    switch(status) {
                        case 'menunggu':
                            newClass = 'btn-warning';
                            icon = '<i class="fas fa-clock mr-2"></i>';
                            break;
                        case 'dalam_proses':
                            newClass = 'btn-info';
                            icon = '<i class="fas fa-tools mr-2"></i>';
                            break;
                        case 'selesai':
                            newClass = 'btn-success';
                            icon = '<i class="fas fa-check-circle mr-2"></i>';
                            break;
                    }
                    
                    button.addClass(newClass);
                    button.html(icon + status.replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase()));
                } else {
                    alert(response.message || 'Gagal mengupdate status');
                }
            },
            error: function() {
                alert('Terjadi kesalahan saat mengupdate status');
            }
        });
    });

    // Lihat foto
    $('.view-foto').click(function() {
        const foto = $(this).data('foto');
        if (foto) {
            $('#fotoPreview').attr('src', '/storage/' + foto);
            $('#fotoModal').modal('show');
        }
    });

    // Hapus laporan
    $('.delete-laporan').click(function() {
        laporanIdToDelete = $(this).data('id');
        const lokasi = $(this).data('lokasi');
        
        $('#lokasiText').text(lokasi);
        $('#deleteModal').modal('show');
    });

    // Konfirmasi hapus
    $('#confirmDelete').click(function() {
        if (laporanIdToDelete) {
            $.ajax({
                url: `/bencana/${laporanIdToDelete}`,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    if (response.success) {
                        const row = table.row($(`button[data-id="${laporanIdToDelete}"]`).closest('tr'));
                        row.remove().draw();
                        alert('Laporan bencana berhasil dihapus');
                    } else {
                        alert('Gagal menghapus laporan bencana');
                    }
                },
                error: function() {
                    alert('Terjadi kesalahan saat menghapus laporan bencana');
                }
            });
        }
        $('#deleteModal').modal('hide');
    });

    // Kirim laporan bencana
    $('#saveLaporan').on('click', function(e) {
        e.preventDefault();
        
        const form = $('#addLaporanForm');
        const formData = new FormData(form[0]);
        formData.append('_token', '{{ csrf_token() }}');

        $.ajax({
            url: '{{ route("bencana.store") }}', // Ganti dengan route yang sesuai
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                if (response.success) {
                    alert('Laporan berhasil ditambahkan!');
                    form[0].reset();
                    $('#addLaporanModal').modal('hide');
                    location.reload(); // Reload halaman untuk melihat laporan baru
                } else {
                    alert(response.message || 'Gagal menambahkan laporan');
                }
            },
            error: function(xhr) {
                alert('Terjadi kesalahan saat menambahkan laporan: ' + xhr.responseJSON.message);
            }
        });
    });

    // Resize table
    $(window).resize(function() {
        table.columns.adjust().responsive.recalc();
    });

    // Fungsi untuk menampilkan peta lokasi
    $('.view-location').click(function() {
        const lat = $(this).data('lat');
        const lng = $(this).data('lng');
        
        $('#locationModal').modal('show');
        
        // Tunggu modal selesai ditampilkan sebelum menginisialisasi peta
        $('#locationModal').on('shown.bs.modal', function () {
            // Hapus peta yang ada jika sudah ada
            if (locationMap) {
                locationMap.remove();
            }
            
            // Inisialisasi peta baru
            locationMap = L.map('locationMap').setView([lat, lng], 15);
            
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 19,
                attribution: '© OpenStreetMap contributors'
            }).addTo(locationMap);
            
            // Tambahkan marker
            L.marker([lat, lng]).addTo(locationMap);
            
            // Trigger resize untuk memastikan peta ditampilkan dengan benar
            setTimeout(function() {
                locationMap.invalidateSize();
            }, 100);
        });
        
        // Bersihkan peta saat modal ditutup
        $('#locationModal').on('hidden.bs.modal', function () {
            if (locationMap) {
                locationMap.remove();
                locationMap = null;
            }
        });
    });

    // Handle perubahan periode
    $('#periode').change(function() {
        if ($(this).val() === 'bulan') {
            $('#bulanGroup').show();
        } else {
            $('#bulanGroup').hide();
        }
    });

    // Export rekap
    $('#exportRekap').click(function() {
        const form = $('#rekapForm');
        const formData = new FormData(form[0]);
        formData.append('_token', '{{ csrf_token() }}');

        const format = formData.get('format');
        const periode = formData.get('periode');
        const tahun = formData.get('tahun');
        const bulan = formData.get('bulan');

        let url = `/bencana/rekap/${format}?tahun=${tahun}`;
        if (periode === 'bulan') {
            url += `&bulan=${bulan}`;
        }

        window.location.href = url;
    });
});

function initMap() {
    var map = L.map('map').setView([-8.132932, 113.221684], 10); // Koordinat awal

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        minZoom: 10.5,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    var marker;

    // Event untuk menambahkan marker saat peta diklik
    map.on('click', function(e) {
        if (marker) {
            map.removeLayer(marker); // Hapus marker sebelumnya
        }
        marker = L.marker(e.latlng).addTo(map); // Tambahkan marker baru
        document.getElementById('latitude').value = e.latlng.lat; // Set latitude
        document.getElementById('longitude').value = e.latlng.lng; // Set longitude
        document.getElementById('lokasi').value = `Lat: ${e.latlng.lat}, Lng: ${e.latlng.lng}`; // Set lokasi
    });
}

// Inisialisasi peta saat modal dibuka
$('#addLaporanModal').on('shown.bs.modal', function () {
    initMap();
});
</script>
@endpush 