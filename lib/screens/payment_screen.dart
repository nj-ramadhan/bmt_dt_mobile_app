import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background2.jpg'),
            fit: BoxFit.cover),
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
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () =>
                              NavigationHelper.pushReplacementNamed(
                                  AppRoutes.home),
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.paymentTitle,
                              style: AppTheme.titleLarge,
                            ),
                            SizedBox(height: 2),
                            Text(
                              AppStrings.paymentSubtitle,
                              style: AppTheme.bodyTiny,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image(
                      image: const AssetImage('assets/icon/icon_text.png'),
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
                                  image:
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
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
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
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
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
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
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
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
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
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
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
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
                                      AssetImage('assets/images/handphone.png'),
                                  height: 30,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
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
                            Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
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
