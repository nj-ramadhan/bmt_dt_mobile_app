import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void updateAmount(int amount) => setState(() {
        amountTransfer = amount;
        amountController.text = amountTransfer.toString();
        // Replace with your logic
      });

  void updateAmountText(String amount) => setState(() {
        if (amount == '') {
          amountTransfer = 0;
        } else {
          amountTransfer = int.parse(amount);
        }
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
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image: AssetImage('assets/images/saving.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Text(
                              "Transfer Online",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        updateDetailsRek(
                          apiDataOwnSirelaId,
                          apiDataOwnSirelaAmount,
                          apiDataDestinationSirelaId,
                          apiDataDestinationSirelaName,
                          apiDataSendaAmount,
                          apiDataSendaComment,
                          apiDataKodeTrx,
                          "TO",
                        );
                        NavigationHelper.pushNamed(
                          AppRoutes.add_client_dif_bank,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/banking.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Text(
                              "BIFast",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        updateDetailsRek(
                          apiDataOwnSirelaId,
                          apiDataOwnSirelaAmount,
                          apiDataDestinationSirelaId,
                          apiDataDestinationSirelaName,
                          apiDataSendaAmount,
                          apiDataSendaComment,
                          apiDataKodeTrx,
                          "BIFAST",
                        );
                        NavigationHelper.pushNamed(
                          AppRoutes.add_client_dif_bank,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/banking.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Text(
                              "RTGS",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        updateDetailsRek(
                          apiDataOwnSirelaId,
                          apiDataOwnSirelaAmount,
                          apiDataDestinationSirelaId,
                          apiDataDestinationSirelaName,
                          apiDataSendaAmount,
                          apiDataSendaComment,
                          apiDataKodeTrx,
                          "RTGS",
                        );
                        NavigationHelper.pushNamed(
                          AppRoutes.add_client_dif_bank,
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
  }
}
