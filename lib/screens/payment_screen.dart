import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../global_variables.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
                      AppStrings.paymentTitle,
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
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.fundingSimulation,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingSimulationSubtitle,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
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
                        NavigationHelper.pushNamed(
                          AppRoutes.home,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.fundingSubmission,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingSubmissionSubtitle,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
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
                        NavigationHelper.pushNamed(
                          AppRoutes.home,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.fundingTransaction,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingTransactionSubtitle,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
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
                        NavigationHelper.pushNamed(
                          AppRoutes.home,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Material(
                              color: AppColors.darkGreen,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.fundingHistory,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingHistorySubtitle,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
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
