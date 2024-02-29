import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientBackground(
            colors: [AppColors.darkestGreen, AppColors.primaryColor],
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.menuTitle,
                        style: AppTheme.titleLarge,
                      ),
                      SizedBox(height: 6),
                      Text(
                        AppStrings.menuSubtitle,
                        style: AppTheme.bodySmall,
                      ),
                    ],
                  ),
                  Image(
                    image: AssetImage('assets/icon/icon_bg.png'),
                    height: 70,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ],
          ),
          const Image(
            image: AssetImage('assets/images/deposit.png'),
            height: 180,
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: const Icon(
                    Icons.check,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.checking,
                  ),
                  label: const Text(AppStrings.checkingTitle),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: const Icon(
                    Icons.money,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.deposit,
                  ),
                  label: const Text(AppStrings.depositTitle),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: const Icon(
                    Icons.send,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.payment,
                  ),
                  label: const Text(AppStrings.paymentTitle),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  icon: const Icon(
                    Icons.forward,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.transfer,
                  ),
                  label: const Text(AppStrings.transferTitle),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.home,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.home,
                  ),
                  label: const Text(AppStrings.homeTitle),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  label: const Text(AppStrings.logout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
