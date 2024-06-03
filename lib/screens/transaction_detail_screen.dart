import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class TransactionDetailPage extends StatefulWidget {
  const TransactionDetailPage({super.key});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final Color backgroundColor = Color(0xFFD5F5E3); // Adjust this color to match the exact color from the image.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Konfirmasi Transfer', style: TextStyle(color: Colors.black)),
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
              accountNumber: '0352000426',
              balance: 'Rp 11.792',
            ),
            SizedBox(height: 16),
            TransferDetailCard(
              icon: Icons.account_balance,
              title: 'Rekening Tujuan',
              accountNumber: 'BCA Syariah - 0011777711',
              name: 'BAZNAS',
            ),
            SizedBox(height: 16),
            TransferInfoCard(),
            Spacer(),
            ConfirmationButton(),
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

  TransferDetailCard({required this.icon, required this.title, required this.accountNumber, this.balance = '', this.name = ''});

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
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    if (name.isNotEmpty) Text(name, style: TextStyle(color: Colors.white)),
                    Text(accountNumber, style: TextStyle(color: Colors.white)),
                    if (balance.isNotEmpty) Text('Saldo: $balance', style: TextStyle(color: Colors.white)),
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
            Text('Detail Transfer', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            TransferInfoRow(label: 'Transaksi', value: 'Transfer Ke BCA Syariah'),
            TransferInfoRow(label: 'Nominal', value: 'Rp 10.000'),
            TransferInfoRow(label: 'Berita', value: 'lalala'),
            TransferInfoRow(label: 'Tanggal Transfer', value: 'Sekarang'),
            Divider(color: Colors.white),
            TransferInfoRow(label: 'Biaya Admin', value: 'Rp 0'),
            TransferInfoRow(label: 'Total', value: 'Rp 10.000'),
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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Use 'backgroundColor' instead of 'primary'
        ),
        onPressed: () {
          // Implement confirmation action
        },
        child: Text('Konfirmasi', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
