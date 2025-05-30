import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './config/theme_colors.dart';
import './config/api_config.dart';
import './services/api_services.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id_pengguna');
      final username = prefs.getString('username');
      final email = prefs.getString('surel');

      if (userId == null || username == null || email == null) {
        throw Exception('User data is incomplete');
      }

      setState(() {
        nameController.text = username;
        emailController.text = email;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memuat data pengguna'),
            backgroundColor: ThemeColors.error,
          ),
        );
      }
    }
  }

  Future<void> saveUserData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => isLoading = true);
      
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final apiService = ApiService();
      final response = await apiService.dio.post(
        '${ApiConfig.baseUrl}/api/profile/update',
        data: {
          'name': nameController.text,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        // Update SharedPreferences dengan data baru
        await prefs.setString('username', nameController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Data pengguna berhasil diperbarui'),
              ],
            ),
            backgroundColor: ThemeColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() => isEditing = false);
      } else {
        throw Exception('Gagal memperbarui data pengguna');
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      
      String errorMessage = 'Terjadi kesalahan';
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null && responseData['message'] != null) {
          errorMessage = responseData['message'];
        }
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text(errorMessage)),
            ],
          ),
          backgroundColor: ThemeColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: ThemeColors.primary(context),
      body: Stack(
        children: [
          // Background image yang menutupi seluruh layar
          Positioned.fill(
            child: Image.asset(
              isDarkMode 
                ? 'assets/images/background_dark.png'
                : 'assets/images/background_light.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Content dengan SafeArea
          SafeArea(
            child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: ThemeColors.accent(context),
                  ),
                )
              : SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    ),
                    child: Column(
                      children: [
                        // Header dengan Avatar
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          child: Column(
                            children: [
                              SizedBox(height: 60),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ThemeColors.background(context),
                                  border: Border.all(
                                    color: ThemeColors.accent(context),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ThemeColors.shadowColor(context),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    nameController.text.isNotEmpty 
                                      ? nameController.text[0].toUpperCase()
                                      : '?',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.accent(context),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                nameController.text,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.textPrimary(context),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                emailController.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ThemeColors.textSecondary(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Form dalam Container
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ThemeColors.background(context),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.shadowColor(context),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informasi Pribadi',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeColors.textPrimary(context),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: nameController,
                                    enabled: isEditing && !isLoading,
                                    decoration: InputDecoration(
                                      labelText: 'Nama Pengguna',
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: ThemeColors.inputIcon(context),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: ThemeColors.inputFill(context),
                                      errorStyle: TextStyle(
                                        color: ThemeColors.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama pengguna tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: emailController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: ThemeColors.inputIcon(context),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: ThemeColors.inputFill(context),
                                      errorStyle: TextStyle(
                                        color: ThemeColors.error,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  if (!isEditing)
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() => isEditing = true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeColors.accent(context),
                                          foregroundColor: ThemeColors.buttonText(context),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 2,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.edit),
                                            SizedBox(width: 8),
                                            Text(
                                              'Edit Profil',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: isLoading ? null : () {
                                              setState(() => isEditing = false);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: ThemeColors.buttonDisabled(context),
                                              foregroundColor: ThemeColors.textGrey(context),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 15),
                                            ),
                                            child: Text('Batal'),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: isLoading ? null : () => saveUserData(context),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: ThemeColors.accent(context),
                                              foregroundColor: ThemeColors.buttonText(context),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 15),
                                            ),
                                            child: isLoading
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(
                                                    color: ThemeColors.buttonText(context),
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : Text('Simpan'),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
