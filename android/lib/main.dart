import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'history_page.dart';
import 'report_page.dart';
import 'profil_page.dart';
import 'report_jalan.dart';
import 'cuaca_page.dart';
import 'splash_screen.dart';
import 'config/theme_colors.dart';
import 'package:flutter/services.dart';
import './reset_password_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  final _navigatorKey = GlobalKey<NavigatorState>();
  
  @override
  void initState() {
    super.initState();
    _initAppLinks();
  }

  Future<void> _initAppLinks() async {
    // Menangani deep link saat aplikasi sudah berjalan
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    });

    // Menangani deep link saat aplikasi diluncurkan dari link
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        print('Got initial app link: $initialLink');
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      print('Error getting initial app link: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    print('Handling deep link: $uri');
    print('URI scheme: ${uri.scheme}, host: ${uri.host}, path: ${uri.path}');
    print('URI query parameters: ${uri.queryParameters}');
    
    // Cek apakah ini URL reset password dengan skema jagajalan
    if (uri.scheme == 'jagajalan' && uri.host == 'reset-password') {
      // Coba ambil token dan email dari query parameters
      String? token = uri.queryParameters['token'];
      String? email = uri.queryParameters['email'];
      
      // Jika email null, coba cari parameter dengan 'amp;email'
      if (email == null && uri.queryParameters.containsKey('amp;email')) {
        email = uri.queryParameters['amp;email'];
      }
      
      // Jika masih null, coba parse query string secara manual
      if (email == null) {
        final queryString = uri.toString().split('?').last;
        final params = queryString.split('&');
        for (var param in params) {
          final parts = param.split('=');
          if (parts.length == 2) {
            if (parts[0] == 'email' || parts[0].endsWith('email')) {
              email = Uri.decodeComponent(parts[1]);
            }
          }
        }
      }
      
      print('Reset password parameters - Token: $token, Email: $email');
      
      if (token != null && email != null) {
        // Navigasi ke halaman reset password menggunakan navigatorKey
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ResetPasswordPage(
                email: email!,
                initialToken: token!,
              ),
            ),
            (route) => false,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jaga Jalan',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey, // Tambahkan navigatorKey
      theme: ThemeColors.lightTheme,
      darkTheme: ThemeColors.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      routes: {
        '/report-jalan': (context) => ReportJalan(),
        '/report-bencana': (context) => ReportPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
        '/history': (context) => HistoryPage(),
        '/profile': (context) => ProfilePage(),
        '/cuaca': (context) => CuacaPage(),
      },
    );
  }
}
