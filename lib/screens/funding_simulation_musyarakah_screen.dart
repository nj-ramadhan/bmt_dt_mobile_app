import 'package:flutter/material.dart';

import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class FundingSimulationMusyarakahPage extends StatefulWidget {
  const FundingSimulationMusyarakahPage({super.key});

  @override
  State<FundingSimulationMusyarakahPage> createState() =>
      _FundingSimulationMusyarakahPageState();
}

class _FundingSimulationMusyarakahPageState
    extends State<FundingSimulationMusyarakahPage> {
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController capitalController;
  late final TextEditingController projectValueController;
  late final TextEditingController profitValueController;
  late final TextEditingController profitSharingController;
  late final TextEditingController periodController;

  late String capital;
  late String projectValue;
  late String profitValue;
  late String profitSharing;
  late String period;

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
    //       await NavigationHelper.pushNamed(
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
    capitalController = TextEditingController()
      ..addListener(controllerListener);
    projectValueController = TextEditingController()
      ..addListener(controllerListener);
    profitValueController = TextEditingController()
      ..addListener(controllerListener);
    periodController = TextEditingController()..addListener(controllerListener);
    profitSharingController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    capitalController.dispose();
    projectValueController.dispose();
    profitValueController.dispose();
    periodController.dispose();
    profitSharingController.dispose();
  }

  void controllerListener() {
    final capital = capitalController.text;
    final projectValue = projectValueController.text;
    final profitValue = projectValueController.text;
    final period = periodController.text;
    final profitSharing = profitSharingController.text;

    if (capital.isEmpty &&
        projectValue.isEmpty &&
        profitValue.isEmpty &&
        period.isEmpty &&
        profitSharing.isEmpty) {
      fieldValidNotifier.value = false;
    } else {
      fieldValidNotifier.value = true;
    }
  }

  @override
  void initState() {
    capital = '0';
    projectValue = '0';
    profitValue = '0';
    profitSharing = '0';
    period = '0';
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
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => NavigationHelper.pushNamed(
                          AppRoutes.funding_simulation,
                        ),
                      ),
                      const Text(
                        AppStrings.fundingMusyarakah,
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
                      controller: capitalController,
                      labelText: AppStrings.fundingTotalCapital,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => capital = capitalController.text,
                      // validator: (value) {
                      //   return value!.isEmpty
                      //       ? AppStrings.pleaseEnterPhone
                      //       : AppConstants.phoneRegex.hasMatch(value)
                      //           ? null
                      //           : AppStrings.invalidPhone;
                      // },
                    ),
                    AppTextFormField(
                      controller: projectValueController,
                      labelText: AppStrings.fundingProjectValue,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) =>
                          projectValue = projectValueController.text,
                      // validator: (value) {
                      //   return value!.isEmpty
                      //       ? AppStrings.pleaseEnterPhone
                      //       : AppConstants.phoneRegex.hasMatch(value)
                      //           ? null
                      //           : AppStrings.invalidPhone;
                      // },
                    ),
                    AppTextFormField(
                      controller: profitValueController,
                      labelText: AppStrings.fundingProfitValue,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => profitValue = profitValueController.text,
                      // validator: (value) {
                      //   return value!.isEmpty
                      //       ? AppStrings.pleaseEnterPhone
                      //       : AppConstants.phoneRegex.hasMatch(value)
                      //           ? null
                      //           : AppStrings.invalidPhone;
                      // },
                    ),
                    AppTextFormField(
                      controller: profitSharingController,
                      labelText: AppStrings.fundingProfitSharing,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) =>
                          profitSharing = profitSharingController.text,
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
                      onChanged: (_) => period = periodController.text,
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
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Nilai Bagi Hasil',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal)),
                                  Text(profitSharing),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Pengembalian',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal)),
                                  Text('$apiDataKodeTrx'),
                                ]),
                            Divider(color: AppColors.darkestGreen),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Biaya Administrasi:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal)),
                                Text('$apiDataKodeTrx'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Notaris:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal)),
                                Text('$apiDataKodeTrx'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('APHT/Asuransi:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal)),
                                Text('$apiDataKodeTrx'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Materai:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.normal)),
                                Text('$apiDataKodeTrx'),
                              ],
                            ),
                            Divider(color: AppColors.darkestGreen),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Jumlah:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('$apiDataKodeTrx'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
