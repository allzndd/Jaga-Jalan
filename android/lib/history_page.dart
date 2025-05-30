import 'package:flutter/material.dart';
import 'dart:convert';
import './services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import './config/theme_colors.dart';
import 'widgets/custom_bottom_bar.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  List<dynamic> bencanaData = [];
  List<dynamic> jalanData = [];
  TabController? _tabController;
  final ApiService _apiService = ApiService();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => isLoading = true);
    final response = await _apiService.getRiwayatLaporan();
    if (response.statusCode == 200) {
      print('Response data: ${response.data}');
      
      setState(() {
        bencanaData = response.data['data']['bencana'] ?? [];
        jalanData = response.data['data']['jalan'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
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
                    'Riwayat Laporan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textPrimary(context),
                    ),
                  ),
                ),
                
                // TabBar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Bencana Alam'),
                      Tab(text: 'Kerusakan Jalan'),
                    ],
                    labelColor: ThemeColors.accent(context),
                    unselectedLabelColor: ThemeColors.textGrey(context),
                    indicatorColor: ThemeColors.accent(context),
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                
                // TabBarView dengan padding bottom untuk bottom bar
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchData,
                    color: ThemeColors.accent(context),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 100), // Tambahkan padding untuk bottom bar
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildBencanaList(),
                          _buildJalanList(),
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
            child: CustomBottomBar(currentPage: 'riwayat'),
          ),
        ],
      ),
    );
  }

  Widget _buildBencanaList() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ThemeColors.accent(context),
        ),
      );
    }
    
    if (bencanaData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: ThemeColors.textGrey(context),
            ),
            SizedBox(height: 16),
            Text(
              'Belum ada laporan bencana',
              style: TextStyle(
                color: ThemeColors.textGrey(context),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: bencanaData.length,
      itemBuilder: (context, index) {
        final item = bencanaData[index];
        return _buildHistoryCard(
          title: item['jenis_bencana'] ?? 'Tidak ada judul',
          date: _formatDate(item['created_at']),
          location: item['lokasi'] ?? 'Lokasi tidak tersedia',
          description: item['deskripsi'] ?? 'Tidak ada deskripsi',
          status: item['status'] ?? 'menunggu',
          imageUrl: item['foto_url'],
          latitude: item['latitude'] != null ? double.parse(item['latitude']) : null,
          longitude: item['longitude'] != null ? double.parse(item['longitude']) : null,
        );
      },
    );
  }

  Widget _buildJalanList() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ThemeColors.accent(context),
        ),
      );
    }
    
    if (jalanData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: ThemeColors.textGrey(context),
            ),
            SizedBox(height: 16),
            Text(
              'Belum ada laporan jalan',
              style: TextStyle(
                color: ThemeColors.textGrey(context),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: jalanData.length,
      itemBuilder: (context, index) {
        final item = jalanData[index];
        return _buildHistoryCard(
          title: item['jenis_rusak'] ?? 'Tidak ada judul',
          date: _formatDate(item['created_at']),
          location: item['lokasi'] ?? 'Lokasi tidak tersedia',
          description: item['deskripsi'] ?? 'Tidak ada deskripsi',
          status: item['status'] ?? 'menunggu',
          imageUrl: item['foto_url'],
          latitude: item['latitude'] != null ? double.parse(item['latitude']) : null,
          longitude: item['longitude'] != null ? double.parse(item['longitude']) : null,
        );
      },
    );
  }

  Widget _buildHistoryCard({
    required String title,
    required String date,
    required String location,
    required String description,
    required String status,
    String? imageUrl,
    double? latitude,
    double? longitude,
  }) {
    Color statusColor = _getStatusColor(status);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showDetailModal(
              title: title,
              date: date,
              location: location,
              description: description,
              status: status,
              imageUrl: imageUrl,
              latitude: latitude,
              longitude: longitude,
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.textPrimary(context),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        date,
                        style: TextStyle(
                          color: ThemeColors.textGrey(context),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    status.replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailModal({
    required String title,
    required String date,
    required String location,
    required String description,
    required String status,
    String? imageUrl,
    double? latitude,
    double? longitude,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ThemeColors.background(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl != null)
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: ThemeColors.inputFill(context),
                              child: Icon(
                                Icons.error,
                                color: ThemeColors.textGrey(context),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.textPrimary(context),
                          ),
                        ),
                        SizedBox(height: 8),
                        _buildStatusChip(status),
                        SizedBox(height: 16),
                        _buildInfoRow(Icons.access_time, date),
                        SizedBox(height: 8),
                        _buildInfoRow(Icons.location_on, location),
                        if (description.isNotEmpty) ...[
                          SizedBox(height: 16),
                          Text(
                            'Deskripsi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.textPrimary(context),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              color: ThemeColors.textSecondary(context),
                            ),
                          ),
                        ],
                        if (latitude != null && longitude != null) ...[
                          SizedBox(height: 16),
                          Text(
                            'Lokasi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.textPrimary(context),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ThemeColors.inputBorder(context),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(latitude, longitude),
                                  zoom: 15,
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        width: 40,
                                        height: 40,
                                        point: LatLng(latitude, longitude),
                                        child: Icon(
                                          Icons.location_pin,
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
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: ThemeColors.textGrey(context),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: ThemeColors.textSecondary(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor = _getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          color: statusColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return Colors.orange;
      case 'dalam_proses':
        return Colors.blue;
      case 'selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Tanggal tidak tersedia';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMMM yyyy, HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HistoryPage(),
  ));
}
