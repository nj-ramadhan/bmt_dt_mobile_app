import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bmt_dt_mobile_app/utils/helpers/snackbar_helper.dart';
import 'package:bmt_dt_mobile_app/values/app_regex.dart';

import '../components/app_text_form_field.dart';
import '../resources/resources.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_constants.dart';
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
            colors: [AppColors.darkestGreen, AppColors.darkGreen],
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
          const Image(
              image: AssetImage('assets/images/user.png'),
              height: 180,
              alignment: Alignment.topCenter),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return AppColors.primaryColor;
                      return null; // Defer to the widget's default.
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return AppColors.darkGreen;
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.deposit,
                  ),
                  child: const Text(AppStrings.deposit),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return AppColors.primaryColor;
                      return null; // Defer to the widget's default.
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return AppColors.darkGreen;
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  child: const Text(AppStrings.login),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
