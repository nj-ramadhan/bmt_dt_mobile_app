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
import '../components/base_layout.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  Map<int, Map<String, String>> dataMap = {};
  String? simpananSukarelaNumber;
  int totalAmount = 0;

  Future<void> fetchData() async {
    final data = await ApiHelper.getListRekening(loginToken: apiLoginToken);
    setState(() {
      dataMap = data;
      simpananSukarelaNumber = getTotalAmount(dataMap);
      totalAmount = 0; // Reset total amount
      for (var entry in dataMap.entries) {
        totalAmount += int.parse(entry.value['amount']!
            .replaceAll("Rp. ", "")
            .replaceAll(",", "")); // Update to handle comma
      }
    });
  }

  String? getTotalAmount(Map<int, Map<String, String>> data) {
    for (var entry in data.entries) {
      if (entry.value['name'].toString() == 'SIMPANAN SUKARELA') {
        updateDetailsRek(
            entry.value['number'].toString(),
            entry.value['amount'].toString(),
            apiDataDestinationSirelaId,
            apiDataDestinationSirelaName,
            apiDataSendaAmount,
            apiDataSendaComment,
            apiDataKodeTrx,
            apiDataMetodeTransfer,
            apiDataAdminAmount);
        return entry.value['number'];
      }
    }
    return null;
  }

  String indonesianCurrencyFormat(String data) {
    int dataInt = int.parse(data.replaceAll("Rp. ", "").replaceAll(",", ""));
    var dataFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(dataInt);
    return dataFormatted.toString();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
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
                child: Column(
                  children: dataMap.keys.map((i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
