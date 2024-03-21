import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import 'camera_photo_screen.dart';

class PreviewIDPage extends StatelessWidget {
  const PreviewIDPage({required this.picture, super.key});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.jpg'),
          fit: BoxFit.contain,
        ),
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.cameraIDTitle,
                          style: AppTheme.titleLarge,
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.cameraIDSubtitle,
                          style: AppTheme.bodySmall,
                        ),
                      ],
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
                  // ),
                  onPressed: () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraPhotoPage(cameras: value))));
                  },

                  child: const Text(AppStrings.cameraPhotoTitle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
