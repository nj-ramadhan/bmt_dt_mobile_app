import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  Map<int, Map<String, String>> dataMap = {};
  String? simpananSukarelaNumber;
  late int totalAmount;

  Future<void> fetchData() async {
    final data = await ApiHelper.getListRekening(loginToken: apiLoginToken);
    setState(() {
      dataMap = data;
      simpananSukarelaNumber = getTotalAmount(dataMap);
      for (var entry in dataMap.entries) {
        totalAmount = totalAmount +
            int.parse(entry.value['amount'].toString().replaceAll("Rp. ", ""));
      }
    });
  }

  String? getTotalAmount(Map<int, Map<String, String>> data) {
    print(data);
    for (var entry in data.entries) {
      print(entry.value['name']);
      print(entry.value['amount']);
      if (entry.value['name'].toString() == 'SIMPANAN SUKARELA') {
        print("data nya uang " + entry.value['amount'].toString());
        updateDetailsRek(
            entry.value['number'].toString(),
            entry.value['amount'].toString(),
            apiDataDestinationSirelaId,
            apiDataDestinationSirelaName,
            apiDataSendaAmount,
            apiDataSendaComment,
            apiDataKodeTrx,
            apiDataMetodeTransfer);
        return entry.value['number'];
      }
    }
    return null; // Return null if SIMPANAN SUKARELA is not found
  }

  String indonesianCurrencyFormat(String data) {
    int dataInt = int.parse(data.replaceAll("Rp. ", ""));
    var dataFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(dataInt);
    return dataFormatted.toString();
  }

  @override
  void initState() {
    totalAmount = 0;
    fetchData();
    super.initState();
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
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.depositTitle,
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
              child: CarouselSlider(
                options: CarouselOptions(height: screenHeight * 0.22),
                items: dataMap.keys.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background3.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            height: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataMap[i]?['name'] ?? '',
                                        style: AppTheme.bodySmall,
                                      ),
                                      Text(
                                        dataMap[i]?['number'] ?? '',
                                        style: AppTheme.bodyMedium,
                                      ),
                                      Text(
                                        indonesianCurrencyFormat(
                                            dataMap[i]?['amount'] ?? ''),
                                        style: AppTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Column(
              children: [
                const Text(
                  'Total Saldo',
                  style: AppTheme.bodySmall,
                ),
                Text(
                  indonesianCurrencyFormat(totalAmount.toString()),
                  style: AppTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
