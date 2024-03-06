import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background1.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const GradientBackground(
              colors: [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.homeTitle,
                          style: AppTheme.titleLarge,
                        ),
                        SizedBox(height: 2),
                        Text(
                          AppStrings.homeSubtitle,
                          style: AppTheme.bodySmall,
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage('assets/icon/icon_text.png'),
                      height: 70,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(180, 10, 0, 10),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'User Name',
                          style: AppTheme.bodySmall,
                        ),
                        Text('email@domain.com', style: AppTheme.bodySmall)
                      ],
                    ),
                    SizedBox(width: 20),
                    Image(
                      image: AssetImage('assets/images/user.png'),
                      height: 60,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(height: 195.0),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.homeAccount + ' No. $i',
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
                                  SizedBox(height: 30),
                                  const Text(
                                    AppStrings.homeAccountSubtitle,
                                    style: AppTheme.bodyTiny,
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                              QrImageView(
                                data: '1234567890',
                                version: QrVersions.auto,
                                size: 100.0,
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () =>
                                        NavigationHelper.pushReplacementNamed(
                                            AppRoutes.checking),
                                    child:
                                        const Text(AppStrings.checkingTitle)),
                                TextButton(
                                    onPressed: () =>
                                        NavigationHelper.pushReplacementNamed(
                                            AppRoutes.deposit),
                                    child: const Text(AppStrings.depositTitle)),
                              ],
                            ),
                          ),
                        ],
                      )),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Transaksi',
                    style: AppTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.shopping,
                            ),
                            child: const Icon(
                              Icons.trolley,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.shoppingTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.payment,
                            ),
                            child: const Icon(
                              Icons.attach_money,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.paymentTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.funding,
                            ),
                            child: const Icon(
                              Icons.send,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.fundingTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.register,
                            ),
                            child: const Icon(
                              Icons.man_3,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.register,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.transfer,
                            ),
                            child: const Icon(
                              Icons.forward,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.transferTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.payment,
                            ),
                            child: const Icon(
                              Icons.atm,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.depositTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.home,
                            ),
                            child: const Icon(
                              Icons.star,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.favouriteTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            color: AppColors.primaryColor,
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            shape: const CircleBorder(),
                            onPressed: () =>
                                NavigationHelper.pushReplacementNamed(
                              AppRoutes.checking,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.checkingTitle,
                              style: AppTheme.bodyTiny),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Informasi',
                    style: AppTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(height: 195.0),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Info. $i',
                                    style: AppTheme.bodySmall,
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

  () newMethod(() onTap) => onTap;
}
