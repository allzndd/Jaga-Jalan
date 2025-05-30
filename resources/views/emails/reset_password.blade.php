<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .container {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo {
            max-width: 150px;
            margin-bottom: 15px;
        }
        .button {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            margin: 20px 0;
            font-weight: bold;
        }
        .footer {
            margin-top: 30px;
            font-size: 12px;
            color: #777;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>Reset Password</h2>
        </div>
        
        <p>Halo <strong>{{ $user->name }}</strong>,</p>
        
        <p>Kami menerima permintaan untuk reset password akun Anda. Silakan klik tombol di bawah ini untuk membuat password baru:</p>
        
        <div style="text-align: center;">
            <a href="{{ $resetUrl }}" class="button">Reset Password</a>
        </div>
        
        <p style="margin-top: 20px; font-size: 12px; color: #666;">
            Jika tombol di atas tidak berfungsi, coba salin link berikut ke browser Anda:
            <br>
            <code style="background: #f5f5f5; padding: 5px; border-radius: 3px; word-break: break-all;">{{ $resetUrl }}</code>
        </p>
        
        <p>Jika Anda tidak meminta reset password, abaikan email ini dan password Anda tidak akan berubah.</p>
        
        <p>Link ini akan kadaluarsa dalam 24 jam.</p>
        
        <p>Terima kasih,<br>Tim Jaga Jalan</p>
        
        <div class="footer">
            <p>Email ini dikirim secara otomatis, mohon tidak membalas email ini.</p>
        </div>
    </div>
</body>
</html> 