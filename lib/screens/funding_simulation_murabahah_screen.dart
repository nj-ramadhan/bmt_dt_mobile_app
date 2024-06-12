import 'package:flutter/material.dart';

import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class FundingSimulationMurabahahPage extends StatefulWidget {
  const FundingSimulationMurabahahPage({super.key});

  @override
  State<FundingSimulationMurabahahPage> createState() =>
      _FundingSimulationMurabahahPageState();
}

class _FundingSimulationMurabahahPageState
    extends State<FundingSimulationMurabahahPage> {
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController priceController;
  late final TextEditingController marginController;
  late final TextEditingController periodController;
  late final TextEditingController priceSellingController;

  Future<void> simulateFunding() async {
    const url = 'https://dkuapi.dkuindonesia.id/api/Authorization/create_token';
    const headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Content-Type': 'application/json',
    };
    // final body = json.encode({
    //   'status': 'OK',
    //   'data_post': [
    //     {
    //       'username': phoneController.text,
    //       'password': passwordController.text,
    //     }
    //   ],
    // });

    // try {
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: headers,
    //     body: body,
    //   );

    //   if (response.statusCode == 200) {
    //     final responseBody = json.decode(response.body);
    //     responseLoginRolePendidikan =
    //         responseBody['role_pendidikan'].toString();
    //     responseLoginRoleKoperasi = responseBody['role_koperasi'].toString();
    //     responseLoginNoUser = responseBody['no_user'].toString();
    //     responseLoginToken = responseBody['token'].toString();
    //     responseLoginRefreshToken = responseBody['refresh_token'].toString();

    //     updateLoginVariables(
    //       responseLoginRolePendidikan,
    //       responseLoginRoleKoperasi,
    //       responseLoginNoUser,
    //       responseLoginToken,
    //       responseLoginRefreshToken,
    //     );

    //     getDetails();

    //     if (responseLoginToken.length >= 100) {
    //       phoneController.clear();
    //       passwordController.clear();

    //       SnackbarHelper.showSnackBar(
    //         // ignore: void_checks
    //         AppStrings.loggedIn,
    //       );
    //       await NavigationHelper.pushReplacementNamed(
    //         AppRoutes.home,
    //       );
    //     } else {
    //       SnackbarHelper.showSnackBar(
    //         // ignore: void_checks
    //         responseLoginToken,
    //       );
    //       debugPrint('API response: $responseBody.');
    //     }
    //   } else {
    //     debugPrint('Request failed with status: ${response.statusCode}.');
    //   }
    // } catch (e) {
    //   debugPrint('Error: $e');
    // }
  }

  void initializeControllers() {
    priceController = TextEditingController()..addListener(controllerListener);
    marginController = TextEditingController()..addListener(controllerListener);
    periodController = TextEditingController()..addListener(controllerListener);
    priceSellingController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    priceController.dispose();
    marginController.dispose();
    periodController.dispose();
    priceSellingController.dispose();
  }

  void controllerListener() {
    final price = priceController.text;
    final margin = marginController.text;
    final period = periodController.text;
    final priceSelling = priceSellingController.text;

    if (price.isEmpty &&
        margin.isEmpty &&
        period.isEmpty &&
        priceSelling.isEmpty) {
      fieldValidNotifier.value = false;
    } else {
      fieldValidNotifier.value = true;
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushReplacementNamed(
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.fundingMurabahah,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    controller: priceController,
                    labelText: AppStrings.fundingPrice,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // onChanged: (_) => _formKey.currentState?.validate(),
                    // validator: (value) {
                    //   return value!.isEmpty
                    //       ? AppStrings.pleaseEnterPhone
                    //       : AppConstants.phoneRegex.hasMatch(value)
                    //           ? null
                    //           : AppStrings.invalidPhone;
                    // },
                  ),
                  AppTextFormField(
                    controller: marginController,
                    labelText: AppStrings.fundingMargin,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // onChanged: (_) => _formKey.currentState?.validate(),
                    // validator: (value) {
                    //   return value!.isEmpty
                    //       ? AppStrings.pleaseEnterPhone
                    //       : AppConstants.phoneRegex.hasMatch(value)
                    //           ? null
                    //           : AppStrings.invalidPhone;
                    // },
                  ),
                  AppTextFormField(
                    controller: periodController,
                    labelText: AppStrings.fundingPeriod,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // onChanged: (_) => _formKey.currentState?.validate(),
                    // validator: (value) {
                    //   return value!.isEmpty
                    //       ? AppStrings.pleaseEnterPhone
                    //       : AppConstants.phoneRegex.hasMatch(value)
                    //           ? null
                    //           : AppStrings.invalidPhone;
                    // },
                  ),
                  AppTextFormField(
                    controller: priceSellingController,
                    labelText: AppStrings.fundingPriceSelling,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    // onChanged: (_) => _formKey.currentState?.validate(),
                    // validator: (value) {
                    //   return value!.isEmpty
                    //       ? AppStrings.pleaseEnterPhone
                    //       : AppConstants.phoneRegex.hasMatch(value)
                    //           ? null
                    //           : AppStrings.invalidPhone;
                    // },
                  ),
                  ValueListenableBuilder(
                    valueListenable: fieldValidNotifier,
                    builder: (_, isValid, __) {
                      return FilledButton(
                        onPressed: isValid ? simulateFunding : null,
                        child: const Text(AppStrings.fundingSimulation),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
