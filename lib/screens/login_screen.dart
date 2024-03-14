import 'dart:async';
import 'dart:convert';

import 'package:bmt_dt_mobile_app/utils/helpers/snackbar_helper.dart';
import 'package:bmt_dt_mobile_app/values/app_regex.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../components/app_text_form_field.dart';
import '../resources/resources.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_constants.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import 'camera_id_screen.dart';

Future<CreateToken> createAlbum(String username, String password) async {
  final createToken = CreateToken(
    status: 'OK',
    dataPost: [
      DataPost(username: username, password: password),
    ],
  );

  final response = await http.post(
    Uri.parse('https://dkuapi.dkuindonesia.id/api/Authorization/create_token'),
    headers: <String, String>{
      // 'Content-Type': 'application/json; charset=UTF-8',
      'ClientID':
          'Qb2aFQFWgfCD2svIjE9JiwU7kiC43oJRWytmuzlTADZw4PYQY10Fd8i14gBhyivh90JckPjxVPzLb1fPsyVEt3vDqV70uM2gpAyRGXB9ZFaTkIoT1X8thOnoXOaQ8un5p2c7P\/O10PwRnBY3MgmSDDVtEM9F6UnGt8\/KBP6pUzqc\/H2Ns\/Bn9jLs4mbPqYf\/qKAO+OLgT+ksAKb3p1Zqg\/CHrGyPrUSUC12XXPUGdogax40zWRZKqpL0\/wKF59LR6Vgv8Vlf9OT5oRTrvrIRgFlY3CH1wsIQxI+\/\/meeZJHjfFa8EJNGIvaE5qzY9dUqr\/Cibqd+Tlt7x38gEckBzo6oXtqjMN+WaEmc6K8ft\/ypY\/4vjHNXqd3mjMGXyCePf6WFAm2cyk4xksvymqf1yQ=='
    },
    // body: jsonEncode(<String, String>{
    //   'status': 'OK'
    //   'data_post': [{
    //       'username': username,
    //       'password': password,
    //   }]
    // }),
    body: jsonEncode(createToken),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return CreateToken.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class DataPost {
  DataPost({required this.username, this.password});
  // non-nullable - assuming the score field is always present
  final String? username;
  // nullable - assuming the review field is optional
  final String? password;

  factory DataPost.fromJson(Map<String, dynamic> data) {
    final username = data['username'] as String;
    final password = data['password'] as String?;
    return DataPost(username: username, password: password);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class CreateToken {
  CreateToken({
    required this.status,
    required this.dataPost,
  });
  final String status;
  final List<DataPost> dataPost;

  factory CreateToken.fromJson(Map<String, dynamic> data) {
    final status = data['status'] as String;
    final dataPost = data['data_post'] as List<dynamic>?;
    return CreateToken(
      status: status,
      dataPost: dataPost != null
          ? dataPost
              // map each review to a Review object
              .map((dataPost) =>
                  DataPost.fromJson(dataPost as Map<String, dynamic>))
              .toList() // map() returns an Iterable so we convert it to a List
          : <DataPost>[], // use an empty list as fallback value
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController phoneController;
  late final TextEditingController passwordController;

  Future<CreateToken>? _futureAlbum;

  void initializeControllers() {
    phoneController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    phoneController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final user_phone = phoneController.text;
    final password = passwordController.text;

    if (user_phone.isEmpty && password.isEmpty) return;

    if (AppRegex.user_phoneRegex.hasMatch(user_phone) &&
        AppRegex.passwordRegex.hasMatch(password)) {
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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background1.jpg'),
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
                          AppStrings.signInToYourNAccount,
                          style: AppTheme.titleLarge,
                        ),
                        Text(
                          AppStrings.signInToYourAccount,
                          style: AppTheme.bodySmall,
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage('assets/icon/icon_text.png'),
                      height: 50,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Image(
              image: AssetImage('assets/icon/icon.png'),
              height: 180,
              alignment: Alignment.topCenter,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFormField(
                      controller: phoneController,
                      labelText: AppStrings.phone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterPhone
                            : AppConstants.user_phoneRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidPhone;
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: IconButton(
                            onPressed: () =>
                                passwordNotifier.value = !passwordObscure,
                            style: IconButton.styleFrom(
                              minimumSize: const Size.square(48),
                            ),
                            icon: Icon(
                              passwordObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.black,
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
                                  // setState(() {
                                  //   _futureAlbum = createAlbum(
                                  //       phoneController.text,
                                  //       passwordController.text);
                                  // });
                                  SnackbarHelper.showSnackBar(
                                    AppStrings.loggedIn,
                                  );
                                  SnackbarHelper.showSnackBar(
                                    _futureAlbum.toString(),
                                  );
                                  NavigationHelper.pushReplacementNamed(
                                    AppRoutes.home,
                                  );
                                  phoneController.clear();
                                  passwordController.clear();
                                }
                              : null,
                          child: const Text(AppStrings.login),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: SvgPicture.asset(Vectors.fingerprint,
                                width: 60),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.doNotHaveAnAccount,
                          style:
                              AppTheme.bodySmall.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          // onPressed: () =>
                          //     NavigationHelper.pushReplacementNamed(
                          //   AppRoutes.register,
                          // ),
                          // onPressed: () =>
                          onPressed: () async {
                            await availableCameras().then((value) =>
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            CameraIDPage(cameras: value))));
                          },
                          //   NavigationHelper.pushReplacementNamed(
                          // AppRoutes.register,
                          //   NavigationHelper.pushReplacementNamed(
                          // AppRoutes.register,
                          // ),
                          child: const Text(AppStrings.register),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Version',
                      style: AppTheme.bodySmall.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '1.0.0',
                      style: AppTheme.bodySmall.copyWith(color: Colors.grey),
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
