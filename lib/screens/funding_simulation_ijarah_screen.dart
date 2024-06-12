import 'package:bmt_dt_mobile_app/components/dropdown_V2.dart';
import 'package:flutter/material.dart';

import '../components/app_drop_down_form_field.dart';
import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class FundingSimulationIjarahPage extends StatefulWidget {
  const FundingSimulationIjarahPage({super.key});

  @override
  State<FundingSimulationIjarahPage> createState() =>
      _FundingSimulationIjarahPageState();
}

class _FundingSimulationIjarahPageState
    extends State<FundingSimulationIjarahPage> {
  late Future<List<DropdownItemsStringIdModel>> _listOption;
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController priceController;
  late final TextEditingController marginController;
  late final TextEditingController periodController;
  late final TextEditingController priceSellingController;

  String? valueDownOption;
  String? valueDownCodeOption;

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
    if (apiDataMetodeTransfer == "TO") {
      // _table = 'different_bank_TO';
      _listOption = ApiHelper.getListBankTO(loginToken: apiLoginToken);
    } else if (apiDataMetodeTransfer == "BIFAST") {
      _listOption = ApiHelper.getListBankBIFAST(loginToken: apiLoginToken);
      // _table = 'different_bank_BIFAST';
    } else {
      _listOption = ApiHelper.getListBankRTGS(loginToken: apiLoginToken);
      // _table = 'different_bank_RTGS';
    }
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
                      onPressed: () => NavigationHelper.pushNamed(
                        AppRoutes.funding_simulation,
                      ),
                    ),
                    const Text(
                      AppStrings.fundingIjarah,
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
                  AppDropdownFormBank(
                    future: _listOption,
                    labelText: 'Opsi',
                    value: valueDownOption,
                    hint: "Pilih Opsi",
                    dropdownColor: AppColors.lightGreen,
                    onChanged: (value) {
                      setState(() {
                        valueDownOption = value;
                      });
                    },
                    onItemSelected: (title) {
                      valueDownCodeOption = title;
                      print(
                          'Selected bank title: $valueDownOption $valueDownCodeOption');
                      // Lakukan sesuatu dengan title bank yang dipilih
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
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
                                Text('Nilai Angsuran per Bulan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal)),
                                Text('$apiDataKodeTrx'),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Lama Angsuran',
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
    );
  }
}
