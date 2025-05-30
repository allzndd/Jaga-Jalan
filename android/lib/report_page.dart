import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'dashboard_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_picker/map_picker.dart';
import 'package:path_provider/path_provider.dart';
import './services/api_services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import './config/theme_colors.dart';
import './widgets/custom_bottom_bar.dart';

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

Future<void> showSuccessDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Berhasil!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Laporan bencana Anda telah berhasil dikirim dan akan segera diproses oleh tim kami.',
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.accent(context),
                minimumSize: Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK, Saya Mengerti',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: EdgeInsets.all(16),
      );
    },
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Tutup',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: EdgeInsets.all(16),
      );
    },
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Sedang memproses...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  double? _latitude;
  double? _longitude;
  Uint8List? _imageData;
  String? _selectedDisasterType;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final mapController = MapController();
  MapPickerController mapPickerController = MapPickerController();

  List<String> provinsiList = [];
  List<String> kabupatenList = [];
  List<String> kecamatanList = [];
  List<String> kelurahanList = [];

  String? selectedProvinsi;
  String? selectedKabupaten;
  String? selectedKecamatan;
  String? selectedKelurahan;

  List<Marker> _markers = [];

  final ApiService _apiService = ApiService();

  // Tambahkan variabel untuk menyimpan file foto
  XFile? _photoFile;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        width: 30.0,
        height: 30.0,
        point: LatLng(-8.009560, 112.950670),
        child: Container(child: FlutterLogo()),
      ),
    );
  }

  void _handleMarkerDrag(Marker marker, LatLng newPosition) {
    setState(() {
      _latitude = newPosition.latitude;
      _longitude = newPosition.longitude;
    });
  }

  void _updateLocationText() {
    setState(() {
      _locationController.text = 'Lat: $_latitude, Lng: $_longitude';
    });
  }

  void _pickLocation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              Icon(
                Icons.location_on,
                color: ThemeColors.accent(context),
                size: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Konfirmasi Lokasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apakah Anda yakin ingin menggunakan lokasi ini?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              if (cameraPosition != null) ...[
                SizedBox(height: 10),
                Text(
                  'Koordinat: (${cameraPosition!.latitude.toStringAsFixed(6)}, ${cameraPosition!.longitude.toStringAsFixed(6)})',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Batal',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (cameraPosition != null) {
                        setState(() {
                          _latitude = cameraPosition!.latitude;
                          _longitude = cameraPosition!.longitude;
                          _locationController.text = 'Lat: ${_latitude!.toStringAsFixed(6)}, Lng: ${_longitude!.toStringAsFixed(6)}';
                        });
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 8),
                                Text('Lokasi berhasil dipilih'),
                              ],
                            ),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.accent(context),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Pilih Lokasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
          contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding: EdgeInsets.all(16),
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _locationController.text = 'Lat: $_latitude, Lng: $_longitude';
      cameraPosition = LatLng(_latitude!, _longitude!);
      mapController.move(cameraPosition, cameraZoom);
    });
  }

  LatLng cameraPosition = LatLng(-8.135565, 113.221188);
  double cameraZoom = 14;
  var textController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      // Pastikan tidak ada proses kamera yang sedang berjalan
      if (_photoFile != null) {
        final file = File(_photoFile!.path);
        if (await file.exists()) {
          await file.delete();
        }
      }

      // Bersihkan memori
      setState(() {
        _imageData = null;
        _photoFile = null;
      });

      // Cek permission kamera
      final status = await Permission.camera.status;
      if (!status.isGranted) {
        final result = await Permission.camera.request();
        if (result.isDenied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Izin kamera diperlukan untuk mengambil foto'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          return;
        }
      }

      // Buka kamera dengan pengaturan yang lebih optimal
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker
          .pickImage(
            source: ImageSource.camera,
            imageQuality: 60, // Kualitas lebih rendah untuk performa lebih baik
            maxWidth: 1024, // Ukuran lebih kecil
            maxHeight: 768, // Aspek ratio 4:3 untuk foto
            preferredCameraDevice: CameraDevice.rear,
          )
          .timeout(
            Duration(seconds: 120),
            onTimeout:
                () => throw TimeoutException('Timeout saat mengambil foto'),
          );

      if (photo != null && mounted) {
        // Baca dan kompres file
        final bytes = await photo.readAsBytes();

        // Perbarui state
        setState(() {
          _photoFile = photo;
          _imageData = bytes;
        });

        // Feedback sukses
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto berhasil diambil'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } on TimeoutException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Waktu pengambilan foto habis: ${e.message}'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil foto: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Widget _buildImagePreview() {
    if (_imageData != null) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Preview Foto
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(_imageData!, fit: BoxFit.cover),
            ),
            // Overlay gelap semi-transparan
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
            // Label Preview Foto
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Preview Foto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tombol Aksi
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Tombol Ambil Ulang
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.refresh, color: Colors.white),
                      onPressed: _pickImage,
                      tooltip: 'Ambil Ulang Foto',
                    ),
                  ),
                  SizedBox(width: 8),
                  // Tombol Hapus
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _imageData = null;
                          _photoFile = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Foto telah dihapus'),
                            backgroundColor: Colors.grey,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      tooltip: 'Hapus Foto',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Tampilan saat tidak ada foto
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.camera_alt_outlined, size: 48, color: Colors.grey[600]),
          SizedBox(height: 8),
          Text(
            'Belum ada foto yang diambil',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Future<void> _submitReport() async {
    if (!mounted) return;
    if (!_formKey.currentState!.validate()) {
      showErrorDialog(context, 'Mohon lengkapi semua field yang diperlukan');
      return;
    }

    try {
      showLoadingDialog(context);

      if (_imageData == null) {
        Navigator.pop(context); // Tutup loading dialog
        showErrorDialog(context, 'Mohon ambil foto bencana terlebih dahulu');
        return;
      }

      if (_latitude == null || _longitude == null) {
        Navigator.pop(context); // Tutup loading dialog
        showErrorDialog(context, 'Mohon pilih lokasi bencana');
        return;
      }

      if (_selectedDisasterType == null || _selectedDisasterType!.isEmpty) {
        Navigator.pop(context); // Tutup loading dialog
        showErrorDialog(context, 'Mohon pilih jenis bencana');
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_image.jpg');
      await tempFile.writeAsBytes(_imageData!);

      final response = await _apiService.laporBencana(
        lokasi: _locationController.text,
        latitude: _latitude!,
        longitude: _longitude!,
        jenisBencana: _selectedDisasterType!,
        deskripsi: _descriptionController.text,
        foto: tempFile,
      );

      if (!mounted) return;
      Navigator.pop(context);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await showSuccessDialog(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
          (route) => false,
        );
      } else {
        // Handle error response
        final responseData = response.data;
        String errorMessage = responseData['message'] ?? 'Terjadi kesalahan saat mengirim laporan';
        
        if (errorMessage.contains('luar wilayah Lumajang')) {
          showErrorDialog(context, 'Lokasi yang dipilih berada di luar wilayah Lumajang. Mohon pilih lokasi yang berada dalam wilayah Lumajang.');
        } else if (errorMessage.contains('batas maksimal laporan')) {
          showErrorDialog(context, 'Anda telah mencapai batas maksimal laporan hari ini (10 laporan). Silakan coba lagi besok.');
        } else {
          showErrorDialog(context, errorMessage);
        }
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);

      String errorMessage = '';
      if (e is NetworkException) {
        errorMessage = 'Tidak dapat terhubung ke server. Mohon periksa koneksi internet Anda.';
      } else if (e is TimeoutException) {
        errorMessage = 'Waktu koneksi habis. Silakan coba lagi.';
      } else if (e is ServerException) {
        errorMessage = 'Terjadi kesalahan pada server: ${e.message}';
      } else if (e is ValidationException) {
        errorMessage = e.message;
      } else {
        errorMessage = 'Terjadi kesalahan yang tidak diketahui. Silakan coba lagi nanti.';
      }

      showErrorDialog(context, errorMessage);
    }
  }

  void _onMapMove(MapPosition position, bool hasGesture) {
    if (hasGesture) {
      setState(() {
        cameraPosition = position.center!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: ThemeColors.primary(context),
      body: Stack(
        children: [
          // Layer 1: Background image
          Positioned.fill(
            child: Image.asset(
              isDarkMode 
                ? 'assets/images/background_dark.png'
                : 'assets/images/background_light.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Layer 2: Content
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Laporkan Bencana',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textPrimary(context),
                    ),
                  ),
                ),
                
                // Main Content dengan padding bottom untuk bottom bar
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 100, // Tambahkan padding untuk bottom bar
                      ),
                      child: Column(
                        children: [
                          // Map Container
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.shadowColor(context),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MapPicker(
                                mapPickerController: mapPickerController,
                                child: FlutterMap(
                                  mapController: mapController,
                                  options: MapOptions(
                                    initialCenter: cameraPosition,
                                    initialZoom: cameraZoom,
                                    onTap: (_, point) {
                                      setState(() {
                                        cameraPosition = point;
                                        _latitude = point.latitude;
                                        _longitude = point.longitude;
                                        _locationController.text = 'Lat: $_latitude, Lng: $_longitude';
                                      });
                                    },
                                  ),
                                  children: [
                                    TileLayer(
                                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                                    ),
                                    MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 40,
                                          height: 40,
                                          point: cameraPosition,
                                          child: Icon(
                                            Icons.location_on,
                                            color: ThemeColors.error,
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          
                          // Form Container
                          Container(
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
                                  // Location Field
                                  TextFormField(
                                    controller: _locationController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: 'Lokasi',
                                      hintStyle: TextStyle(color: ThemeColors.textGrey(context)),
                                      prefixIcon: Icon(Icons.location_on, color: ThemeColors.inputIcon(context)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: ThemeColors.inputFill(context),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  
                                  // Get Location Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _getCurrentLocation,
                                      icon: Icon(Icons.my_location),
                                      label: Text('Gunakan Lokasi Saat Ini'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ThemeColors.accent(context),
                                        foregroundColor: ThemeColors.buttonText(context),
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),

                                  // Dropdown Jenis Bencana
                                  DropdownButtonFormField<String>(
                                    value: _selectedDisasterType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDisasterType = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      // labelText: 'Jenis Bencana',
                                      prefixIcon: Icon(Icons.warning_amber, color: ThemeColors.inputIcon(context)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: ThemeColors.inputFill(context),
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Banjir',
                                        child: Row(
                                          children: [
                                            Icon(Icons.invert_colors, color: Colors.blue),
                                            SizedBox(width: 8.0),
                                            Text('Banjir'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Longsor',
                                        child: Row(
                                          children: [
                                            Icon(Icons.terrain, color: Colors.brown),
                                            SizedBox(width: 8.0),
                                            Text('Longsor'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Erupsi',
                                        child: Row(
                                          children: [
                                            Icon(Icons.whatshot, color: Colors.red),
                                            SizedBox(width: 8.0),
                                            Text('Erupsi'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Lahar Panas',
                                        child: Row(
                                          children: [
                                            Icon(Icons.local_fire_department, color: Colors.orange),
                                            SizedBox(width: 8.0),
                                            Text('Lahar Panas'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Lahar Dingin',
                                        child: Row(
                                          children: [
                                            Icon(Icons.ac_unit, color: Colors.cyan),
                                            SizedBox(width: 8.0),
                                            Text('Lahar Dingin'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Gempa',
                                        child: Row(
                                          children: [
                                            Icon(Icons.vibration, color: Colors.grey),
                                            SizedBox(width: 8.0),
                                            Text('Gempa'),
                                          ],
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Angin Topan',
                                        child: Row(
                                          children: [
                                            Icon(Icons.air, color: Colors.lightBlue),
                                            SizedBox(width: 8.0),
                                            Text('Angin Topan'),
                                          ],
                                        ),
                                      ),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mohon pilih jenis bencana';
                                      }
                                      return null;
                                    },
                                    hint: Text('Pilih Jenis Bencana'),
                                  ),
                                  SizedBox(height: 16),
                                  
                                  // Description Field
                                  TextFormField(
                                    controller: _descriptionController,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText: 'Deskripsi Bencana',
                                      hintStyle: TextStyle(color: ThemeColors.textGrey(context)),
                                      prefixIcon: Icon(Icons.description, color: ThemeColors.inputIcon(context)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: ThemeColors.inputFill(context),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mohon isi deskripsi bencana';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  
                                  // Photo Container
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: ThemeColors.inputFill(context),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: ThemeColors.inputBorder(context),
                                        width: 1,
                                      ),
                                    ),
                                    child: _imageData != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.memory(
                                              _imageData!,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  size: 48,
                                                  color: ThemeColors.textGrey(context),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Tambahkan Foto',
                                                  style: TextStyle(
                                                    color: ThemeColors.textGrey(context),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                  SizedBox(height: 16),
                                  
                                  // Take Photo Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: _pickImage,
                                      icon: Icon(Icons.camera_alt),
                                      label: Text('Ambil Foto'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ThemeColors.accent(context),
                                        foregroundColor: ThemeColors.buttonText(context),
                                        padding: EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  
                                  // Submit Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _submitReport();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ThemeColors.accent(context),
                                        foregroundColor: ThemeColors.buttonText(context),
                                        padding: EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'KIRIM LAPORAN',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
          
          // Layer 3: Bottom Bar yang mengambang
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomBar(currentPage: 'lapor'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Bersihkan memori
    _imageData = null;
    _photoFile = null;
    _descriptionController.dispose();
    _locationController.dispose();
    textController.dispose();
    super.dispose();
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
