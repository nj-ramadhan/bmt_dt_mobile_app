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
  late String frontCodeNumber;
  Map<int, Map<String, String>> dataMap = {};
  final ValueNotifier<bool> frontCodeNotifier = ValueNotifier(true);
  late TextEditingController frontCodeController;

  Future<void> fetchData() async {
    final data = await ApiHelper.getListProvider(
        LoginToken: apiLoginToken, frontCode: frontCodeNumber);
    setState(() {
      dataMap = data;
    });
  }

  String? getListProvider(Map<int, Map<String, String>> data) {
    debugPrint('response: $data');
    for (var entry in data.entries) {
      print(entry.value['keyword_kode_depan_nomor']);
      if (entry.value['keyword_kode_depan_nomor'] == frontCodeNumber) {
        return entry.value['keyword_kode_depan_nomor'];
      }
      debugPrint('response: $entry');
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
  }

  @override
  void initState() {
    frontCodeNumber = '0857';
    initializeControllers();

    super.initState();
  }

  void initializeControllers() {
    frontCodeController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    frontCodeController.dispose();
  }

  void controllerListener() {
    final updatedFrontCode = frontCodeController.text;

    if (updatedFrontCode.isEmpty) return;
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void updateFrontCode(String value) => setState(() {
        frontCodeNumber = value.substring(0, 4);
        debugPrint('response: $frontCodeNumber from $value');
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
                  TextField(
                    decoration: const InputDecoration(
                        hintText: AppStrings.frontCode,
                        fillColor: AppColors.lightGreen),
                    controller: frontCodeController,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.end,
                    keyboardType: TextInputType.number,
                    // onChanged: (_) => updateFrontCode(frontCodeController.text),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  FilledButton(
                    onPressed: () {
                      updateFrontCode(frontCodeController.text);
                      fetchData();
                    },
                    child: Text('Cek'),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Column(
                    children: [
                      // dataMap.keys.map((i) {
                      for (var i = 1; i <= dataMap.keys.length; i++)
                        // debugPrint('response: $dataMap');

                        Card(
                          color: AppColors.primaryColor,
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    color: AppColors.darkGreen,
                                    shape: const CircleBorder(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.01),
                                      child: Image.network(
                                        dataMap[i]?['logo_kartu'] ?? '',
                                        width: screenWidth * 0.15,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                      // Image(
                                      // image: ssetImage(
                                      //     'assets/images/handphone.png'),
                                      // height: 20,
                                      // alignment: Alignment.topCenter,
                                      // ),
                                    ),
                                  ),
                                  Text(
                                    dataMap[i]?['produk_provider'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      height: 3,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              // NavigationHelper.pushReplacementNamed(
                              //   AppRoutes.shopping_detail_list,
                              // );
                            },
                          ),
                        ),
                    ],
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
