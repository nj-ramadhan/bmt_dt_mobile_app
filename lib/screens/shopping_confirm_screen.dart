// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
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
  Map<int, Map<String, String>> dataBuyProduct = {};
  late TextEditingController pinNumberController;

  Future<void> postDataBuyProduct() async {
    final data = await ApiHelper.postBuyProduct(
        LoginToken: apiLoginToken,
        pin: apiDataProductPin,
        codeProduct: apiDataProductCode,
        clientNumber: apiDataProductClientNumber,
        methodPayment: 'id_su');
    setState(() {
      dataBuyProduct = data;
      debugPrint('response post data buy: $dataBuyProduct');

      postBuyProduct(data);
    });
  }

  String? postBuyProduct(Map<int, Map<String, String>> data) {
    for (var entry in data.entries) {
      if (entry.value['pin'] == apiDataProductPin) {
        return entry.value['pin'];
      }
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
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
        debugPrint('response: $pinNumber from $value');
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
        //     fit: BoxFit.cover,),
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
                        AppRoutes.home,
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
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apiDataProductName),
                  Text(apiDataProductClientNumber),
                  Text(apiDataProductPrice),
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
                      postDataBuyProduct();
                      SnackBar(
                        content: Text(dataBuyProduct[1]?['message'] ?? ''),
                      );
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
