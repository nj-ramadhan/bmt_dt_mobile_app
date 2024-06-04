// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:async';

import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ShoppingDetailListPage extends StatefulWidget {
  const ShoppingDetailListPage({super.key});
  @override
  State<ShoppingDetailListPage> createState() => _ShoppingDetailListPageState();
}

class _ShoppingDetailListPageState extends State<ShoppingDetailListPage> {
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
    print("inilah data");
    print(data);
    for (var entry in data.entries) {
      print(entry.value['keyword_kode_depan_nomor']);
      if (entry.value['keyword_kode_depan_nomor'] == frontCodeNumber) {
        return entry.value['keyword_kode_depan_nomor'];
      }
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
  }

  @override
  void initState() {
    frontCodeNumber = '0857';
    // fetchData();
    // print(dataMap);
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
        frontCodeNumber = value;
        frontCodeController.text = frontCodeNumber.toString();
        // Replace with your logic
      });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
                  Card(
                    color: AppColors.primaryColor,
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: AppStrings.frontCode,
                                    fillColor: AppColors.lightGreen),
                                controller: frontCodeController,
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                onChanged: (_) =>
                                    updateFrontCode(frontCodeController.text),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            FilledButton(
                              onPressed: () {
                                frontCodeNumber = frontCodeController.text;
                              },
                              child: Text('Cek'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
