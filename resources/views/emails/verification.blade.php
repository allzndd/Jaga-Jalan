<!DOCTYPE html>
<html>
<head>
    <title>Verifikasi Email</title>
</head>
<body>
    <h2>Halo {{ $user->name }}!</h2>
    <p>Terima kasih telah mendaftar. Silakan klik link di bawah ini untuk memverifikasi email Anda:</p>
    <a href="{{ $verificationUrl }}">Verifikasi Email</a>
    <p>Link ini akan kadaluarsa dalam 24 jam.</p>
</body>
</html> 