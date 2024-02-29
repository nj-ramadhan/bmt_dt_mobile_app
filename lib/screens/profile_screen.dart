import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                        AppStrings.profileAccount,
                        style: AppTheme.titleLarge,
                      ),
                      SizedBox(height: 6),
                      Text(
                        AppStrings.profileAccountSubtitle,
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
          SizedBox(height: 20),
          const Image(
            image: AssetImage('assets/images/user.png'),
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
                FilledButton(
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.deposit,
                  ),
                  child: const Text(AppStrings.depositTitle),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  child: const Text(AppStrings.login),
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
