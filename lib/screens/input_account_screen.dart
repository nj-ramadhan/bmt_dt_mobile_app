import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class InputAccountPage extends StatefulWidget {
  const InputAccountPage({super.key});

  @override
  State<InputAccountPage> createState() => _InputAccountPageState();
}

class _InputAccountPageState extends State<InputAccountPage> {
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BaseLayout(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          // image: DecorationImage(
          //     image: AssetImage('assets/images/background2.jpg'),
          //     fit: BoxFit.cover),
        ),
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.fromLTRB(0, screenHeight * 0.01, 0, 0),
            children: [
              Column(
                children: [
                  GradientBackground(
                    colors: const [Colors.transparent, Colors.transparent],
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () =>
                                NavigationHelper.pushNamed(
                              AppRoutes.transfer,
                            ),
                          ),
                          const Text(
                            AppStrings.transferToOtherClient,
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.03, 0, screenWidth * 0.03, 0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenHeight * 0.04),
                        Text(
                          'Masukkan Nomor Rekening Tujuan',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextField(
                          controller: _accountNumberController,
                          decoration: InputDecoration(
                            labelText: 'Nomor Rekening',
                            labelStyle: TextStyle(
                                color: Colors.black), // Black label color
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black), // Black underline
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Colors.black), // Black underline on focus
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        ElevatedButton(
                          onPressed: () async {
                            debugPrint('data' + _accountNumberController.text);
                            print('data' + apiLoginToken);
      
                            String accountHolder =
                                await ApiHelper.getAccountHolderSirela(
                                    idSirela: _accountNumberController.text,
                                    loginToken: apiLoginToken);
                            if (accountHolder != "error") {
                              updateDetailsRek(
                                apiDataOwnSirelaId,
                                apiDataOwnSirelaAmount,
                                _accountNumberController.text,
                                accountHolder,
                                apiDataSendaAmount,
                                apiDataSendaComment,
                                apiDataKodeTrx,
                                apiDataMetodeTransfer,
                                apiDataAdminAmount,
                              );
                              NavigationHelper.pushNamed(
                                AppRoutes.input_amount,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("ID Sirela Tidak Ditemukan"),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green, // Reference color from second image
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64.0),
                            child: Text(
                              'Lanjut',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
