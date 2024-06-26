import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import 'camera_photo_screen.dart';
import '../components/base_layout.dart';

class PreviewIDPage extends StatelessWidget {
  const PreviewIDPage({required this.picture, super.key});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BaseLayout(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          // image: DecorationImage(
          //   image: AssetImage('assets/images/background1.jpg'),
          //   fit: BoxFit.contain,
          // ),
        ),
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.fromLTRB(0, screenHeight * 0.01, 0, 0),
            children: [
              GradientBackground(
                colors: const [Colors.transparent, Colors.transparent],
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => NavigationHelper.pushNamed(
                          AppRoutes.home,
                        ),
                      ),
                      const Text(
                        AppStrings.cameraIDTitle,
                        style: AppTheme.bodySmall,
                      ),
                      Image.network(
                        apiDataAppLogoBar,
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
                    //     NavigationHelper.pushNamed(
                    //   AppRoutes.register,
                    // ),
                    // ),
                    onPressed: () async {
                      await availableCameras().then(
                        (value) => Navigator.push(
                          context,
                          // ignore: inference_failure_on_instance_creation
                          MaterialPageRoute(
                            builder: (_) => CameraPhotoPage(cameras: value),
                          ),
                        ),
                      );
                    },
                    child: const Text(AppStrings.cameraPhotoTitle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
