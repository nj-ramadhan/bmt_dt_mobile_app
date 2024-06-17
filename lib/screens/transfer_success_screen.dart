import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class TransferSuccessPage extends StatefulWidget {
  const TransferSuccessPage({super.key});

  @override
  State<TransferSuccessPage> createState() => _TransferSuccessPageState();
}

class _TransferSuccessPageState extends State<TransferSuccessPage> {
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
                            AppRoutes.home,
                          ),
                        ),
                        const Text(
                          AppStrings.transferReceiptTitle,
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
                              Text('Transfer Receipt',
                                  style: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold)),
                              Divider(color: Colors.black),
                              Text('Kode Transaksi:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('$apiDataKodeTrx'),
                              SizedBox(height: 8),
                              Text('Rekening Sumber:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Id pengirim $apiDataOwnSirelaId"),
                              Text("Nama Pengirim $apiDataUserNamaLengkap"),
                              SizedBox(height: 8),
                              Text('Rekening Tujuan:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text("Id Penerima $apiDataDestinationSirelaId"),
                              Text("Nama Penerima $apiDataDestinationSirelaName"),
                              SizedBox(height: 8),
                              Text('Nominal:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Rp $apiDataSendaAmount'),
                              SizedBox(height: 8),
                              Text('Berita:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(apiDataSendaComment),
                              SizedBox(height: 8),
                              Text('Tanggal Transfer:',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Sekarang'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          NavigationHelper.pushNamed(
                            AppRoutes.home,
                          );
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
                            'Back to Home',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }
}
