import 'package:flutter/material.dart';

import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../components/base_layout.dart';

class RegistrationSuccessPage extends StatefulWidget {
  final String? originPage;

  const RegistrationSuccessPage({super.key, this.originPage});

  @override
  State<RegistrationSuccessPage> createState() => _RegistrationSuccessPage();
}

class _RegistrationSuccessPage extends State<RegistrationSuccessPage> {
  void _onButtonPressed() {
    if (widget.originPage == 'home') {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      NavigationHelper.pushNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade200, Colors.green.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.greenAccent,
                  size: 100.0,
                ),
                SizedBox(height: 20),
                Text(
                  'Registrasi Berhasil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text(
                    widget.originPage == 'home'
                        ? 'Lanjut ke Halaman Home'
                        : 'Lanjut ke Halaman Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
