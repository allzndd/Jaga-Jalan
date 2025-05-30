@extends('layouts.app')

@section('title', 'Daftar User')
@section('page-title', 'Daftar User')

@section('content')
<div class="container-fluid mt-4">
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover" id="usersTable">
                    <thead class="thead-light">
                        <tr>
                            <th>No</th>
                            <th>Nama</th>
                            <th>Email</th>
                            <th>Alamat</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($users as $index => $user)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            <td>{{ $user->name }}</td>
                            <td>{{ $user->email }}</td>
                            <td>{{ $user->alamat }}</td>
                            <td>
                                <button class="btn btn-danger btn-sm delete-user" 
                                        data-id="{{ $user->id }}"
                                        data-name="{{ $user->name }}">
                                    <i class="fas fa-trash"></i> Hapus
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
                <p>Apakah Anda yakin ingin menghapus user <span id="userName"></span>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-danger" id="confirmDelete">Hapus</button>
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
    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }
    .btn-danger:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }
    
    /* Responsive table styles */
    .table-responsive {
        padding: 0;
    }
    
    #usersTable {
        width: 100% !important;
    }
    
    #usersTable_wrapper .row {
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
    }
</style>
@endpush

@push('scripts')
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/responsive.bootstrap4.min.js"></script>
<script>
let userIdToDelete = null;
let table = null;

$(document).ready(function() {
    // Inisialisasi DataTable
    table = $('#usersTable').DataTable({
        responsive: true,
        language: {
            url: '//cdn.datatables.net/plug-ins/1.11.5/i18n/id.json'
        },
        columnDefs: [
            { responsivePriority: 1, targets: 0 }, // Nomor
            { responsivePriority: 2, targets: 1 }, // Nama
            { responsivePriority: 3, targets: -1 }, // Aksi
            { responsivePriority: 4, targets: 2 }, // Email
            { responsivePriority: 5, targets: 3 }  // Tanggal
        ]
    });

    // Ketika tombol hapus diklik
    $('.delete-user').click(function() {
        const userId = $(this).data('id');
        const userName = $(this).data('name');
        userIdToDelete = userId;
        
        $('#userName').text(userName);
        $('#deleteModal').modal('show');
    });

    // Ketika konfirmasi hapus diklik
    $('#confirmDelete').click(function() {
        if (userIdToDelete) {
            $.ajax({
                url: `/users/${userIdToDelete}`,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    if (response.success) {
                        // Hapus row dari DataTable
                        const row = table.row($(`button[data-id="${userIdToDelete}"]`).closest('tr'));
                        row.remove().draw();
                        
                        // Tampilkan notifikasi sukses
                        alert('User berhasil dihapus');
                    } else {
                        alert('Gagal menghapus user');
                    }
                },
                error: function() {
                    alert('Terjadi kesalahan saat menghapus user');
                }
            });
        }
        $('#deleteModal').modal('hide');
    });

    // Resize table ketika window di-resize
    $(window).resize(function() {
        table.columns.adjust().responsive.recalc();
    });
});
</script>
@endpush 