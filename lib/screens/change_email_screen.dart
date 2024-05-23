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

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController newEmailController;
  late final TextEditingController confirmEmailController;

  final ValueNotifier<bool> emailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> newEmailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmEmailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    newEmailController = TextEditingController()
      ..addListener(controllerListener);
    confirmEmailController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    newEmailController.dispose();
    confirmEmailController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final newEmail = newEmailController.text;
    final confirmEmail = confirmEmailController.text;

    if (email.isEmpty && newEmail.isEmpty && confirmEmail.isEmpty) {
      return;
    }

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.emailRegex.hasMatch(newEmail) &&
        AppRegex.emailRegex.hasMatch(confirmEmail)) {
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
          padding: EdgeInsets.zero,
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
                    AppTextFormField(
                      labelText: AppStrings.confirmEmail,
                      controller: confirmEmailController,
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
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () {
                                  SnackbarHelper.showSnackBar(
                                    AppStrings.changeEmailComplete,
                                  );
                                  emailController.clear();
                                  newEmailController.clear();
                                  confirmEmailController.clear();
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
