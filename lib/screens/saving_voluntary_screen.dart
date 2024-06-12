import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class SavingVoluntaryPage extends StatefulWidget {
  const SavingVoluntaryPage({super.key});

  @override
  State<SavingVoluntaryPage> createState() => _SavingVoluntaryPageState();
}

class _SavingVoluntaryPageState extends State<SavingVoluntaryPage> {
  int amountSaving = 0;

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
        amountSaving = amount;
        amountController.text = amountSaving.toString();
        // Replace with your logic
      });

  void updateAmountText(String amount) => setState(() {
        if (amount == '') {
          amountSaving = 0;
        } else {
          amountSaving = int.parse(amount);
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
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.savingsVoluntaryTitle,
                      style: AppTheme.bodyLarge,
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
                              const Material(
                                color: AppColors.darkGreen,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Rp.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                      hintText: AppStrings.amountSaving,
                                      fillColor: AppColors.lightGreen),
                                  controller: amountController,
                                  textInputAction: TextInputAction.done,
                                  textAlign: TextAlign.end,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_) =>
                                      updateAmountText(amountController.text),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      AppStrings.selectAmountSaving,
                      style: AppTheme.bodySmall,
                    ),
                  ],
                )),
            CarouselSlider(
              options: CarouselOptions(height: 100),
              items: [50000, 75000, 100000].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            updateAmount(i);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rp. $i',
                                style: AppTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
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
                              AppStrings.differentAccountTransfer,
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
                        NavigationHelper.pushNamed(
                          AppRoutes.home,
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
                              AppStrings.differentBankTransfer,
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
                        NavigationHelper.pushNamed(
                          AppRoutes.home,
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
