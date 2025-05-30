@php
use App\Models\User;
@endphp

@extends('layouts.app')

@section('title', 'Daftar Admin')
@section('page-title', 'Daftar Admin')

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
        
        .modal-dialog {
            margin: 0.5rem;
            width: auto;
        }
    }
    .table-active {
        background-color: rgba(0,0,0,.05);
    }
    .badge-secondary {
        margin-left: 5px;
        font-size: 75%;
    }
    .table-responsive {
        padding: 0;
    }
    #adminsTable {
        width: 100% !important;
    }

    #adminsTable_wrapper .row {
        margin: 0;
        padding: 15px 0;
    }
</style>
@endpush

@section('content')
<div class="container-fluid mt-4">
    <div class="card">
        <div class="card-body">
            @if($currentAdmin->tipe_pengguna === 'super admin')
            <div class="mb-4">
                <button class="btn btn-primary" data-toggle="modal" data-target="#addAdminModal">
                    <i class="fas fa-plus"></i> Tambah Admin
                </button>
            </div>
            @endif

            <div class="table-responsive">
                <table class="table table-hover" id="adminsTable">
                    <thead class="thead-light">
                        <tr>
                            <th>No</th>
                            <th>Nama</th>
                            <th>Email</th>
                            <th>Alamat</th>
                            <th>Instansi</th>
                            <th>Jabatan</th>
                            <th>Tipe Pengguna</th>
                            @if($currentAdmin->tipe_pengguna === 'super admin')
                            <th>Aksi</th>
                            @endif
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($admins as $index => $admin)
                        <tr @if($admin->id === $currentAdmin->id) class="table-active" @endif>
                            <td>{{ $index + 1 }}</td>
                            <td>
                                {{ $admin->name }}
                                @if($admin->id === $currentAdmin->id)
                                <span class="badge badge-secondary">Anda</span>
                                @endif
                            </td>
                            <td>{{ $admin->email }}</td>
                            <td>{{ $admin->alamat }}</td>
                            <td>{{ $admin->instansi }}</td>
                            <td>
                                <span data-toggle="tooltip" title="{{ $admin->jabatan ? User::getJabatanOptions($admin->instansi)[$admin->jabatan] ?? '' : '' }}">
                                    {{ $admin->jabatan }}
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-{{ $admin->tipe_pengguna === 'super admin' ? 'danger' : 'info' }}">
                                    {{ ucfirst($admin->tipe_pengguna) }}
                                </span>
                            </td>
                            @if($currentAdmin->tipe_pengguna === 'super admin')
                            <td>
                                @if($admin->id !== $currentAdmin->id)
                                <button class="btn btn-danger btn-sm delete-admin" 
                                        data-id="{{ $admin->id }}"
                                        data-name="{{ $admin->name }}">
                                    <i class="fas fa-trash"></i> Hapus
                                </button>
                                @else
                                <button class="btn btn-secondary btn-sm" disabled>
                                    <i class="fas fa-user"></i> Akun Aktif
                                </button>
                                @endif
                            </td>
                            @endif
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

