import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> dataProfile = {};

  late final TextEditingController idController;
  late final TextEditingController nameController;
  late final TextEditingController genderController;
  late final TextEditingController birthPlaceController;
  late final TextEditingController passwordController;
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(false);

  var _image;
  final picker = ImagePicker();

  Future<void> fetchProfileUpdate() async {
    debugPrint("debug: masuk ke api");
    final data = await ApiHelper.postProfileUpdate(
        loginToken: apiLoginToken,
        password: passwordController.text,
        idNumber: idController.text,
        fullName: nameController.text,
        gender: genderController.text,
        birthPlace: birthPlaceController.text,
        photoProfile: _image);

    dataProfile = data;
    setState(() {
      dataProfile = data;
      SnackbarHelper.showSnackBar(responseProfileUpdate(dataProfile));
    });
  }

  String? responseProfileUpdate(Map<String, String> data) {
    return data['message'];
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void initializeControllers() {
    idController = TextEditingController()..addListener(controllerListener);
    nameController = TextEditingController()..addListener(controllerListener);
    genderController = TextEditingController()..addListener(controllerListener);
    birthPlaceController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    idController.dispose();
    nameController.dispose();
    genderController.dispose();
    birthPlaceController.dispose();
  }

  void controllerListener() {
    final id = idController.text;
    final name = nameController.text;
    final gender = genderController.text;
    final birthPlace = birthPlaceController.text;
    final password = passwordController.text;
    if (id.isEmpty &&
        name.isEmpty &&
        gender.isEmpty &&
        birthPlace.isEmpty &&
        password.isEmpty) return;

    if (id.isNotEmpty &&
        name.isNotEmpty &&
        gender.isNotEmpty &&
        birthPlace.isNotEmpty) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }

    if (AppRegex.passwordRegex.hasMatch(password)) {
      passwordNotifier.value = true;
    } else {
      passwordNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    idController.text = apiDataUserNIK;
    nameController.text = apiDataUserNamaLengkap;
    genderController.text = apiDataUserJenisKelamin;
    birthPlaceController.text = apiDataUserTempatLahir;

    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
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
          image: DecorationImage(
              image: AssetImage('assets/images/background1.jpg'),
              fit: BoxFit.cover),
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
                          AppRoutes.profile,
                        ),
                      ),
                      const Text(
                        AppStrings.profileAccount,
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.id,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterId
                              : value.length < 15
                                  ? AppStrings.invalidId
                                  : null;
                        },
                        controller: idController,
                      ),
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.name,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterName
                              : value.length < 4
                                  ? AppStrings.invalidName
                                  : null;
                        },
                        controller: nameController,
                      ),
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.gender,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterGender
                              : value.length < 1
                                  ? AppStrings.invalidGender
                                  : null;
                        },
                        controller: genderController,
                      ),
                      AppTextFormField(
                        autofocus: true,
                        labelText: AppStrings.birthPlace,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterBirthPlace
                              : value.length < 1
                                  ? AppStrings.invalidBirthPlace
                                  : null;
                        },
                        controller: birthPlaceController,
                      ),
                      Text('Update Profile Photo'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: getImageFromCamera,
                              child: Text('Open Camera')),
                          TextButton(
                              onPressed: getImageFromGallery,
                              child: Text('Select from Gallery')),
                        ],
                      ),
                      Center(
                        // ignore: unnecessary_null_comparison
                        child: _image == null
                            ? Text('No Image selected')
                            : Image.file(_image),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: passwordNotifier,
                        builder: (_, passwordObscure, __) {
                          return AppTextFormField(
                            obscureText: passwordObscure,
                            controller: passwordController,
                            labelText: AppStrings.password,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (_) => _formKey.currentState?.validate(),
                            validator: (value) {
                              return value!.isEmpty
                                  ? AppStrings.pleaseEnterPassword
                                  : AppConstants.passwordRegex.hasMatch(value)
                                      ? null
                                      : AppStrings.invalidPassword;
                            },
                            suffixIcon: Focus(
                              descendantsAreFocusable: false,
                              child: IconButton(
                                onPressed: () =>
                                    passwordNotifier.value = !passwordObscure,
                                style: IconButton.styleFrom(
                                  minimumSize: const Size.square(48),
                                ),
                                icon: Icon(
                                  passwordObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: fieldValidNotifier,
                        builder: (_, isValid, __) {
                          return FilledButton(
                            onPressed: isValid
                                ? () {
                                    fetchProfileUpdate();
                                  }
                                : null,
                            child: const Text(AppStrings.profileAccountUpdate),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
