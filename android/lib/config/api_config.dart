class ApiConfig {
  // Pastikan IP dan port sesuai dengan server Laravel Anda
  static const String baseUrl = 'http://jagajalan.oyi.web.id';
  // static const String baseUrl = 'http://192.168.1.15:8000';
  static const String apiUrl = '$baseUrl/api';
  
  // Untuk development di device fisik
  // static const String baseUrl = 'http://192.168.1.x:8000/api';
  
  // Untuk production
  // static const String baseUrl = 'https://your-domain.com/api';
} 