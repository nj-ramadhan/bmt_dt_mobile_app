import 'package:flutter/material.dart';

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

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> dataEmail = {};

  late final TextEditingController emailController;
  late final TextEditingController newEmailController;
  late final TextEditingController pinController;

  final ValueNotifier<bool> emailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> newEmailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> pinNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  Future<void> fetchEmailUpdate() async {
    debugPrint("debug: masuk ke api");
    final data = await ApiHelper.postEmailUpdate(
      loginToken: apiLoginToken,
      newEmail: newEmailController.text,
      pin: pinController.text,
    );

    dataEmail = data;
    setState(() {
      dataEmail = data;
      SnackbarHelper.showSnackBar(responseEmailUpdate(dataEmail));
    });
  }

  String? responseEmailUpdate(Map<String, String> data) {
    return data['message'];
  }

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    newEmailController = TextEditingController()
      ..addListener(controllerListener);
    pinController = TextEditingController()..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    newEmailController.dispose();
    pinController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final newEmail = newEmailController.text;
    final pin = pinController.text;

    if (email.isEmpty && newEmail.isEmpty && pin.isEmpty) {
      return;
    }

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.emailRegex.hasMatch(newEmail)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    emailController.text = apiDataAccountEmail;
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
                    AppTextFormField(
                      labelText: AppStrings.email,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterEmailAddress
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    AppTextFormField(
                      labelText: AppStrings.newEmail,
                      controller: newEmailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterNewEmailAddress
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: pinNotifier,
                      builder: (_, pinObscure, __) {
                        return AppTextFormField(
                          obscureText: pinObscure,
                          controller: pinController,
                          labelText: AppStrings.pin,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPin
                                : AppConstants.pinRegex.hasMatch(value)
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
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () {
                                  fetchEmailUpdate();
                                }
                              : null,
                          child: const Text(AppStrings.changeEmail),
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
