import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class TransferSuccessPage extends StatefulWidget {
  const TransferSuccessPage({super.key});

  @override
  State<TransferSuccessPage> createState() => _TransferSuccessPageState();
}

class _TransferSuccessPageState extends State<TransferSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Receipt'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Transfer Receipt', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Divider(color: Colors.black),
                    Text('Kode Transaksi:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$apiDataKodeTrx'),
                    SizedBox(height: 8),
                    Text('Rekening Sumber:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Id pengirim $apiDataOwnSirelaId"),
                    Text("Nama Penerima $apiDataUserNamaLengkap"),
                    SizedBox(height: 8),
                    Text('Rekening Tujuan:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Id Penerima $apiDataDestinationSirelaId"),
                    Text("Nama Penerima $apiDataDestinationSirelaName"),
                    SizedBox(height: 8),
                    Text('Nominal:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Rp $apiDataSendaAmount'),
                    SizedBox(height: 8),
                    Text('Berita:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(apiDataSendaComment),
                    SizedBox(height: 8),
                    Text('Tanggal Transfer:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Sekarang'),
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.pushReplacementNamed(
                  AppRoutes.home,
                );
              },
              child: Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Make button full-width
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
