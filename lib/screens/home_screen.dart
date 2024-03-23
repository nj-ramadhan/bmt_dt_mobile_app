import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openProfileScreen(BuildContext context) {
    NavigationHelper.pushReplacementNamed(
      AppRoutes.profile,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.jpg'),
          fit: BoxFit.contain,
        ),
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
                      icon: const Icon(Icons.logout),
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(AppStrings.logoutConfirmation),
                              content:
                                  const Text(AppStrings.logoutConfirmationText),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () =>
                                      NavigationHelper.pushReplacementNamed(
                                    AppRoutes.home,
                                  ),
                                  child: const Text(AppStrings.noConfirm),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      NavigationHelper.pushReplacementNamed(
                                    AppRoutes.login,
                                  ),
                                  child: const Text(AppStrings.yesConfirm),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Text(
                      AppStrings.homeTitle,
                      style: AppTheme.titleLarge,
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
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.1,
                0,
                screenWidth * 0.02,
                0,
              ),
              child: InkWell(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Nomor Akun: $apiLoginNoUser',
                              style: AppTheme.bodySmall,
                            ),
                            Text(apiDataUserNamaLengkap,
                                style: AppTheme.bodySmall),
                            Text(apiDataAccountEmail, style: AppTheme.bodySmall)
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        Image(
                          image: const AssetImage('assets/images/user.png'),
                          width: screenWidth * 0.15,
                          // height: 40,
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () => NavigationHelper.pushReplacementNamed(
                  AppRoutes.profile,
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(height: screenHeight * 0.22),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.02),
                        ),
                        elevation: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.4,
                              image:
                                  AssetImage('assets/images/background4.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          height: screenHeight * 0.1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * 0.04,
                                        screenHeight * 0.02,
                                        0,
                                        0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${AppStrings.homeAccount} No. $i',
                                          style: AppTheme.bodySmall,
                                        ),
                                        const Text(
                                          '00.9.123.4.5',
                                          style: AppTheme.bodyMedium,
                                        ),
                                        const Text(
                                          'Rp. ******',
                                          style: AppTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  QrImageView(
                                    data: '1234567890',
                                    size: screenHeight * 0.08,
                                  ),
                                ],
                              ),
                              const Text(
                                AppStrings.homeAccountSubtitle,
                                style: AppTheme.bodyTiny,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              ColoredBox(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenHeight * 0.02,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => NavigationHelper
                                            .pushReplacementNamed(
                                                AppRoutes.checking),
                                        child: const Text(
                                            AppStrings.checkingTitle),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => NavigationHelper
                                            .pushReplacementNamed(
                                          AppRoutes.deposit,
                                        ),
                                        child: const Text(
                                          AppStrings.depositTitle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
              padding: EdgeInsets.all(
                screenWidth * 0.005,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaksi',
                    style: AppTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.shopping,
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.shoppingTitle,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.payment,
                            ),
                            child: const Icon(
                              Icons.credit_card,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.paymentTitle,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.funding,
                            ),
                            child: const Icon(
                              Icons.real_estate_agent,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.fundingTitle,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () async {
                              final result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          AppStrings.featureInformation),
                                      content: const Text(
                                          AppStrings.featureInformationText),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () => NavigationHelper
                                              .pushReplacementNamed(
                                            AppRoutes.home,
                                          ),
                                          child:
                                              const Text(AppStrings.okConfirm),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Icon(
                              Icons.person,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.register,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.transfer,
                            ),
                            child: const Icon(
                              Icons.swap_horiz,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.transferTitle,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.saving_mandatory,
                            ),
                            child: const Icon(
                              Icons.account_balance,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.savingsMandatory,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.saving_principal,
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.savingsPrincipal,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(
                              screenWidth * 0.05,
                            ),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.saving_voluntary,
                            ),
                            child: const Icon(
                              Icons.savings,
                              // size: 40,
                            ),
                          ),
                          const Text(
                            AppStrings.savingsVoluntary,
                            style: AppTheme.bodyTiny,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  const Text(
                    'Informasi',
                    style: AppTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenHeight * 0.2,
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01,
                            ),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Info. $i',
                                    style: AppTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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
