import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import 'profil_page.dart';
import 'report_page.dart';
import 'history_page.dart';
import 'cuaca_page.dart';
import 'dart:typed_data';
import 'report_jalan.dart';
import './config/theme_colors.dart';
import 'widgets/custom_bottom_bar.dart';
import 'package:jaga_jalan/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart' hide ServiceStatus;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'services/auth_service.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Marker> _markers = [];
  String? _selectedFilter;
  TextEditingController _searchController = TextEditingController();
  LatLng? _userLocation;
  LatLng? _destinationLocation;
  List<LatLng> _routePoints = [];
  final MapController mapController = MapController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _setupTokenExpiredHandler();
    _fetchLocations();
    _getCurrentLocation();
  }

  void _setupTokenExpiredHandler() {
    ApiService.onTokenExpired = () {
      if (mounted) {
        ApiService.handleTokenExpired(context);
      }
    };
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    ApiService.onTokenExpired = null;
    super.dispose();
  }

  Future<void> _fetchLocations() async {
    final apiService = ApiService();

    if (_selectedFilter == null || _selectedFilter == 'laporan_bencana') {
      final bencanaResponse = await apiService.getLaporanBencana();
      if (bencanaResponse.statusCode == 200) {
        final List<dynamic> bencanaData = bencanaResponse.data['data'];

        setState(() {
          if (_selectedFilter == 'laporan_bencana') _markers.clear();

          for (var location in bencanaData) {
            _addMarker(
              double.parse(location['latitude']),
              double.parse(location['longitude']),
              location['jenis_bencana'],
              location['deskripsi'] ?? '',
              location['foto_url'] ?? '',
              location['status'] ?? 'menunggu',
              location['lokasi'],
            );
          }
        });
      }
    }

    if (_selectedFilter == null || _selectedFilter == 'laporan_jalan') {
      final jalanResponse = await apiService.getLaporanJalan();
      if (jalanResponse.statusCode == 200) {
        final List<dynamic> jalanData = jalanResponse.data['data'];

        setState(() {
          if (_selectedFilter == 'laporan_jalan') _markers.clear();
          
          for (var location in jalanData) {
            _addMarker(
              double.parse(location['latitude']),
              double.parse(location['longitude']),
              location['jenis_rusak'],
              location['deskripsi'] ?? '',
              location['foto_url'] ?? '',
              location['status'] ?? 'menunggu',
              location['lokasi'],
            );
          }
        });
      }
    }
  }

  Future<Map<String, double>> _getCoordinatesFromAddress(String address) async {
    final response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$address&format=json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        return {
          'lat': double.parse(data[0]['lat']),
          'lon': double.parse(data[0]['lon']),
        };
      } else {
        throw Exception('No coordinates found for the address');
      }
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

  void _addMarker(
    double latitude,
    double longitude,
    String jenisLaporan,
    String deskripsi,
    String fotoUrl,
    String status,
    String lokasi,
  ) {
    String jenis = jenisLaporan.toLowerCase();
    IconData iconData = Icons.location_pin;
    Color iconColor = Colors.red;
    Widget markerWidget;

    switch (jenis) {
      case 'banjir':
        markerWidget = Image.asset(
          'assets/icons/Banjir.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'longsor':
        markerWidget = Image.asset(
          'assets/icons/Longsor.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'erupsi':
        markerWidget = Image.asset(
          'assets/icons/Erupsi.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'lahar panas':
        markerWidget = Image.asset(
          'assets/icons/Lahar Panas.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'lahar dingin':
        markerWidget = Image.asset(
          'assets/icons/Lahar Dingin.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'gempa':
        iconData = Icons.vibration;
        iconColor = Colors.grey;
        markerWidget = Icon(iconData, color: iconColor, size: 40.0);
        break;
      case 'angin topan':
        markerWidget = Image.asset(
          'assets/icons/Angin Topan.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'jalan rusak ringan':
        markerWidget = Image.asset(
          'assets/icons/Jalan Rusak Ringan.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      case 'jalan rusak berat':
        markerWidget = Image.asset(
          'assets/icons/Jalan Rusak Berat.png',
          width: 40.0,
          height: 40.0,
        );
        break;
      default:
        markerWidget = Icon(iconData, color: iconColor, size: 40.0);
    }

    setState(() {
      _markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(latitude, longitude),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeColors.background(context),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fotoUrl.isNotEmpty)
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              fotoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Gagal memuat foto',
                                    style: TextStyle(
                                      color: ThemeColors.textSecondary(context),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 16),
                      Text(
                        'Jenis: $jenisLaporan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.textPrimary(context),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Lokasi: $lokasi',
                        style: TextStyle(
                          color: ThemeColors.textSecondary(context),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          color: ThemeColors.textSecondary(context),
                        ),
                      ),
                      if (deskripsi.isNotEmpty) ...[
                        SizedBox(height: 8),
                        Text(
                          'Deskripsi: $deskripsi',
                          style: TextStyle(
                            color: ThemeColors.textSecondary(context),
                          ),
                        ),
                      ],
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.accent(context),
                            foregroundColor: ThemeColors.buttonText(context),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text('Tutup'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: markerWidget,
          ),
        ),
      );
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedFilter == filter) {
        _selectedFilter = null;
      } else {
        _selectedFilter = filter;
      }
      _fetchLocations();
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Layanan lokasi tidak aktif. Mohon aktifkan GPS Anda.'),
              backgroundColor: ThemeColors.error,
            ),
          );
        }
        return;
      }

      // Check location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Izin lokasi ditolak. Fitur navigasi tidak akan berfungsi.'),
                backgroundColor: ThemeColors.error,
              ),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Izin lokasi ditolak permanen. Mohon ubah di pengaturan perangkat.'),
              backgroundColor: ThemeColors.error,
              action: SnackBarAction(
                label: 'PENGATURAN',
                textColor: Colors.white,
                onPressed: () => Geolocator.openAppSettings(),
              ),
            ),
          );
        }
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error getting location: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mendapatkan lokasi: ${e.toString()}'),
            backgroundColor: ThemeColors.error,
          ),
        );
      }
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5&countrycodes=id'
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((place) => {
            'display_name': place['display_name'],
            'lat': double.parse(place['lat']),
            'lon': double.parse(place['lon']),
          }).toList();
          _isSearching = false;
        });
      }
    } catch (e) {
      print('Error searching places: $e');
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    }
  }

  Future<void> _searchLocation(String query) async {
    try {
      // Tampilkan loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              Text('Mencari lokasi...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Dapatkan koordinat dari alamat
      final coordinates = await _getCoordinatesFromAddress(query);
      
      if (!mounted) return;

      // Hapus marker tujuan yang lama jika ada
      setState(() {
        _markers.removeWhere((marker) => marker.point == _destinationLocation);
        _destinationLocation = LatLng(coordinates['lat']!, coordinates['lon']!);
        
        // Tambah marker baru untuk lokasi tujuan dengan GestureDetector
        _markers.add(
          Marker(
            width: 40.0,
            height: 40.0,
            point: _destinationLocation!,
            child: GestureDetector(
              onTap: () => _showSearchLocationModal(query),
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        );
      });

      // Tampilkan modal bottom sheet secara otomatis
      if (mounted) {
        _showSearchLocationModal(query);
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lokasi tidak ditemukan'),
            backgroundColor: ThemeColors.error,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _getRoute() async {
    if (_userLocation == null || _destinationLocation == null) return;

    try {
      final response = await http.get(Uri.parse(
        'https://router.project-osrm.org/route/v1/driving/'
        '${_userLocation!.longitude},${_userLocation!.latitude};'
        '${_destinationLocation!.longitude},${_destinationLocation!.latitude}'
        '?overview=full&geometries=polyline'
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String geometry = data['routes'][0]['geometry'];
        final List<LatLng> points = PolylinePoints()
            .decodePolyline(geometry)
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          _routePoints = points;
        });
      }
    } catch (e) {
      print('Error getting route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: ThemeColors.textPrimary(context),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: ThemeColors.background(context),
        elevation: 2,
        shadowColor: ThemeColors.shadowColor(context),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.account_circle,
              color: ThemeColors.accent(context),
              size: 28,
            ),
            offset: Offset(0, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: ThemeColors.background(context),
            onSelected: (value) {
              if (value == 'akun_saya') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              } else if (value == 'logout') {
                _showLogoutDialog(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'akun_saya',
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: ThemeColors.accent(context),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Akun Saya',
                      style: TextStyle(
                        color: ThemeColors.textPrimary(context),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: ThemeColors.error,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: ThemeColors.error,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _userLocation ?? LatLng(-8.135565, 113.221188),
              initialZoom: 11.0,
              interactiveFlags: InteractiveFlag.all,
            ),
            children: [
              openStreetMapTileLayer,
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4,
                      color: Colors.blue,
                    ),
                  ],
                ),
              MarkerLayer(markers: [
                if (_userLocation != null)
                  Marker(
                    width: 30.0,
                    height: 30.0,
                    point: _userLocation!,
                    child: Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ..._markers,
              ]),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.background(context).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: ThemeColors.textGrey(context).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(
                      color: ThemeColors.textPrimary(context),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari lokasi...',
                      hintStyle: TextStyle(
                        color: ThemeColors.textGrey(context),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ThemeColors.textGrey(context),
                        size: 20,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isSearching)
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ThemeColors.accent(context),
                                ),
                              ),
                            )
                          else if (_searchController.text.isNotEmpty)
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: ThemeColors.textGrey(context),
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _markers.removeWhere((marker) => 
                                    marker.point.latitude == _destinationLocation?.latitude &&
                                    marker.point.longitude == _destinationLocation?.longitude
                                  );
                                  _destinationLocation = null;
                                  _routePoints.clear();
                                  _searchResults = [];
                                });
                              },
                            ),
                          Container(
                            height: 24,
                            width: 1,
                            color: ThemeColors.textGrey(context).withOpacity(0.3),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.my_location,
                              color: ThemeColors.accent(context),
                              size: 20,
                            ),
                            onPressed: _getCurrentLocation,
                          ),
                        ],
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
                      _debounceTimer = Timer(Duration(milliseconds: 500), () {
                        _searchPlaces(value);
                      });
                    },
                  ),
                ),
                // Search Results
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: ThemeColors.background(context).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ThemeColors.textGrey(context).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final result = _searchResults[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _searchResults = [];
                              _searchController.text = result['display_name'];
                            });
                            _searchLocation(result['display_name']);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: index != _searchResults.length - 1
                                  ? Border(
                                      bottom: BorderSide(
                                        color: ThemeColors.textGrey(context).withOpacity(0.3),
                                        width: 1,
                                      ),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: ThemeColors.accent(context),
                                  size: 20,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    result['display_name'],
                                    style: TextStyle(
                                      color: ThemeColors.textPrimary(context),
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                // Filter Chips
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      _buildFilterChip(
                        label: 'Laporan Bencana',
                        filter: 'laporan_bencana',
                      ),
                      SizedBox(width: 8),
                      _buildFilterChip(
                        label: 'Laporan Jalan',
                        filter: 'laporan_jalan',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomBar(currentPage: 'dashboard'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String filter,
  }) {
    final isSelected = _selectedFilter == filter;

    return GestureDetector(
      onTap: () => _toggleFilter(filter),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? ThemeColors.accent(context) : ThemeColors.background(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? ThemeColors.accent(context) : ThemeColors.textGrey(context),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ThemeColors.shadowColor(context),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.filter_alt_outlined,
              size: 18,
              color: isSelected ? ThemeColors.buttonText(context) : ThemeColors.textGrey(context),
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? ThemeColors.buttonText(context) : ThemeColors.textGrey(context),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeColors.background(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Konfirmasi Logout',
            style: TextStyle(
              color: ThemeColors.textPrimary(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin logout?',
            style: TextStyle(
              color: ThemeColors.textSecondary(context),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: ThemeColors.accent(context),
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                await prefs.remove('id_pengguna');
                await prefs.remove('username');
                await prefs.remove('surel');
                
                if (!mounted) return;
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logout berhasil'),
                    backgroundColor: ThemeColors.success,
                    duration: Duration(seconds: 2),
                  ),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: ThemeColors.accent(context),
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi baru untuk menampilkan modal
  void _showSearchLocationModal(String query) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeColors.background(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi yang Dicari',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeColors.textPrimary(context),
              ),
            ),
            SizedBox(height: 8),
            Text(
              query,
              style: TextStyle(
                color: ThemeColors.textSecondary(context),
              ),
            ),
            SizedBox(height: 16),
            if (_userLocation != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _getRoute();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Rute berhasil ditampilkan'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.directions),
                  label: Text('Lihat Rute'),
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
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tutup'),
                style: TextButton.styleFrom(
                  foregroundColor: ThemeColors.textGrey(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    final result = await AuthService().logout();

    if (result['success']) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
