import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xFF52B44F);
  static const Color lightGreen = Color.fromARGB(255, 220, 255, 220);
  static const Color darkBlue = Color(0xff1E2E3D);
  static const Color darkerBlue = Color(0xff152534);
  static const Color darkestBlue = Color(0xff0C1C2E);
  static const Color darkGreen = Color(0xFF243D1E);
  static const Color darkerGreen = Color(0xFF153419);
  static const Color darkestGreen = Color(0xFF112E0C);

  static const List<Color> blueGradient = [
    darkBlue,
    darkerBlue,
    darkestBlue,
  ];

  static const List<Color> greenGradient = [
    primaryColor,
    darkestGreen,
  ];
}
