import 'package:flutter/material.dart';
import '../utils/helpers/api_helper.dart';
import '../global_variables.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
        title: Text('Transfer ke Sesama'),
        backgroundColor:
            Colors.green, // Change the color to match the second image
      ),
      body: Container(
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
                        LoginToken: apiLoginToken);
                if ( accountHolder== "error") {
                  updateDetailsRek(
                    apiDataOwnSirelaId,
                    apiDataOwnSirelaAmount,
                    _accountNumberController.text,
                    accountHolder,
                  );
                  NavigationHelper.pushReplacementNamed(
                    AppRoutes.home,
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
    );
  }
}
