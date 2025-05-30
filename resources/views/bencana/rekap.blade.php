<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Rekap Laporan Bencana</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 12px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h2 {
            margin: 0;
            padding: 0;
        }
        .header p {
            margin: 5px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #000;
            padding: 5px;
            text-align: left;
        }
        th {
            background-color: #f0f0f0;
        }
        .footer {
            text-align: center;
            margin-top: 30px;
            font-size: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Rekap Laporan Bencana</h2>
        <p>Periode: {{ $bulan ? \Carbon\Carbon::create()->month($bulan)->format('F') . ' ' . $tahun : $tahun }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Pelapor</th>
                <th>Jenis Bencana</th>
                <th>Lokasi</th>
                <th>Status</th>
                <th>Tanggal</th>
                <th>Deskripsi</th>
            </tr>
        </thead>
        <tbody>
            @foreach($data as $index => $item)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ $item->pelapor }}</td>
                <td>{{ ucfirst($item->jenis_bencana) }}</td>
                <td>{{ $item->lokasi }}</td>
                <td>{{ str_replace('_', ' ', ucfirst($item->status)) }}</td>
                <td>{{ \Carbon\Carbon::parse($item->created_at)->format('d M Y H:i') }}</td>
                <td>{{ $item->deskripsi }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>

    <div class="footer">
        <p>Dicetak pada: {{ \Carbon\Carbon::now()->format('d M Y H:i:s') }}</p>
    </div>
</body>
</html> 