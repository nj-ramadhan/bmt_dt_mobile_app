import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../values/app_colors.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import 'camera_photo_preview_screen.dart';
import '../components/base_layout.dart';

class CameraPhotoPage extends StatefulWidget {
  const CameraPhotoPage({required this.cameras, super.key});

  final List<CameraDescription>? cameras;

  @override
  State<CameraPhotoPage> createState() => _CameraPhotoPageState();
}

class _CameraPhotoPageState extends State<CameraPhotoPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  // ignore: strict_raw_type
  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      await Navigator.push(
          context,
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
              builder: (context) => PreviewPhotoPage(
                    picture: picture,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  // ignore: strict_raw_type
  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint('camera error $e');
    }
  }

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
          //     image: AssetImage('assets/images/background2.jpg'),
          //     fit: BoxFit.cover),
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
                      const Text(
                        AppStrings.cameraPhotoTitle,
                        style: AppTheme.titleLarge,
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
              Stack(
                children: [
                  Column(
                    children: [
                      if (_cameraController.value.isInitialized)
                        CameraPreview(_cameraController)
                      else
                        Container(
                            color: Colors.black,
                            child:
                                const Center(child: CircularProgressIndicator())),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: const BoxDecoration(color: Colors.green),
                        child: Row(
                          children: [
                            Expanded(
                                child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 30,
                              icon: Icon(
                                  _isRearCameraSelected
                                      ? CupertinoIcons.switch_camera
                                      : CupertinoIcons.switch_camera_solid,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() => _isRearCameraSelected =
                                    !_isRearCameraSelected);
                                initCamera(widget
                                    .cameras![_isRearCameraSelected ? 0 : 1]);
                              },
                            )),
                            Expanded(
                                child: IconButton(
                              onPressed: takePicture,
                              iconSize: 50,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.circle, color: Colors.white),
                            )),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Image(image: AssetImage('assets/images/face_mask.png')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
