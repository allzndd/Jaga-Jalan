import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme_colors.dart';

class EmergencyContactsSheet extends StatelessWidget {
  final List<EmergencyContact> emergencyContacts = [
    EmergencyContact(
      name: 'Polisi',
      number: '110',
      icon: Icons.local_police,
      color: Colors.blue,
    ),
    EmergencyContact(
      name: 'Ambulans',
      number: '118',
      icon: Icons.medical_services,
      color: Colors.red,
    ),
    EmergencyContact(
      name: 'Pemadam Kebakaran',
      number: '113',
      icon: Icons.fire_truck,
      color: Colors.orange,
    ),
    EmergencyContact(
      name: 'SAR/BASARNAS',
      number: '115',
      icon: Icons.support,
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeColors.background(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nomor Darurat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ThemeColors.textPrimary(context),
            ),
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: emergencyContacts.length,
            itemBuilder: (context, index) {
              final contact = emergencyContacts[index];
              return InkWell(
                onTap: () => _makePhoneCall(contact.number),
                child: Container(
                  decoration: BoxDecoration(
                    color: contact.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: contact.color.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        contact.icon,
                        color: contact.color,
                        size: 32,
                      ),
                      SizedBox(height: 8),
                      Text(
                        contact.name,
                        style: TextStyle(
                          color: ThemeColors.textPrimary(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        contact.number,
                        style: TextStyle(
                          color: contact.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Tekan untuk menghubungi langsung',
            style: TextStyle(
              color: ThemeColors.textSecondary(context),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri');
    }
  }
}

class EmergencyContact {
  final String name;
  final String number;
  final IconData icon;
  final Color color;

  EmergencyContact({
    required this.name,
    required this.number,
    required this.icon,
    required this.color,
  });
}