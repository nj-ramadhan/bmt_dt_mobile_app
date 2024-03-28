import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../global_variables.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        // image: DecorationImage(
        //     image: AssetImage('assets/images/background1.jpg'),
        //     fit: BoxFit.cover),
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
                      AppStrings.checkingTitle,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: AppColors.lightGreen,
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: AppStrings.amountTransfer,
                                          fillColor: AppColors.primaryColor),
                                      controller: amountController,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => updateAmountText(
                                          amountController.text),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Material(
                                    color: AppColors.darkGreen,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(Icons.calendar_month,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: AppStrings.amountTransfer,
                                          fillColor: AppColors.primaryColor),
                                      controller: amountController,
                                      textInputAction: TextInputAction.done,
                                      textAlign: TextAlign.end,
                                      keyboardType: TextInputType.number,
                                      onChanged: (_) => updateAmountText(
                                          amountController.text),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Material(
                                    color: AppColors.darkGreen,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(Icons.calendar_month,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: FilledButton(
                                onPressed: () {},
                                child: const Text(AppStrings.checkingProcees),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
