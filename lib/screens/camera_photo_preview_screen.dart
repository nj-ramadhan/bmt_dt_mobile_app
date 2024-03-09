import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class PreviewPhotoPage extends StatelessWidget {
  const PreviewPhotoPage({required this.picture, super.key});

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
                          AppStrings.homeTitle,
                          style: AppTheme.titleLarge,
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.homeSubtitle,
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
