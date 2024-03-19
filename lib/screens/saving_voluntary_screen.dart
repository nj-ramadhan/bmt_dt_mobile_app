import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class SavingVoluntaryPage extends StatefulWidget {
  const SavingVoluntaryPage({super.key});

  @override
  State<SavingVoluntaryPage> createState() => _SavingVoluntaryPageState();
}

class _SavingVoluntaryPageState extends State<SavingVoluntaryPage> {
  int amountTransfer = 0;

  void updateAmount(int amount) => setState(() {
        amountTransfer = amount;
        // Replace with your logic
      });

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
                              AppStrings.savingsVoluntaryTitle,
                              style: AppTheme.bodyMedium,
                            ),
                            SizedBox(height: 2),
                            Text(
                              AppStrings.savingsVoluntarySubtitle,
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Card(
                      child: SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.currency_exchange),
                            Text(AppStrings.amountTransfer),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'Rp. $amountTransfer',
                      style: AppTheme.titleLarge,
                    ),
                    const Text(
                      AppStrings.selectAmountTransfer,
                      style: AppTheme.bodySmall,
                    ),
                  ],
                )),
            CarouselSlider(
              options: CarouselOptions(height: 100),
              items: [50000, 75000, 100000].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            updateAmount(i);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rp. $i',
                                style: AppTheme.titleLarge,
                              )
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
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  FilledButton.icon(
                    icon: Icon(Icons.abc),
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.home,
                    ),
                    label: const Text(AppStrings.differentAccountTransfer),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButton.icon(
                    icon: Icon(Icons.abc),
                    onPressed: () => NavigationHelper.pushReplacementNamed(
                      AppRoutes.home,
                    ),
                    label: const Text(AppStrings.differentBankTransfer),
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
