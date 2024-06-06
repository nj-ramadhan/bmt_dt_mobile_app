import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../utils/helpers/api_helper.dart';

class TransactionDetailDifBankPage extends StatefulWidget {
  const TransactionDetailDifBankPage({super.key});

  @override
  State<TransactionDetailDifBankPage> createState() => _TransactionDetailDifBankPageState();
}

class _TransactionDetailDifBankPageState extends State<TransactionDetailDifBankPage> {
  final Color backgroundColor = Color(
      0xFFD5F5E3); // Adjust this color to match the exact color from the image.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title:
            Text('Konfirmasi Transfer', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Implement back navigation
          },
        ),
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TransferDetailCard(
              icon: Icons.credit_card,
              title: 'Rekening Sumber',
              accountNumber: '$apiDataOwnSirelaId',
              balance: 'Rp $apiDataSendaAmount',
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
            Spacer(),
            ConfirmationButton(
              onConfirm: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MPinPopup(
                      onPinSubmitted: (String pin) async {
                        Map<String, dynamic> statusTransfer =
                            await ApiHelper.getTransferSirela(
                                apiLoginToken,
                                apiDataOwnSirelaId,
                                apiDataSendaAmount,
                                apiDataSendaComment,
                                pin,
                                apiDataDestinationSirelaId);
                        if (statusTransfer['status_trx'].toString() ==
                            'BERHASIL DIKIRIM') {
                          //menuju halaman
                          updateDetailsRek(
                              apiDataOwnSirelaId,
                              apiDataOwnSirelaAmount,
                              apiDataDestinationSirelaId,
                              apiDataDestinationSirelaName,
                              apiDataSendaAmount,
                              apiDataSendaComment,
                              statusTransfer['kd_trx'].toString(),
                              apiDataMetodeTransfer);
                          NavigationHelper.pushReplacementNamed(
                            AppRoutes.transaction_sucess,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Incorrect PIN')),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
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
            TransferInfoRow(label: 'Biaya Admin', value: 'Rp 0'),
            TransferInfoRow(label: 'Total', value: 'Rp $apiDataSendaAmount'),
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
  final VoidCallback onConfirm;

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
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('mPIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
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
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              widget.onPinSubmitted(_pinController.text);
            },
            child: Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
