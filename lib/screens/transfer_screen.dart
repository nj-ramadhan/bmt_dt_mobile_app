import 'dart:html';

import 'package:bmt_dt_mobile_app/components/app_text_form_field.dart';
import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            const Image(
              image: AssetImage('assets/images/deposit.png'),
              height: 180,
              alignment: Alignment.topCenter,
            ),
            // Form(
            //   key: _formKey,
            // child:
            // ),

            const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.currency_exchange),
                    Text(AppStrings.amountTransfer),
                  ],
                ),
              ),
            ),
            Text(
              '$amountTransfer',
              style: AppTheme.bodyLarge,
            ),
            const Text(
              AppStrings.selectAmountTransfer,
              style: AppTheme.bodySmall,
            ),

            CarouselSlider(
              options: CarouselOptions(height: 70),
              items: [50, 75, 100].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Card(
                        child: Text('Rp.$i.000'),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Column(
              children: [
                TextButton.icon(
                  icon: Icon(
                    Icons.send,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  label: Text(AppStrings.differentAccountTransfer),
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.balance,
                    size: 40,
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  label: Text(AppStrings.differentBankTransfer),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
