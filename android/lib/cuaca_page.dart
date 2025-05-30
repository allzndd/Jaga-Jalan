import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'dashboard_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_picker/map_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'config/api_config.dart';
import 'config/theme_colors.dart';
import 'widgets/custom_bottom_bar.dart';

class CuacaPage extends StatefulWidget {
  @override
  _CuacaPageState createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final mapController = MapController();
  final mapPickerController = MapPickerController();
  LatLng cameraPosition = LatLng(-8.135565, 113.221188);
  double cameraZoom = 13.0;
  final textController = TextEditingController();
  List<Map<String, dynamic>> cuaca = [];
  Map<String, dynamic> locationInfo = {};
  Timer? _debounceTimer;
  String currentWeatherIcon = 'https://cdn.weatherapi.com/weather/64x64/day/116.png';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWeather(cameraPosition.latitude, cameraPosition.longitude);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _debouncedGetWeather(double latitude, double longitude) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      getWeather(latitude, longitude);
    });
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
                    'Cuaca Hari Ini',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textPrimary(context),
                    ),
                  ),
                ),
                
                // Map dan Weather List dengan padding bottom untuk bottom bar
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100), // Tambahkan padding untuk bottom bar
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              // Map
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: MapPicker(
                                    mapPickerController: mapPickerController,
                                    child: FlutterMap(
                                      mapController: mapController,
                                      options: MapOptions(
                                        initialCenter: cameraPosition,
                                        initialZoom: cameraZoom,
                                        onPositionChanged: (MapPosition position, bool hasGesture) {
                                          if (hasGesture) {
                                            mapPickerController.mapMoving!();
                                            setState(() {
                                              cameraPosition = position.center!;
                                              cameraZoom = position.zoom!;
                                            });
                                            _debouncedGetWeather(position.center!.latitude, position.center!.longitude);
                                          }
                                        },
                                      ),
                                      children: [
                                        openStreetMapTileLayer,
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 50,
                                              height: 50,
                                              point: cameraPosition,
                                              child: _buildWeatherMarker(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Location info overlay
                              if (locationInfo.isNotEmpty)
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  right: 16,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: ThemeColors.background(context),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ThemeColors.shadowColor(context),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          locationInfo['name'] ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColors.textPrimary(context),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${locationInfo['state'] ?? ''}, ${locationInfo['country'] ?? ''}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: ThemeColors.textSecondary(context),
                                          ),
                                        ),
                                        if (locationInfo['jarak'] != null) ...[
                                          SizedBox(height: 4),
                                          Text(
                                            'Jarak: ${locationInfo['jarak']} km',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ThemeColors.accent(context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        
                        // Weather list
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(16),
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
                            child: _buildWeatherList(),
                          ),
                        ),
                      ],
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
            child: CustomBottomBar(currentPage: 'cuaca'),
          ),
        ],
      ),
    );
  }

  Future<void> getWeather(double latitude, double longitude) async {
    final url = '${ApiConfig.apiUrl}/cuaca?lat=$latitude&lon=$longitude';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        locationInfo = data['location'];
        cuaca = List<Map<String, dynamic>>.from(data['weather'] ?? []);
        textController.text = '${locationInfo['kecamatan']}, ${locationInfo['kota']}\n'
            'Jarak: ${locationInfo['jarak']} km';
      });
    } else {
      print('Failed to load weather data: ${response.statusCode}');
      print('Response body: ${response.body}');
      setState(() {
        cuaca = [];
        locationInfo = {};
      });
    }
  }

  Widget _buildWeatherList() {
    if (cuaca.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off,
              size: 48,
              color: ThemeColors.textGrey(context),
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada data cuaca',
              style: TextStyle(
                color: ThemeColors.textGrey(context),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: cuaca.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final weather = cuaca[index];
        final time = DateTime.parse(weather['datetime']);
        
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ThemeColors.cardBackground(context),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: ThemeColors.shadowColor(context),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Weather icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ThemeColors.inputFill(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    weather['icon'].toString().startsWith('http') 
                        ? weather['icon'] 
                        : 'https:${weather['icon']}',
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.cloud,
                        size: 40,
                        color: ThemeColors.textGrey(context),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Weather info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather['temp']}°C',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.textPrimary(context),
                      ),
                    ),
                    Text(
                      weather['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: ThemeColors.textSecondary(context),
                      ),
                    ),
                    Text(
                      'Kelembaban: ${weather['humidity']}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.textGrey(context),
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy, HH:mm').format(time),
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.textGrey(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherMarker() {
    // Dapatkan rotasi dengan try-catch untuk menangani kasus ketika controller belum siap
    double rotation = 0.0;
    try {
      rotation = mapController.rotation;
    } catch (e) {
      // Gunakan nilai default 0.0 jika rotasi tidak dapat diakses
      rotation = 0.0;
    }
    
    if (cuaca.isEmpty) {
      return Transform.rotate(
        angle: -rotation * (3.141592653589793 / 180),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: ThemeColors.background(context),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ThemeColors.shadowColor(context),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Icon(
            Icons.location_on,
            size: 18,
            color: ThemeColors.error,
          ),
        ),
      );
    }

    // Ambil cuaca saat ini berdasarkan jam
    final now = DateTime.now();
    final currentWeather = cuaca.firstWhere(
      (weather) => DateTime.parse(weather['datetime']).hour == now.hour,
      orElse: () => cuaca[0],
    );

    final iconUrl = currentWeather['icon'].toString().startsWith('http') 
        ? currentWeather['icon'] 
        : 'https:${currentWeather['icon']}';

    return Transform.rotate(
      angle: -rotation * (3.141592653589793 / 180),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: ThemeColors.background(context),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ThemeColors.shadowColor(context),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            iconUrl,
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.cloud,
                size: 16,
                color: ThemeColors.textGrey(context),
              );
            },
          ),
        ),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
