import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class PreviewPhotoPage extends StatelessWidget {
  const PreviewPhotoPage({required this.picture, super.key});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        // image: DecorationImage(
        //     image: AssetImage('assets/images/background2.jpg'),
        //     fit: BoxFit.cover),
      ),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientBackground(
              colors: const [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.cameraPhotoTitle,
                      style: AppTheme.titleLarge,
                    ),
                    Image(
                      image: const AssetImage('assets/icon/icon_text.png'),
                      width: screenWidth * 0.25,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(File(picture.path), fit: BoxFit.cover, width: 300),
                const SizedBox(height: 24),
                Text(picture.name),
                const SizedBox(height: 10),
                FilledButton(
                  // onPressed: () =>
                  //     NavigationHelper.pushReplacementNamed(
                  //   AppRoutes.register,
                  // ),
                  onPressed: () =>
                      //   NavigationHelper.pushReplacementNamed(
                      // AppRoutes.register,
                      NavigationHelper.pushReplacementNamed(
                    AppRoutes.register,
                  ),
                  child: const Text(AppStrings.registerFill),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
