import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../components/base_layout.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String? qrCode;

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scan QRIS'),
        ),
        body: Column(
          children: [
            Expanded(
              child: MobileScanner(
                onDetect: (barcode) {
                  final String? code = barcode.barcodes.first.rawValue;
                  setState(() {
                    qrCode = code;
                  });
                  // Uncomment and import `TransferAmountScreen` if needed
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => TransferAmountScreen(qrCode: qrCode),
                  //   ),
                  // );
                },
              ),
            ),
            if (qrCode != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('QR Code: $qrCode'),
              ),
          ],
        ),
      ),
    );
  }
}
