<!DOCTYPE html>
<html>
<head>
    <title>Verifikasi Berhasil - Jaga Jalan</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        .success-icon {
            color: #4CAF50;
            font-size: 64px;
            margin-bottom: 20px;
        }
        h1 {
            color: #333;
            margin-bottom: 15px;
        }
        p {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #45a049;
        }
        .button-secondary {
            background-color: #666;
            color: white;
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .button-secondary:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h1>Verifikasi Berhasil!</h1>
        <p>Selamat {{ $name }}, email Anda telah terverifikasi. Sekarang Anda dapat menggunakan aplikasi Jaga Jalan.</p>
        <a href="jagajalan://login" class="button" id="openApp">Buka Aplikasi</a>
        <a href="https://play.google.com/store/apps/details?id=com.example.jaga_jalan" 
           class="button button-secondary" 
           style="display: none; margin-top: 10px;" 
           id="playStore">
            Download Aplikasi
        </a>
    </div>

    <script>
        function openApp() {
            const openButton = document.getElementById('openApp');
            const playStoreButton = document.getElementById('playStore');
            
            window.location.href = 'jagajalan://login';
            
            setTimeout(function() {
                playStoreButton.style.display = 'inline-block';
            }, 2000);
        }

        document.getElementById('openApp').addEventListener('click', function(e) {
            e.preventDefault();
            openApp();
        });
    </script>
</body>
</html> 