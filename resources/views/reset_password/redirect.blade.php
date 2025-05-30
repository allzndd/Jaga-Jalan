<!DOCTYPE html>
<html>
<head>
    <title>Redirect ke Aplikasi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            text-align: center;
        }
        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 500px;
        }
        h1 {
            color: #333;
            font-size: 24px;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.6;
        }
        .button {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-weight: 500;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #45a049;
        }
        .manual-token {
            margin-top: 30px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            font-size: 14px;
        }
        .token-text {
            background: #eee;
            padding: 8px;
            border-radius: 4px;
            font-family: monospace;
            word-break: break-all;
        }
    </style>
    <script>
        // Redirect otomatis ke aplikasi setelah halaman dimuat
        window.onload = function() {
            // Buat URL yang benar tanpa encoding HTML
            const token = "{{ $token }}";
            const email = "{{ $email }}";
            const appUrl = "jagajalan://reset-password?token=" + encodeURIComponent(token) + "&email=" + encodeURIComponent(email);
            
            // Coba redirect ke aplikasi
            window.location.href = appUrl;
            
            // Jika setelah 3 detik masih di halaman ini, berarti redirect gagal
            setTimeout(function() {
                document.getElementById('manual-instructions').style.display = 'block';
                document.getElementById('auto-redirect').style.display = 'none';
            }, 3000);
        };
    </script>
</head>
<body>
    <div class="container">
        <h1>Mengarahkan ke Aplikasi Jaga Jalan</h1>
        
        <div id="auto-redirect">
            <p>Anda akan otomatis diarahkan ke aplikasi Jaga Jalan untuk reset password...</p>
            <div class="loader" style="margin: 20px auto; border: 5px solid #f3f3f3; border-top: 5px solid #4CAF50; border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite;"></div>
            <style>@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }</style>
        </div>
        
        <div id="manual-instructions" style="display: none;">
            <p>Jika Anda tidak otomatis diarahkan ke aplikasi, silakan klik tombol di bawah ini:</p>
            <a href="{{ $appUrl }}" class="button">Buka Aplikasi</a>
            
            <div class="manual-token">
                <p>Jika tombol di atas tidak berfungsi, silakan buka aplikasi Jaga Jalan secara manual dan masukkan token berikut:</p>
                <div class="token-text">{{ $token }}</div>
                <p style="margin-top: 15px;">Email: {{ $email }}</p>
            </div>
        </div>
    </div>
</body>
</html> 