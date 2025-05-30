<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="{{ asset('css/login.css') }}" rel="stylesheet">
</head>
<body>
    <div class="main-container">
        <div class="login-container">
            <div class="brand-logo">
            </div>
            <h2 class="login-header">Login Admin</h2>
            <form method="POST" action="{{ route('login') }}">
                @csrf
                <div class="mb-3">
                    <label for="username_or_email" class="form-label">Username atau Email</label>
                    <input type="text" class="form-control @error('username_or_email') is-invalid @enderror" 
                           id="username_or_email" name="username_or_email" value="{{ old('username_or_email') }}" 
                           required autofocus placeholder="Masukkan username atau email">
                    @error('username_or_email')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control @error('password') is-invalid @enderror" 
                           id="password" name="password" required placeholder="Masukkan password">
                    @error('password')
                        <div class="invalid-feedback">{{ $message }}</div>
                    @enderror
                </div>
                @if ($errors->any())
                    <div class="alert alert-danger mb-3">
                        {{ $errors->first() }}
                    </div>
                @endif
                <button type="submit" class="btn btn-login">Masuk</button>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
