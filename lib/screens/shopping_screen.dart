import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
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
                          AppStrings.shoppingTitle,
                          style: AppTheme.titleLarge,
                        ),
                        SizedBox(height: 6),
                        Text(
                          AppStrings.shoppingSubtitle,
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.profile,
                    ),
                    child: const Text(AppStrings.profileAccount),
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
      ),
    );
  }
}