@if($currentAdmin->tipe_pengguna === 'super admin')
<!-- Modal Tambah Admin -->
<div class="modal fade" id="addAdminModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Admin Baru</h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addAdminForm">
                    <div class="form-group">
                        <label>Nama</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="form-group">
                        <label>Alamat</label>
                        <textarea class="form-control" name="alamat" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Instansi</label>
                        <select class="form-control" name="instansi" id="instansi" required>
                            <option value="">Pilih Instansi</option>
                            @foreach($instansiOptions as $instansi)
                                <option value="{{ $instansi }}">{{ $instansi }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Jabatan</label>
                        <select class="form-control" name="jabatan" id="jabatan" required disabled>
                            <option value="">Pilih Instansi Terlebih Dahulu</option>
                        </select>
                        <small class="text-muted jabatan-desc"></small>
                    </div>
                    <div class="form-group">
                        <label>Tipe Pengguna</label>
                        <select class="form-control" name="tipe_pengguna" required>
                            <option value="admin">Admin</option>
                            <option value="super admin">Super Admin</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-primary" id="saveAdmin">Simpan</button>
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
                <p>Apakah Anda yakin ingin menghapus admin <span id="adminName"></span>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">Hapus</button>
            </div>
        </div>
    </div>
</div>
@endif

@endsection

@push('scripts')
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap4.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const isSuperAdmin = '{!! $currentAdmin->tipe_pengguna === "super admin" ? "true" : "false" !!}' === 'true';
    let adminIdToDelete = null;
    let table = null;

    // Inisialisasi DataTable
    table = $('#adminsTable').DataTable({
        responsive: true,
        language: {
            url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/id.json'
        }
    });

    if (isSuperAdmin) {
        // Tambah Admin
        $('#saveAdmin').on('click', function(e) {
            e.preventDefault();
            
            const form = $('#addAdminForm');
            const formData = {
                name: form.find('input[name="name"]').val(),
                email: form.find('input[name="email"]').val(),
                password: form.find('input[name="password"]').val(),
                alamat: form.find('textarea[name="alamat"]').val(),
                tipe_pengguna: form.find('select[name="tipe_pengguna"]').val(),
                instansi: form.find('select[name="instansi"]').val(),
                jabatan: form.find('select[name="jabatan"]').val(),
                _token: '{{ csrf_token() }}'
            };
            
            // Debug log
            console.log('Sending data:', formData);
            
            // Reset error states
            form.find('.is-invalid').removeClass('is-invalid');
            form.find('.invalid-feedback').remove();
            
            $.ajax({
                url: '{{ route("admins.store") }}',
                type: 'POST',
                dataType: 'json',
                data: formData,
                success: function(response) {
                    console.log('Success response:', response);
                    if (response.success) {
                        alert('Admin berhasil ditambahkan!');
                        form[0].reset();
                        $('#addAdminModal').modal('hide');
                        location.reload();
                    } else {
                        alert(response.message || 'Gagal menambahkan admin');
                    }
                },
                error: function(xhr, status, error) {
                    console.log('Error details:', {
                        status: xhr.status,
                        statusText: xhr.statusText,
                        responseText: xhr.responseText
                    });
                    
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (xhr.status === 422 && response.errors) {
                            Object.keys(response.errors).forEach(field => {
                                const input = form.find(`[name="${field}"]`);
                                input.addClass('is-invalid');
                                input.after(`<div class="invalid-feedback">${response.errors[field][0]}</div>`);
                            });
                        } else {
                            alert(response.message || 'Terjadi kesalahan saat menambahkan admin');
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                        alert('Terjadi kesalahan saat menambahkan admin: ' + error);
                    }
                }
            });
        });

        // Hapus Admin
        $('.delete-admin').on('click', function() {
            adminIdToDelete = $(this).data('id');
            const adminName = $(this).data('name');
            
            $('#adminName').text(adminName);
            $('#deleteModal').modal('show');
        });

        // Konfirmasi Hapus
        $('#confirmDelete').on('click', function() {
            if (adminIdToDelete) {
                $.ajax({
                    url: `/admins/${adminIdToDelete}`,
                    type: 'DELETE',
                    data: {
                        _token: '{{ csrf_token() }}'
                    },
                    success: function(response) {
                        if (response.success) {
                            const row = table.row($(`button[data-id="${adminIdToDelete}"]`).closest('tr'));
                            row.remove().draw();
                            alert('Admin berhasil dihapus');
                        } else {
                            alert(response.message || 'Gagal menghapus admin');
                        }
                    },
                    error: function() {
                        alert('Terjadi kesalahan saat menghapus admin');
                    }
                });
            }
            $('#deleteModal').modal('hide');
        });
    }

    // Resize table
    $(window).on('resize', function() {
        if (table) {
            table.columns.adjust().responsive.recalc();
        }
    });

    // Dropdown dinamis untuk jabatan berdasarkan instansi
    $('#instansi').on('change', function() {
        const instansi = $(this).val();
        const jabatanSelect = $('#jabatan');
        const jabatanDesc = $('.jabatan-desc');
        
        jabatanSelect.empty();
        jabatanDesc.text('');
        
        if (instansi) {
            jabatanSelect.prop('disabled', false);
            
            // Ambil data jabatan berdasarkan instansi
            $.ajax({
                url: '{{ route("admins.getJabatan") }}',
                type: 'GET',
                data: { instansi: instansi },
                success: function(response) {
                    if (response.success) {
                        jabatanSelect.append('<option value="">Pilih Jabatan</option>');
                        
                        Object.entries(response.data).forEach(([jabatan, deskripsi]) => {
                            jabatanSelect.append(`<option value="${jabatan}">${jabatan}</option>`);
                        });
                    }
                },
                error: function() {
                    alert('Gagal mengambil data jabatan');
                }
            });
        } else {
            jabatanSelect.prop('disabled', true);
            jabatanSelect.html('<option value="">Pilih Instansi Terlebih Dahulu</option>');
        }
    });
    
    // Tampilkan deskripsi jabatan saat jabatan dipilih
    $('#jabatan').on('change', function() {
        const instansi = $('#instansi').val();
        const jabatan = $(this).val();
        const jabatanDesc = $('.jabatan-desc');
        
        if (jabatan) {
            $.ajax({
                url: '{{ route("admins.getJabatan") }}',
                type: 'GET',
                data: { instansi: instansi },
                success: function(response) {
                    if (response.success && response.data[jabatan]) {
                        jabatanDesc.text(response.data[jabatan]);
                    }
                }
            });
        } else {
            jabatanDesc.text('');
        }
    });

    // Inisialisasi tooltip untuk deskripsi jabatan
    $('[data-toggle="tooltip"]').tooltip();
});
</script>
@endpush 