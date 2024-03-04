import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';
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
              padding: EdgeInsets.all(20),
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
            CarouselSlider(
              options: CarouselOptions(height: 200.0),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        child: Row(
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
                                  style: AppTheme.bodySmall,
                                ),
                                const Text(
                                  'Rp. ******',
                                  style: AppTheme.bodySmall,
                                ),
                                SizedBox(height: 50),
                                const Text(
                                  AppStrings.homeAccountSubtitle,
                                  style: AppTheme.bodyTiny,
                                ),
                              ],
                            ),
                            QrImageView(
                              data: '1234567890',
                              version: QrVersions.auto,
                              size: 100.0,
                            ),
                          ],
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.menu,
                    ),
                    child: const Text(AppStrings.menuTitle),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.profile,
                    ),
                    child: const Text(AppStrings.profileAccount),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.login,
                    ),
                    child: const Text(AppStrings.logout),
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
