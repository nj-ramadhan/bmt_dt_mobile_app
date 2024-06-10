import 'package:flutter/material.dart';

import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController pinController;
  late final TextEditingController newPinController;
  late final TextEditingController confirmPinController;

  final ValueNotifier<bool> pinNotifier = ValueNotifier(true);
  final ValueNotifier<bool> newPinNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPinNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    pinController = TextEditingController()..addListener(controllerListener);
    newPinController = TextEditingController()..addListener(controllerListener);
    confirmPinController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    pinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
  }

  void controllerListener() {
    final pin = pinController.text;
    final newPin = newPinController.text;
    final confirmPin = confirmPinController.text;

    if (pin.isEmpty && newPin.isEmpty && confirmPin.isEmpty) {
      return;
    }

    if (AppRegex.emailRegex.hasMatch(pin) &&
        AppRegex.emailRegex.hasMatch(newPin) &&
        AppRegex.emailRegex.hasMatch(confirmPin)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        // image: DecorationImage(
        //     image: AssetImage('assets/images/background1.jpg'),
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushReplacementNamed(
                        AppRoutes.profile,
                      ),
                    ),
                    const Text(
                      AppStrings.email,
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
                    ValueListenableBuilder<bool>(
                      valueListenable: pinNotifier,
                      builder: (_, pinObscure, __) {
                        return AppTextFormField(
                          obscureText: pinObscure,
                          controller: pinController,
                          labelText: AppStrings.pin,
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
                              onPressed: () => pinNotifier.value = !pinObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                pinObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: newPinNotifier,
                      builder: (_, pinObscure, __) {
                        return AppTextFormField(
                          obscureText: pinObscure,
                          controller: newPinController,
                          labelText: AppStrings.newPin,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPin
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPin;
                          },
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            child: IconButton(
                              onPressed: () => pinNotifier.value = !pinObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                pinObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: confirmPinNotifier,
                      builder: (_, pinObscure, __) {
                        return AppTextFormField(
                          obscureText: pinObscure,
                          controller: confirmPinController,
                          labelText: AppStrings.confirmPin,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPin
                                : AppStrings.invalidPin;
                          },
                          suffixIcon: Focus(
                            descendantsAreFocusable: false,
                            child: IconButton(
                              onPressed: () => pinNotifier.value = !pinObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                pinObscure
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
                                  SnackbarHelper.showSnackBar(
                                    // ignore: void_checks
                                    AppStrings.changePinComplete,
                                  );
                                  pinController.clear();
                                  newPinController.clear();
                                  confirmPinController.clear();
                                }
                              : null,
                          child: const Text(AppStrings.changePin),
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
    );
  }
}
