import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class Products {
  Products(this.id_list, this.nama_pembelian, this.jenis_transaksi, this.icon,
      this.keyword_kode_depan_nomor);

  factory Products.fromJson(dynamic json) {
    return Products(
      json['id_list'] as String,
      json['nama_pembelian'] as String,
      json['jenis_transaksi'] as String,
      json['icon'] as String,
      json['keyword_kode_depan_nomor'] as String,
    );
  }
  String id_list;
  String nama_pembelian;
  String jenis_transaksi;
  String icon;
  String keyword_kode_depan_nomor;

  @override
  String toString() {
    return '{ $id_list, $nama_pembelian, $jenis_transaksi, $icon, $keyword_kode_depan_nomor }';
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  late List<Products> listShopping = [];

  Future<void> getProducts() async {
    const url =
        'https://dkuapi.dkuindonesia.id/api/table_wizard/crud_table_serverside_globaltable?act=list-dkui_mitra.t_list_pembelian';
    final headers = {
      'ClientID':
          apiDataClientID,
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      final responseData = responseBody['data'] as List;
      setState(() {
        listShopping = responseData.map(Products.fromJson).toList();
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<String>(
      future: Future.delayed(const Duration(milliseconds: 800), () => 'wait'),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return BaseLayout(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: AppColors.lightGreen,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (final product in listShopping)
                            Card(
                              color: AppColors.primaryColor,
                              child: InkWell(
                                onTap: () {
                                  apiDataProductTransactionType =
                                      product.jenis_transaksi;
                                  apiDataProductKeyword =
                                      product.keyword_kode_depan_nomor;
                                  debugPrint(
                                      'response shopping, transaction type: $apiDataProductTransactionType, keyword $apiDataProductKeyword');
                                  NavigationHelper.pushNamed(
                                    AppRoutes.shopping_provider_list,
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.darkGreen,
                                        radius: screenWidth * 0.075,
                                        child: ClipOval(
                                          child: Image.network(
                                            product.icon,
                                            width: screenWidth * 0.13,
                                            height: screenWidth * 0.13,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return const Icon(
                                                Icons.image_not_supported,
                                                size: 24,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(
                                        product.nama_pembelian,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
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
        } else {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              color: AppColors.lightGreen,
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
                            onPressed: () => NavigationHelper.pushNamed(
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
