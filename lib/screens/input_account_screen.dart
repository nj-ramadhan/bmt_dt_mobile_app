import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

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

    return Scaffold(
      body: Container(
        color: AppColors.lightGreen,
        child: Column(
          children: [
            GradientBackground(
              colors: const [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushReplacementNamed(
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
            Expanded(
              child: Container(
                color: Color(0xFFD5F5E3), // Set the background color
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Masukkan Nomor Rekening Tujuan',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _accountNumberController,
                      decoration: InputDecoration(
                        labelText: 'Nomor Rekening',
                        labelStyle:
                            TextStyle(color: Colors.black), // Black label color
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black), // Black underline
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black), // Black underline on focus
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        debugPrint('dataa'+_accountNumberController.text);
                        print('dataa'+apiLoginToken);

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
                          );
                          NavigationHelper.pushReplacementNamed(
                            AppRoutes.input_amount,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("ID Sirela Tidak Ditemukan"),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Lanjut',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
