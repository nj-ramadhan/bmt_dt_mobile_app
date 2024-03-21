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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                    const Column(
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
                      image: const AssetImage('assets/icon/icon_bg.png'),
                      width: screenWidth * 0.25,
                      fit: BoxFit.cover,
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
      ),
    );
  }
}
