// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ShoppingConfirmPage extends StatefulWidget {
  const ShoppingConfirmPage({super.key});
  @override
  State<ShoppingConfirmPage> createState() => _ShoppingConfirmPageState();
}

class _ShoppingConfirmPageState extends State<ShoppingConfirmPage> {
  late String pinNumber;
  Map<String, String> dataBuyProduct = {};
  late TextEditingController pinNumberController;

  Future<void> fetchDataBuyProduct() async {
    debugPrint("debug: masuk ke buy product");
    debugPrint(apiDataProductCode);
    debugPrint(apiDataProductClientNumber);
    final data = await ApiHelper.postBuyProduct(
        loginToken: apiLoginToken,
        pin: apiDataProductPin,
        codeProduct: apiDataProductCode,
        clientNumber: apiDataProductClientNumber,
        methodPayment: 'id_su-$apiDataOwnSirelaId');
    setState(() {
      dataBuyProduct = data;
      SnackbarHelper.showSnackBar(responseBuyProduct(dataBuyProduct));
    });
  }

  String? responseBuyProduct(Map<String, String> data) {
    return data['message'] ?? null;
  } // Return null if SIMPANAN SUKARELA is not found

  String indonesianCurrencyFormat(String data) {
    int dataInt = int.parse(data);
    var dataFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(dataInt);
    return dataFormatted.toString();
  }

  @override
  void initState() {
    initializeControllers();

    super.initState();
  }

  void initializeControllers() {
    pinNumberController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    pinNumberController.dispose();
  }

  void controllerListener() {
    final updatePinNumber = pinNumberController.text;

    if (updatePinNumber.isEmpty) return;
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void updatePinNumber(String value) => setState(() {
        pinNumber = value;
        apiDataProductPin = pinNumber;

        debugPrint('response: $apiDataProductPin');

        // Replace with your logic
      });

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
                        AppRoutes.shopping_provider_list,
                      ),
                    ),
                    const Text(
                      AppStrings.shoppingTitle,
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
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Anda akan membeli paket',
                    style: AppTheme.bodySmall,
                  ),
                  Text(
                    apiDataProductName,
                    style: AppTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Seharga',
                    style: AppTheme.bodySmall,
                  ),
                  Text(
                    indonesianCurrencyFormat(apiDataProductPrice),
                    style: AppTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Nomor Tujuan',
                    style: AppTheme.bodySmall,
                  ),
                  Text(
                    apiDataProductClientNumber,
                    style: AppTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: AppStrings.pin,
                        fillColor: AppColors.lightGreen),
                    controller: pinNumberController,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => updatePinNumber(pinNumberController.text),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  FilledButton(
                    onPressed: () {
                      fetchDataBuyProduct();
                    },
                    child: Text('Continue'),
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
