<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

class BencanaExport implements FromCollection, WithHeadings, WithMapping
{
    protected $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function collection()
    {
        return $this->data;
    }

    public function headings(): array
    {
        return [
            'No',
            'Pelapor',
            'Jenis Bencana',
            'Lokasi',
            'Status',
            'Tanggal',
            'Deskripsi'
        ];
    }

    public function map($row): array
    {
        static $index = 0;
        $index++;

        return [
            $index,
            $row->pelapor,
            ucfirst($row->jenis_bencana),
            $row->lokasi,
            str_replace('_', ' ', ucfirst($row->status)),
            \Carbon\Carbon::parse($row->created_at)->format('d M Y H:i'),
            $row->deskripsi
        ];
    }
} 