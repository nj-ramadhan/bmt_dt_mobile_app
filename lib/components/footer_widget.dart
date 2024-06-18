// footer_widget.dart
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  // final int currentIndex;
  final ValueChanged<int> onTap;

  const FooterWidget({
    Key? key,
    // required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Pengaturan',
        ),
      ],
    );
  }
}
