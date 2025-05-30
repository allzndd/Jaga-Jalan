import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';

class ApiService {
  final Dio _dio = Dio();
  static ApiService? _instance;
  static bool _isRefreshing = false;
  static VoidCallback? onTokenExpired;

  // Add getter for dio
  Dio get dio => _dio;

  factory ApiService() {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  ApiService._internal() {
    _dio.options.baseUrl = ApiConfig.apiUrl;
    _dio.options.connectTimeout = Duration(seconds: 30); // Tambah waktu timeout menjadi 30 detik
    _dio.options.receiveTimeout = Duration(seconds: 30); // Tambah waktu timeout menjadi 30 detik
    _dio.options.followRedirects = false;
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(RetryInterceptor()); // Tambah retry interceptor
    
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  // Auth Endpoints
  Future<Response> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(String name, String email, String password) async {
    try {
      return await _dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> logout() async {
    try {
      final response = await _dio.post('/auth/logout');
      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProfile() async {
    try {
      return await _dio.get('/profile');
    } catch (e) {
      rethrow;
    }
  }

  // Laporan Endpoints
  Future<Response> laporJalan({
    required String lokasi,
    required double latitude,
    required double longitude,
    required String jenisRusak,
    String? deskripsi,
    required File foto,
    String? waktu,
  }) async {
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };
      
      FormData formData = FormData.fromMap({
        'lokasi': lokasi,
        'latitude': latitude,
        'longitude': longitude,
        'jenis_rusak': jenisRusak,
        'deskripsi': deskripsi ?? '',
        'waktu': waktu ?? DateTime.now().toUtc().add(Duration(hours: 7)).toIso8601String(),
        'foto': await MultipartFile.fromFile(
          foto.path,
          filename: 'foto_jalan_${DateTime.now().millisecondsSinceEpoch}.jpg'
        ),
      });

      // Tambahkan logging untuk memeriksa data yang dikirim
      print('FormData yang dikirim:');
      print('lokasi: $lokasi');
      print('latitude: $latitude');
      print('longitude: $longitude');
      print('jenis_rusak: $jenisRusak');
      print('deskripsi: $deskripsi');
      print('waktu sebelum konversi: $waktu');
      print('waktu default: ${DateTime.now().toUtc().add(Duration(hours: 7)).toIso8601String()}');
      print('waktu yang dikirim: ${formData.fields.firstWhere((field) => field.key == 'waktu').value}');
      print('foto: ${foto.path}');

      final response = await _dio.post('/lapor/jalan', data: formData);
      return response;
    } catch (e) {
      print('Error dalam laporJalan: $e');
      rethrow;
    }
  }

  Future<Response> laporBencana({
    required String lokasi,
    required double latitude,
    required double longitude,
    required String jenisBencana,
    String? deskripsi,
    required File foto,
  }) async {
    try {
      _dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      };
      
      FormData formData = FormData.fromMap({
        'lokasi': lokasi,
        'latitude': latitude,
        'longitude': longitude,
        'jenis_bencana': jenisBencana,
        'deskripsi': deskripsi ?? '',
        'foto': await MultipartFile.fromFile(
          foto.path,
          filename: 'foto_bencana_${DateTime.now().millisecondsSinceEpoch}.jpg'
        ),
      });

      // Tambahkan logging untuk memeriksa data yang dikirim
      print('FormData yang dikirim:');
      print('lokasi: $lokasi');
      print('latitude: $latitude');
      print('longitude: $longitude');
      print('jenis_bencana: $jenisBencana');
      print('deskripsi: $deskripsi');
      print('foto: ${foto.path}');

      final response = await _dio.post('/lapor/bencana', data: formData);
      return response;
    } catch (e) {
      print('Error dalam laporBencana: $e');
      rethrow;
    }
  }

  Future<Response> getLaporanJalan() async {
    try {
      return await _dio.get('/laporan-jalan');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getLaporanBencana() async {
    try {
      return await _dio.get('/laporan-bencana');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRiwayatLaporan() async {
    try {
      return await _dio.get('/laporan/riwayat');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token == null) throw Exception('No token found');

      final response = await _dio.post('/refresh', 
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      if (response.statusCode == 200) {
        final newToken = response.data['data']['token'];
        await prefs.setString('token', newToken);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk menangani token expired
  static Future<void> handleTokenExpired(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('id_pengguna');
    await prefs.remove('username');
    await prefs.remove('surel');

    // Tampilkan pesan error
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sesi Anda telah berakhir. Silakan login kembali.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );

      // Navigasi ke halaman login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    }
  }
}

// Interceptor untuk menambahkan token ke setiap request
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['Accept'] = 'application/json';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String userFriendlyMessage = '';

    switch (err.type) {
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        userFriendlyMessage = 'Waktu tunggu habis. Mohon periksa koneksi internet Anda dan coba lagi.';
        break;
      case DioExceptionType.connectionError:
        userFriendlyMessage = 'Tidak dapat terhubung ke server. Mohon periksa koneksi internet Anda.';
        break;
      case DioExceptionType.badResponse:
        if (err.response?.statusCode == 401) {
          final responseData = err.response?.data;
          final message = (responseData as Map<String, dynamic>)['message']?.toString();
          
          if (message != null && message.toLowerCase().contains('expired')) {
            userFriendlyMessage = 'Sesi Anda telah berakhir. Silakan login kembali.';
            if (ApiService.onTokenExpired != null) {
              ApiService.onTokenExpired!();
            }
          }
        } else {
          userFriendlyMessage = 'Terjadi kesalahan pada server. Silakan coba lagi nanti.';
        }
        break;
      default:
        userFriendlyMessage = 'Terjadi kesalahan. Silakan coba lagi.';
    }

    // Buat DioException baru dengan pesan yang lebih user friendly
    final newError = DioException(
      requestOptions: err.requestOptions,
      error: userFriendlyMessage,
      type: err.type,
      response: err.response,
    );

    return handler.next(newError);
  }
}

// Tambahkan class RetryInterceptor
class RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError) {
      // Coba request ulang maksimal 3 kali
      final options = err.requestOptions;
      int retryCount = options.extra['retryCount'] ?? 0;
      
      if (retryCount < 3) {
        options.extra['retryCount'] = retryCount + 1;
        
        // Tunggu 2 detik sebelum retry
        await Future.delayed(Duration(seconds: 2));
        
        try {
          final dio = Dio(BaseOptions(
            baseUrl: options.baseUrl,
            connectTimeout: options.connectTimeout,
            receiveTimeout: options.receiveTimeout,
            headers: options.headers,
          ));
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}