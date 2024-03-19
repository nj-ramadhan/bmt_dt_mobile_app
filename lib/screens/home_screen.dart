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
                          icon: const Icon(Icons.logout),
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:
                                      const Text(AppStrings.logoutConfirmation),
                                  content: const Text(
                                      AppStrings.logoutConfirmationText),
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

                          // async {},
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.homeTitle,
                              style: AppTheme.titleLarge,
                            ),
                            SizedBox(height: 2),
                            Text(
                              AppStrings.homeSubtitle,
                              style: AppTheme.bodyTiny,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage('assets/icon/icon_text.png'),
                      height: 70,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 0, 20, 0),
              child: InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
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
                        const SizedBox(width: 20),
                        const Image(
                          image: AssetImage('assets/images/user.png'),
                          height: 40,
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
              options: CarouselOptions(height: 195.0),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background4.jpg'),
                                fit: BoxFit.cover),
                          ),
                          height: 180,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        const SizedBox(height: 20),
                                        const Text(
                                          AppStrings.homeAccountSubtitle,
                                          style: AppTheme.bodyTiny,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  QrImageView(
                                    data: '1234567890',
                                    size: 70,
                                  ),
                                ],
                              ),
                              ColoredBox(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                              Icons.add_shopping_cart,
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
                              Icons.credit_card,
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
                              Icons.real_estate_agent,
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
                              AppRoutes.login,
                            ),
                            child: const Icon(
                              Icons.person,
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
                              Icons.swap_horiz,
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
                              AppRoutes.saving_mandatory,
                            ),
                            child: const Icon(
                              Icons.account_balance,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.savingsMandatory,
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
                              AppRoutes.saving_principal,
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.savingsPrincipal,
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
                              AppRoutes.saving_voluntary,
                            ),
                            child: const Icon(
                              Icons.savings,
                              size: 40,
                            ),
                          ),
                          const Text(AppStrings.savingsVoluntary,
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
                    options: CarouselOptions(height: 195),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
}
