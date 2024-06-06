import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController passwordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> newPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  Future<void> updatePassword() async {
    const url =
        'https://dkuapi.dkuindonesia.id/api/Authorization/update_password';
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'old_password': passwordController.text,
      'new_password': newPasswordController.text,
      'confirm_password': confirmPasswordController.text,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      final responseBody = json.decode(response.body);
      final message = responseBody['message'].toString();
      // debugPrint('response: $headers');
      // debugPrint('response: $body');
      // debugPrint('response: $responseBody');
      debugPrint('response: $message');

      SnackbarHelper.showSnackBar(
        message,
      );

      passwordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void initializeControllers() {
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    newPasswordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final password = passwordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password.isEmpty && newPassword.isEmpty && confirmPassword.isEmpty) {
      return;
    }

    if (AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(newPassword) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword) &&
        newPassword == confirmPassword) {
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
                      AppStrings.password,
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
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
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
                    ValueListenableBuilder<bool>(
                      valueListenable: newPasswordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: newPasswordController,
                          labelText: AppStrings.newPassword,
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
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () =>
                                  newPasswordNotifier.value = !passwordObscure,
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
                      valueListenable: confirmPasswordNotifier,
                      builder: (_, confirmPasswordObscure, __) {
                        return AppTextFormField(
                          labelText: AppStrings.confirmPassword,
                          controller: confirmPasswordController,
                          obscureText: confirmPasswordObscure,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseReEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? newPasswordController.text ==
                                            confirmPasswordController.text
                                        ? null
                                        : AppStrings.passwordNotMatched
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants.
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () => confirmPasswordNotifier.value =
                                  !confirmPasswordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                confirmPasswordObscure
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
                          onPressed: isValid ? updatePassword : null,
                          child: const Text(AppStrings.changePassword),
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
