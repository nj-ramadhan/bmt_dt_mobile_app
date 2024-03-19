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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background2.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const GradientBackground(
              colors: [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                      image: AssetImage('assets/icon/icon_text.png'),
                      height: 70,
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
