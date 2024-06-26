import 'package:flutter/material.dart';

import '../components/base_layout.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class TransactionDetailDifBankPage extends StatefulWidget {
  const TransactionDetailDifBankPage({super.key});

  @override
  State<TransactionDetailDifBankPage> createState() =>
      _TransactionDetailDifBankPageState();
}

class _TransactionDetailDifBankPageState
    extends State<TransactionDetailDifBankPage> {
  final Color backgroundColor = Color(
      0xFFD5F5E3); // Adjust this color to match the exact color from the image.
  bool _isLoading = false; // Add this line
  String Total = 'Null';
  void initState() {
    super.initState();
    int total = int.parse(apiDataAdminAmount) + int.parse(apiDataSendaAmount);
    Total = total.toString();
  }

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
                GradientBackground(
                  colors: const [Colors.transparent, Colors.transparent],
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => NavigationHelper.pushNamed(
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
                Container(
                  color: backgroundColor,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TransferDetailCard(
                        icon: Icons.credit_card,
                        title: 'Rekening Sumber',
                        accountNumber: '$apiDataOwnSirelaId',
                        balance: 'Rp $apiDataOwnSirelaAmount',
                      ),
                      SizedBox(height: 16),
                      TransferDetailCard(
                        icon: Icons.account_balance,
                        title: 'Rekening Tujuan',
                        accountNumber: '$apiDataDestinationSirelaId',
                        name: '$apiDataBank - $apiDataDestinationSirelaName',
                      ),
                      SizedBox(height: 16),
                      TransferInfoCard(),
                      ConfirmationButton(
                        onConfirm: _isLoading
                            ? null
                            : () {
                                setState(() {
                                  _isLoading =
                                      true; // Set loading to true when button is pressed
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MPinPopup(
                                      onPinSubmitted: (String pin) async {
                                        setState(() {
                                          _isLoading =
                                              false; // Set loading to false after API call
                                        });
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                        Map<String, dynamic> statusTransfer =
                                            await ApiHelper.getTransferDifBank(
                                          apiLoginToken,
                                          apiDataOwnSirelaId,
                                          apiDataSendaAmount,
                                          apiDataSendaComment,
                                          pin,
                                          apiDataDestinationSirelaId,
                                          apiDataKodeBank,
                                          apiDataMetodeTransfer,
                                          apiDataDestinationSirelaName,
                                        );
                                        Navigator.of(context)
                                            .pop(); // Close loading indicator

                                        if (statusTransfer['status_trx']
                                                .toString() ==
                                            'BERHASIL DIKIRIM') {
                                          //menuju halaman
                                          updateDetailsRek(
                                              apiDataOwnSirelaId,
                                              apiDataOwnSirelaAmount,
                                              apiDataDestinationSirelaId,
                                              apiDataDestinationSirelaName,
                                              apiDataSendaAmount,
                                              apiDataSendaComment,
                                              statusTransfer['kd_trx']
                                                  .toString(),
                                              apiDataMetodeTransfer,
                                              apiDataAdminAmount);
                                          NavigationHelper.pushNamed(
                                            AppRoutes
                                                .transaction_sucess_dif_bank,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text('Incorrect PIN')),
                                          );
                                        }
                                        setState(() {
                                          _isLoading =
                                              true; // Set loading to false after API call
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}

class TransferDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String accountNumber;
  final String balance;
  final String name;

  TransferDetailCard(
      {required this.icon,
      required this.title,
      required this.accountNumber,
      this.balance = '',
      this.name = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    if (name.isNotEmpty)
                      Text(name, style: TextStyle(color: Colors.white)),
                    Text(accountNumber, style: TextStyle(color: Colors.white)),
                    if (balance.isNotEmpty)
                      Text('Saldo: $balance',
                          style: TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransferInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Transfer',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            TransferInfoRow(label: 'Transaksi', value: 'BMT DT'),
            TransferInfoRow(label: 'Nominal', value: 'Rp $apiDataSendaAmount'),
            TransferInfoRow(label: 'Berita', value: '$apiDataSendaComment'),
            TransferInfoRow(label: 'Tanggal Transfer', value: 'Sekarang'),
            Divider(color: Colors.white),
            TransferInfoRow(
                label: 'Biaya Admin', value: 'Rp $apiDataAdminAmount'),
            TransferInfoRow(
                label: 'Total',
                value:
                    'Rp ${(int.parse(apiDataSendaAmount) + int.parse(apiDataAdminAmount)).toString()}'),
          ],
        ),
      ),
    );
  }
}

class TransferInfoRow extends StatelessWidget {
  final String label;
  final String value;

  TransferInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white)),
          Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class ConfirmationButton extends StatelessWidget {
  final VoidCallback? onConfirm;

  ConfirmationButton({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        onPressed: onConfirm,
        child: Text('Konfirmasi', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MPinPopup extends StatefulWidget {
  final Function(String) onPinSubmitted;

  MPinPopup({required this.onPinSubmitted});

  @override
  _MPinPopupState createState() => _MPinPopupState();
}

class _MPinPopupState extends State<MPinPopup> {
  bool _obscureText = true;
  TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('mPIN',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                TextFormField(
                  controller: _pinController,
                  obscureText: _obscureText,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                ElevatedButton(
                  onPressed: () {
                    widget.onPinSubmitted(_pinController.text);
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
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
