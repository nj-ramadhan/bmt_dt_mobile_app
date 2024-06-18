// base_layout.dart
import 'package:flutter/material.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../components/footer_widget.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  // final int currentIndex;

  const BaseLayout({
    Key? key,
    required this.child,
    // required this.currentIndex,
  }) : super(key: key);

  void onTabTapped(BuildContext context, int index) {
    // Handle navigation or actions based on the selected index
    switch (index) {
      case 0:
        NavigationHelper.pushNamed(AppRoutes.home); // Navigate to Home page
        break;
      case 1:
        NavigationHelper.pushNamed(AppRoutes.qrcode); // Navigate to QR page
        break;
      case 2:
        NavigationHelper.pushNamed(AppRoutes.home); // Navigate to Settings page
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: FooterWidget(
        // currentIndex: currentIndex,
        onTap: (index) => onTabTapped(context, index),
      ),
    );
  }
}
