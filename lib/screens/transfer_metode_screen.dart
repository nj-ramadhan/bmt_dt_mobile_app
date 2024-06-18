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

class TransferMetodePage extends StatefulWidget {
  const TransferMetodePage({super.key});

  @override
  State<TransferMetodePage> createState() => _TransferMetodePageState();
}

class _TransferMetodePageState extends State<TransferMetodePage> {
  int amountTransfer = 0;

  final ValueNotifier<bool> amountNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController amountController;
  
  Map<String, dynamic> transferFees = {};

  void initializeControllers() {
    amountController = TextEditingController()..addListener(controllerListener);
  }

  void disposeControllers() {
    amountController.dispose();
  }

  void controllerListener() {
    final amount = amountController.text;

    if (amount.isEmpty) return;
  }

  @override
  void initState() {
    initializeControllers();
    fetchTransferFees();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  Future<void> fetchTransferFees() async {
    final url = Uri.parse('https://dkuapi.dkuindonesia.id/api/Dku_bank/biaya_admin'); // Ganti dengan URL API Anda
    final headers = {
      'ClientID':
          apiDataClientID,
      'Content-Type': 'application/json',
    };
    
    try {
      final response = await http.get(url,headers: headers,);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("data admin adalah $data");
        setState(() {
          transferFees = {
            'BIFAST': data['data'].firstWhere((item) => item['kode_transaksi'] == '28bifast'),
            'TO': data['data'].firstWhere((item) => item['kode_transaksi'] == '29to'),
            'RTGS': data['data'].firstWhere((item) => item['kode_transaksi'] == '30rtgs')
          };
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  int parseFee(String? fee) {
    // Convert fee to integer, or return 0 if fee is null or cannot be parsed
    return int.tryParse(fee ?? '0') ?? 0;
  }

  void updateAmount(int amount) => setState(() {
    amountTransfer = amount;
    amountController.text = amountTransfer.toString();
  });

  void updateAmountText(String amount) => setState(() {
    if (amount == '') {
      amountTransfer = 0;
    } else {
      amountTransfer = int.parse(amount);
    }
  });

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
                          AppRoutes.transfer,
                        ),
                      ),
                      const Text(
                        AppStrings.transferMethodTitle,
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
                    buildTransferCard(
                      context,
                      'TO',
                      parseFee(transferFees['TO']?['biaya_admin']),
                    ),
                    buildTransferCard(
                      context,
                      'BIFAST',
                      parseFee(transferFees['BIFAST']?['biaya_admin']),
                    ),
                    buildTransferCard(
                      context,
                      'RTGS',
                      parseFee(transferFees['RTGS']?['biaya_admin']),
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

  Widget buildTransferCard(BuildContext context, String transferType, int fee) {
    return Card(
      color: AppColors.primaryColor,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: AppColors.darkGreen,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/images/banking.png',
                    height: 30,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Text(
                "$transferType - Rp. $fee",
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
        onTap: () {
          // Implement your logic for the respective transfer type
          updateDetailsRek(
            apiDataOwnSirelaId,
            apiDataOwnSirelaAmount,
            apiDataDestinationSirelaId,
            apiDataDestinationSirelaName,
            apiDataSendaAmount,
            apiDataSendaComment,
            apiDataKodeTrx,
            transferType,
            fee.toString()
          );
          NavigationHelper.pushNamed(
            AppRoutes.add_client_dif_bank,
          );
        },
      ),
    );
  }
}
