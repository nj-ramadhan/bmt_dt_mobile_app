// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:async';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ShoppingProviderListPage extends StatefulWidget {
  const ShoppingProviderListPage({super.key});
  @override
  State<ShoppingProviderListPage> createState() =>
      _ShoppingProviderListPageState();
}

class _ShoppingProviderListPageState extends State<ShoppingProviderListPage> {
  late String frontCodeNumber;
  late String providerCodeNumber;
  late String providerLogo;

  Map<int, Map<String, String>> dataProvider = {};
  Map<int, Map<String, String>> dataProduct = {};
  final ValueNotifier<bool> frontCodeNotifier = ValueNotifier(true);
  late TextEditingController frontCodeController;

  NumberFormat formatter = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 0,
  );

  Future<void> fetchDataProvider() async {
    final data = await ApiHelper.getListProvider(
        LoginToken: apiLoginToken, frontCode: frontCodeNumber);
    setState(() {
      dataProvider = data;

      getListProvider(data);
    });
  }

  Future<void> fetchDataProduct() async {
    final data = await ApiHelper.getListProduct(
        LoginToken: apiLoginToken, providerCode: providerCodeNumber);
    setState(() {
      dataProduct = data;

      getListProduct(data);
    });
  }

  String? getListProvider(Map<int, Map<String, String>> data) {
    debugPrint('response: list provider $data');
    for (var entry in data.entries) {
      debugPrint(entry.value['keyword_kode_depan_nomor']);
      if (entry.value['keyword_kode_depan_nomor'] == frontCodeNumber) {
        return entry.value['keyword_kode_depan_nomor'];
      }
      debugPrint('response: $entry');
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
  }

  String? getListProduct(Map<int, Map<String, String>> data) {
    debugPrint('response: list product $data');
    for (var entry in data.entries) {
      debugPrint(entry.value['provider_code']);
      if (entry.value['provider_code'] == providerCodeNumber) {
        return entry.value['provider_code'];
      }
      debugPrint('response: $entry');
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
  }

  String indonesianFormat(String data) {
    int dataInt = int.parse(data);
    var dataFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(dataInt);
    return dataFormatted.toString();
  }

  @override
  void initState() {
    frontCodeNumber = '';
    providerCodeNumber = '';
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

  void updateProviderCode(String value) => setState(() {
        providerCodeNumber = value;
        debugPrint('response: provider no $providerCodeNumber');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Image.network(
                            dataProvider[1]?['logo_kartu'] ?? '',
                            width: screenWidth * 0.15,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return const Text('😢');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
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
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  FilledButton(
                    onPressed: () {
                      fetchDataProvider();
                      providerCodeNumber =
                          dataProvider[1]?['no_kode_provider'] ?? '';
                      providerLogo = dataProvider[1]?['logo_kartu'] ?? '';
                      debugPrint('response: $providerCodeNumber $providerLogo');
                      fetchDataProduct();
                    },
                    child: Text('Cek'),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Column(
                    children: [
                      // dataProvider.keys.map((i) {
                      for (var i = 1; i <= dataProduct.keys.length; i++)
                        // debugPrint('response: $dataProvider');
                        Card(
                          color: AppColors.lightGreen,
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        dataProduct[i]?['nama_produk'] ?? '',
                                        style: AppTheme.bodySmall,
                                      ),
                                      Text(
                                          indonesianFormat(dataProduct[i]
                                                  ?['harga_jual_agen'] ??
                                              ''),
                                          // formatter.format(
                                          //   (dataProduct[i]
                                          //           ?['harga_jual_agen'] ??
                                          //       '')
                                          // ).toString(),
                                          // dataProduct[i]?['harga_jual_agen'] ??
                                          //     '',
                                          style: AppTheme.bodyMedium),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              NavigationHelper.pushReplacementNamed(
                                AppRoutes.shopping_confirm,
                              );
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
