import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
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
                          AppStrings.transferTitle,
                          style: AppTheme.titleLarge,
                        ),
                        SizedBox(height: 6),
                        Text(
                          AppStrings.transferSubtitle,
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
