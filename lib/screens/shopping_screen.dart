// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

import 'dart:async';
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
    return '{ $id_list, $nama_pembelian, $id_list, $nama_pembelian, $keyword_kode_depan_nomor }';
  }
}

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});
  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  late List<Products> listShopping;

  Future<String> callAsyncFetch() =>
      Future.delayed(const Duration(milliseconds: 500), () => 'wait');

  Future<void> getProducts() async {
    const url =
        'https://dkuapi.dkuindonesia.id/api/table_wizard/crud_table_serverside_globaltable?act=list-dkui_mitra.t_list_pembelian';
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        // body: body,
      );

      final responseBody = json.decode(response.body);
      final responseData = responseBody['data'] as List;
      // listShopping = responseData.map(Products.fromJson).toList();
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
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
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
                              onPressed: () =>
                                  NavigationHelper.pushReplacementNamed(
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
                                          padding: EdgeInsets.all(
                                              screenWidth * 0.01),
                                          child: Image.network(
                                            product.icon,
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
                                        product.nama_pembelian,
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
                                  apiDataProductTransactionType =
                                      product.jenis_transaksi;
                                  apiDataProductKeyword =
                                      product.keyword_kode_depan_nomor;
                                  debugPrint(
                                      'response shopping, transaction type: $apiDataProductTransactionType, keyword $apiDataProductKeyword');
                                  NavigationHelper.pushReplacementNamed(
                                    AppRoutes.shopping_provider_list,
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  // image: DecorationImage(
                  //     image: AssetImage('assets/images/background2.jpg'),
                  //     fit: BoxFit.cover,),
                ),
                child: Scaffold(
                    body: ListView(padding: EdgeInsets.zero, children: [
                  GradientBackground(
                    colors: const [Colors.transparent, Colors.transparent],
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
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
                          ]))
                ])));
          }
        });
  }
}
