import 'package:bmt_dt_mobile_app/values/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../global_variables.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        // image: DecorationImage(
        //     image: AssetImage('assets/images/background1.jpg'),
        //     fit: BoxFit.cover),
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushReplacementNamed(
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.profileAccount,
                      style: AppTheme.titleLarge,
                    ),
                    Image.network(
                      apiDataAppLogoBar,
                      width: screenWidth * 0.25,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Material(
              color: AppColors.primaryColor,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Image(
                  image: AssetImage('assets/images/user.png'),
                  height: 120,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    color: AppColors.lightGreen,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.primaryColor,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              AppStrings.profileAccount,
                            ),
                            Icon(
                              Icons.chevron_right,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
                          AppRoutes.profile_detail,
                        );
                      },
                    ),
                  ),
                  Card(
                    color: AppColors.lightGreen,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppColors.primaryColor,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.shield,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              AppStrings.password,
                            ),
                            Icon(
                              Icons.chevron_right,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NavigationHelper.pushReplacementNamed(
                          AppRoutes.change_password,
                        );
                      },
                    ),
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
