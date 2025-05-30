import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final String baseUrl = ApiConfig.baseUrl;
  final String apiUrl = ApiConfig.apiUrl;

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    signInOption: SignInOption.standard,
  );

  // Fungsi untuk register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String alamat,
    // required String telepon,
  }) async {
    try {
      print('Memulai proses registrasi...');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      final Map<String, dynamic> requestBody = {
        'name': name,
        'email': email,
        'password': password,
        'alamat': alamat,
        'tipe_pengguna': 'user',
        // 'telepon': telepon,
      };

      print('Sending request with headers: $headers');
      print('Sending request with body: ${json.encode(requestBody)}');

      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: headers,
        body: json.encode(requestBody),
      );

      print('Register Response Status: ${response.statusCode}');
      print('Register Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registrasi berhasil');
        final data = json.decode(response.body);
        return {
          'success': true,
          'message': 'Registrasi berhasil',
          'data': data,
        };
      } else {
        final data = json.decode(response.body);
        String errorMessage = data['message'] ?? 'Registrasi gagal';
        
        if (data['errors'] != null) {
          errorMessage += '\n${_formatErrors(data['errors'])}';
        }
        
        return {
          'success': false,
          'message': errorMessage,
          'errors': data['errors'],
        };
      }
    } catch (e) {
      print('Error during registration: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Fungsi untuk login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('Memulai proses login...');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

      final Map<String, dynamic> requestBody = {
        'email': email,
        'password': password,
      };

      print('Sending login request with headers: $headers');
      print('Sending login request with body: ${json.encode(requestBody)}');

      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: headers,
        body: json.encode(requestBody),
      );

      print('Login Response Status: ${response.statusCode}');
      print('Login Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Login berhasil');
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token'); // Hapus token sebelumnya

        final data = json.decode(response.body);
        await prefs.setString('token', data['token']); // Simpan token baru

        return {
          'success': true,
          'message': 'Login berhasil',
          'data': {
            'id_pengguna': data['user']['id'],
            'username': data['user']['name'],
            'surel': data['user']['email'],
            'token': data['token']
          },
        };
      } else {
        final data = json.decode(response.body);
        String errorMessage = data['message'] ?? 'Login gagal';
        
        if (data['errors'] != null) {
          errorMessage += '\n${_formatErrors(data['errors'])}';
        }
        
        return {
          'success': false,
          'message': errorMessage,
          'errors': data['errors'],
        };
      }
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Helper untuk memformat pesan error
  String _formatErrors(Map<String, dynamic> errors) {
    List<String> errorMessages = [];
    errors.forEach((key, value) {
      if (value is List) {
        errorMessages.add('${key.toUpperCase()}: ${value.join(', ')}');
      } else {
        errorMessages.add('${key.toUpperCase()}: $value');
      }
    });
    return errorMessages.join('\n');
  }

  // Tambahkan fungsi logout
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/logout'),
        headers: {
          'Authorization': 'Bearer ${await _getToken()}', // Ambil token dari penyimpanan
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Hapus token dan data pengguna dari penyimpanan lokal
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token'); // Hapus token dari penyimpanan
        await prefs.remove('id_pengguna'); // Hapus ID pengguna
        await prefs.remove('username'); // Hapus username
        await prefs.remove('surel'); // Hapus email
        await prefs.remove('remember_me'); // Hapus status remember me
        await prefs.remove('saved_email'); // Hapus email yang disimpan
        await prefs.remove('saved_password'); // Hapus password yang disimpan

        return {
          'success': true,
          'message': 'Logout berhasil',
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Logout gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Fungsi untuk mendapatkan token dari penyimpanan
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Tambahkan metode ini di class AuthService
  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}/api/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Terjadi kesalahan',
        };
      }
    } catch (e) {
      print('Error in forgotPassword: $e');
      throw Exception('Failed to connect to server');
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}/api/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Terjadi kesalahan',
        };
      }
    } catch (e) {
      print('Error in resetPassword: $e');
      throw Exception('Failed to connect to server');
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      // Pastikan sign out dulu untuk menghindari cache
      await _googleSignIn.signOut();
      
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return {
          'success': false,
          'message': 'Login Google dibatalkan',
        };
      }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final Map<String, dynamic> requestBody = {
        'email': googleUser.email,
        'name': googleUser.displayName,
        'google_id': googleUser.id,
      };

      final response = await http.post(
        Uri.parse('$apiUrl/login-google'),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Simpan token dan data user
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        
        return {
          'success': true,
          'message': 'Login berhasil',
          'data': {
            'id_pengguna': data['user']['id'],
            'username': data['user']['name'],
            'surel': data['user']['email'],
            'token': data['token']
          },
        };
      } else {
        final data = json.decode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      print('Error detail during Google login: ${e.toString()}');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
} 