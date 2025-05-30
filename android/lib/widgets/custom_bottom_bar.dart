import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config/theme_colors.dart';
import '../dashboard_page.dart';
import '../history_page.dart';
import '../cuaca_page.dart';
import '../widgets/emergency_contacts_sheet.dart';

class CustomBottomBar extends StatelessWidget {
  final String currentPage;

  const CustomBottomBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ThemeColors.background(context).withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Laporkan',
                style: TextStyle(
                  color: ThemeColors.textPrimary(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Pilih jenis laporan:',
                style: TextStyle(
                  color: ThemeColors.textPrimary(context),
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/report-jalan');
                },
                style: TextButton.styleFrom(
                  foregroundColor: ThemeColors.accent(context),
                ),
                child: Text('Laporkan Jalan Berlubang'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/report-bencana');
                },
                style: TextButton.styleFrom(
                  foregroundColor: ThemeColors.accent(context),
                ),
                child: Text('Laporkan Bencana Alam'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    IconData? icon,
    String? svgPath,
    String? activeSvgPath,
    required VoidCallback onTap,
    required bool isSelected,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected 
                ? ThemeColors.accent(context).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: svgPath != null
              ? svgPath.endsWith('.svg')
                  ? SvgPicture.asset(
                      isSelected ? activeSvgPath! : svgPath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isSelected 
                            ? ThemeColors.accent(context)
                            : ThemeColors.textGrey(context),
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.asset(
                      isSelected ? activeSvgPath! : svgPath,
                      width: 24,
                      height: 24,
                      color: isSelected 
                          ? ThemeColors.accent(context)
                          : ThemeColors.textGrey(context),
                    )
              : Icon(
                  icon,
                  color: isSelected 
                      ? ThemeColors.accent(context)
                      : ThemeColors.textGrey(context),
                  size: 24,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: ThemeColors.background(context),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.shadowColor(context).withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 5),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              svgPath: 'assets/icons/dashboard_nonaktif.svg',
              activeSvgPath: 'assets/icons/dashboard_aktif.svg',
              isSelected: currentPage == 'dashboard',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
              context: context,
            ),
            _buildNavItem(
              svgPath: 'assets/icons/report_nonaktif.png',
              activeSvgPath: 'assets/icons/report_aktif.png',
              isSelected: currentPage == 'lapor',
              onTap: () => _showReportDialog(context),
              context: context,
            ),
            _buildSOSButton(context),
            _buildNavItem(
              svgPath: 'assets/icons/history_nonaktif.png',
              activeSvgPath: 'assets/icons/history_aktif.png',
              isSelected: currentPage == 'riwayat',
              onTap: () {
                if (currentPage != 'riwayat') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryPage()),
                  );
                }
              },
              context: context,
            ),
            _buildNavItem(
              svgPath: 'assets/icons/weather_nonaktif.png',
              activeSvgPath: 'assets/icons/weather_aktif.png',
              isSelected: currentPage == 'cuaca',
              onTap: () {
                if (currentPage != 'cuaca') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CuacaPage()),
                  );
                }
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade600, Colors.red.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => EmergencyContactsSheet(),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.sos,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
} 