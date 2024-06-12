import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class FundingSimulationPage extends StatefulWidget {
  const FundingSimulationPage({super.key});

  @override
  State<FundingSimulationPage> createState() => _FundingSimulationPageState();
}

class _FundingSimulationPageState extends State<FundingSimulationPage> {
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
                      onPressed: () => NavigationHelper.pushReplacementNamed(
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.fundingTitle,
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingMudharabah,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingMudharabahSubtitle,
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
                          AppRoutes.funding_simulation_mudharabah,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingMurabahah,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingMurabahahSubtitle,
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
                          AppRoutes.funding_simulation_murabahah,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingMusyarakah,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingMusyarakahSubtitle,
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
                          AppRoutes.funding_simulation_musyarakah,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingIjarah,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingIjarahSubtitle,
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
                          AppRoutes.funding_simulation_ijarah,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingAlQard,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingAlQardSubtitle,
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
                          AppRoutes.funding_simulation_alqard,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingHiwalah,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingHiwalahSubtitle,
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
                          AppRoutes.funding_simulation_hiwalah,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.primaryColor,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: const Row(
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
                                      AppStrings.fundingRahn,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      AppStrings.fundingRahnSubtitle,
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
                          AppRoutes.funding_simulation_rahn,
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
