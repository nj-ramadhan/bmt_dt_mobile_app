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

  Future<void> updateEmail() async {
    const url =
        'https://dkuapi.dkuindonesia.id/api/Authorization/update_password';
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'old_email': emailController.text,
      'new_email': newEmailController.text,
      // 'confirm_email': confirmEmailController.text,
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

      emailController.clear();
      newEmailController.clear();
      confirmEmailController.clear();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

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
        AppRegex.emailRegex.hasMatch(confirmEmail) &&
        newEmail == confirmEmail) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
    emailController.text = apiDataAccountEmail;
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
                            ? AppStrings.pleaseReEnterEmail
                            : AppConstants.emailRegex.hasMatch(value)
                                ? newEmailController.text ==
                                        confirmEmailController.text
                                    ? null
                                    : AppStrings.emailNotMatched
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () {
                                  updateEmail();
                                  // SnackbarHelper.showSnackBar(
                                  //   AppStrings.changeEmailComplete,
                                  // );
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
