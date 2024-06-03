import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final Color backgroundColor = Color(0xFFD5F5E3); // Adjust this color to match the exact color from the image.

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFD0F0C0), // Specific green color from your image
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.greenAccent, // Accent color if needed
          primary: Color(0xFFD0F0C0), // Primary color
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Black text color
          bodyText2: TextStyle(color: Colors.black), // Black text color
        ),
      ),
      home: FavoriteAccountsPage(),
    );
  }
}

class FavoriteAccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer ke Sesama'),
        backgroundColor: Color(0xFFD0F0C0), // Specific green color from your image
      ),
      backgroundColor: Color(0xFFD0F0C0), // Specific green color from your image
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Cari...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(color: Colors.black), // Black text color
                  ),
                ),
                SizedBox(width: 8.0),
                TextButton(
                  onPressed: () {},
                  child: Text('Edit', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Tambah', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildAccountItem('TAHAPAN WADIAH ONLINE', 'RIRI ANDIRI DELIA SUTARNO - 0352000426', 'TW'),
                _buildAccountItem('Infaq', 'BAZNAS - 0011777711', 'I'),
                _buildAccountItem('Zakat', 'BAZNAS - 0011555510', 'Z'),
                _buildAccountItem('Zakat', 'Inisiatif Zakat Indonesia - 0011210077', 'Z'),
                _buildAccountItem('Infaq', 'Inisiatif Zakat Indonesia - 0011210044', 'I'),
                _buildAccountItem('Zakat', 'LAZ Baitul Maal Hidayatullah - 0016000066', 'Z'),
                _buildAccountItem('Zakat', 'LAZIS Dewan Da\'wah - 0011002002', 'Z'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Transfer Baru'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Using green for button
                minimumSize: Size(double.infinity, 50), // Make button full-width
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(String title, String subtitle, String initials) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(initials, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green, // Use green color for avatar background
      ),
      title: Text(title, style: TextStyle(color: Colors.black)), // Black text color
      subtitle: Text(subtitle, style: TextStyle(color: Colors.black)), // Black text color
      onTap: () {},
    );
  }
}
