import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../resources/resources.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> dataDetailLembaga = {};
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController phoneController;
  late final TextEditingController passwordController;

  late String responseLoginRolePendidikan;
  late String responseLoginRoleKoperasi;
  late String responseLoginNoUser;
  late String responseLoginToken;
  late String responseLoginRefreshToken;

  late String responseDetailsStatus;

  late String dataDetailsUser;
  late String dataDetailsAccount;

  late String responseDetailsUserNik;
  late String responseDetailsUserNamaLengkap;
  late String responseDetailsUserJenisKelamin;
  late String responseDetailsUserTempatLahir;
  late String responseDetailsUserTanggalLahir;
  late String responseDetailsUserAlamatLengkap;
  late String responseDetailsUserPhotoProfile;
  late String responseDetailsUserPhotoKTP;

  late String responseDetailsAccountNoUser;
  late String responseDetailsAccountEmail;
  late String responseDetailsAccountTelepon;

  late String responseDetailsAppNameString;
  late String responseDetailsAppLogo;
  late String responseDetailsAppLogoBar;

  Future<void> fetchDetailLembaga() async {
    final data = await ApiHelper.postDetailLembaga();
    setState(() {
      dataDetailLembaga = data;
      debugPrint('response data detail lembaga: $dataDetailLembaga');

      responseDetailsAppNameString = dataDetailLembaga['app_name_string'] ?? '';
      responseDetailsAppLogo = dataDetailLembaga['app_logo'] ?? '';
      responseDetailsAppLogoBar = dataDetailLembaga['app_logo_bar'] ?? '';

      updateDetailsApp(
        responseDetailsAppNameString,
        responseDetailsAppLogo,
        responseDetailsAppLogoBar,
      );
    });
  }

  Future<void> createToken() async {
    const url = 'https://dkuapi.dkuindonesia.id/api/Authorization/create_token';
    final headers = {
      'ClientID': apiDataClientID,
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'status': 'OK',
      'data_post': [
        {
          'username': phoneController.text,
          'password': passwordController.text,
        }
      ],
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        responseLoginRolePendidikan =
            responseBody['role_pendidikan'].toString();
        responseLoginRoleKoperasi = responseBody['role_koperasi'].toString();
        responseLoginNoUser = responseBody['no_user'].toString();
        responseLoginToken = responseBody['token'].toString();
        responseLoginRefreshToken = responseBody['refresh_token'].toString();

        if (responseLoginRoleKoperasi != 'A3') {
          await showRoleWarningPopup(context);
          return;
        }

        updateLoginVariables(
          responseLoginRolePendidikan,
          responseLoginRoleKoperasi,
          responseLoginNoUser,
          responseLoginToken,
          responseLoginRefreshToken,
        );

        getDetails();

        if (responseLoginToken.length >= 100) {
          // Simpan data login
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('phone', phoneController.text);

          phoneController.clear();
          passwordController.clear();

          SnackbarHelper.showSnackBar(
            AppStrings.loggedIn,
          );
          await NavigationHelper.pushReplacementNamed(
            AppRoutes.home,
          );
        } else {
          SnackbarHelper.showSnackBar(
            responseLoginToken,
          );
          debugPrint('API response: $responseBody.');
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> getDetails() async {
    const url =
        'https://dkuapi.dkuindonesia.id/api/Authorization/get_my_profile';
    final headers = {
      'ClientID': apiDataClientID,
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      final responseBody = json.decode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        responseDetailsUserNik =
            responseBody['data_user_details']['nik'].toString();
        responseDetailsUserNamaLengkap =
            responseBody['data_user_details']['nama_lengkap'].toString();
        responseDetailsUserAlamatLengkap =
            responseBody['data_user_details']['alamat_lengkap'].toString();
        responseDetailsUserJenisKelamin =
            responseBody['data_user_details']['jenis_kelamin'].toString();
        responseDetailsUserTempatLahir =
            responseBody['data_user_details']['tempat_lahir'].toString();
        responseDetailsUserPhotoProfile =
            responseBody['data_user_details']['pas_foto'].toString();
        responseDetailsUserPhotoKTP =
            responseBody['data_user_details']['ktp_foto'].toString();

        responseDetailsAccountNoUser =
            responseBody['data_account_details']['no_user'].toString();
        responseDetailsAccountEmail =
            responseBody['data_account_details']['email'].toString();
        responseDetailsAccountTelepon =
            responseBody['data_account_details']['telepon'].toString();

        debugPrint(
            'response details account email:$responseDetailsAccountEmail');
        updateDetailsUser(
          responseDetailsUserNik,
          responseDetailsUserNamaLengkap,
          responseDetailsUserTempatLahir,
          responseDetailsUserJenisKelamin,
          responseDetailsUserAlamatLengkap,
          responseDetailsUserPhotoProfile,
          responseDetailsUserPhotoKTP,
        );

        updateDetailsAccount(
          responseDetailsAccountNoUser,
          responseDetailsAccountEmail,
          responseDetailsAccountTelepon,
        );
        debugPrint("nama user $apiDataUserNamaLengkap");
        if (responseBody.toString().length <= 100) {
          responseDetailsStatus = responseBody['status'].toString();
          debugPrint('Request failed with status: $responseDetailsStatus');
        } else {
          debugPrint('Request success, data details is updated');
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> fetchData() async {
    await fetchDetailLembaga();
    setState(() {});
  }

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
    final phone = phoneController.text;
    final password = passwordController.text;

    if (phone.isEmpty && password.isEmpty) return;

    if (AppRegex.phoneRegex.hasMatch(phone) &&
        AppRegex.passwordRegex.hasMatch(password)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  Future<void> loadLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    phoneController.text = prefs.getString('phone') ?? '';
    // Kata sandi sebaiknya tidak diisi ulang untuk alasan keamanan
    passwordController.text = '';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('phone'); // Jika Anda ingin menghapus nomor telepon
    // await prefs.clear(); // Jika Anda ingin menghapus semua data
    // Pastikan `phone` tidak dihapus jika ingin tetap mengisi input dengan nomor telepon setelah logout
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  bool checkAccessRestriction() {
    final currentDate = DateTime.now();
    final restrictedDate = DateTime(currentDate.year, 7, 30); // 20 Juni
    return currentDate.isBefore(restrictedDate);
  }

  Future<void> showRoleWarningPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pemberitahuan'),
          content: const Text(
              'Anda harus pindah aplikasi karena role koperasi Anda tidak valid untuk aplikasi ini.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacementNamed(context, AppRoutes.login); // Redirect to login
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchData();
    initializeControllers();
    loadLoginData();
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

    // Check access restriction
    if (!checkAccessRestriction()) {
      return Scaffold(
        body: Center(
          child: Text(
            'Karena melebihi tanggal Trial hubungi admin DKU',
            style: AppTheme.bodyLarge.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      AppStrings.signInToYourNAccount,
                      style: AppTheme.titleLarge,
                    ),
                    Image.network(
                      apiDataAppLogoBar,
                      width: screenWidth * 0.25,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text('icon');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.network(
              apiDataAppLogo,
              height: screenHeight * 0.25,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Text('icon');
              },
            ),
            Text(
              apiDataAppNameString,
              textAlign: TextAlign.center,
              style: AppTheme.bodyMedium.copyWith(color: Colors.black),
            ),
            Text(
              "MOBILE",
              textAlign: TextAlign.center,
              style: AppTheme.bodySmall.copyWith(color: Colors.black),
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
                            : AppConstants.phoneRegex.hasMatch(value)
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
                          onPressed: isValid ? createToken : null,
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
                          AppStrings.forgotPassword,
                          style:
                              AppTheme.bodySmall.copyWith(color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () =>
                              NavigationHelper.pushReplacementNamed(
                            AppRoutes.password_forgot,
                            arguments: {'originPage': 'home'},
                          ),
                          child: const Text(AppStrings.requestNewPassword),
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
                          onPressed: () =>
                              NavigationHelper.pushReplacementNamed(
                            AppRoutes.register,
                            arguments: {'originPage': 'home'},
                          ),
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
                      globalAppVersion,
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
