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
  final Color backgroundColor = Color(
      0xFFD5F5E3); // Adjust this color to match the exact color from the image.
  final TextEditingController _accountNumberController =
      TextEditingController();

  String accountHolder = "";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
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
              ),Container(
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
                    TextStyle(color: Colors.black), // Orange label color
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.black), // Orange underline
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black), // Orange underline on focus
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                String accountHolder = await ApiHelper.getAccountHolderSirela(
                        idSirela: _accountNumberController.text,
                        loginToken: apiLoginToken);
                if ( accountHolder!= "error") {
                  updateDetailsRek(
                    apiDataOwnSirelaId,
                    apiDataOwnSirelaAmount,
                    _accountNumberController.text,
                    accountHolder,
                    apiDataSendaAmount,
                    apiDataSendaComment,
                    apiDataKodeTrx,
                    apiDataMetodeTransfer
                  );
                  NavigationHelper.pushReplacementNamed(
                    AppRoutes.input_amount,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("ID Sirela Tidak Ditemukan"),
                  ));
                }

                // Handle continue action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Change the button color to green
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
    ])));
  }
}
