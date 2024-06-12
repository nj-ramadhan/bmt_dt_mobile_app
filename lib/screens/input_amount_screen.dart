import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/database_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class InputAmountPage extends StatefulWidget {
  const InputAmountPage({super.key});

  @override
  State<InputAmountPage> createState() => _InputAmountPageState();
}

class _InputAmountPageState extends State<InputAmountPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;
  bool _saveToFavorite = false; // Boolean to track Switch state

  String _table = 'same_bank';
  // Function to handle the API call

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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.03, 0, screenWidth * 0.03, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            Colors.green, // Reference color from second image
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rekening Sumber',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            children: [
                              Icon(Icons.credit_card, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                apiDataOwnSirelaId,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.money, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Saldo: Rp $apiDataOwnSirelaAmount',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            Colors.green, // Reference color from second image
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rekening Tujuan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(children: [
                            Icon(Icons.credit_card, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              apiDataDestinationSirelaId,
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                          Row(
                            children: [
                              Icon(Icons.account_balance, color: Colors.white),
                              SizedBox(width: 16),
                              Column(children: [
                                Container(
                                  width: screenWidth * 0.7,
                                  child: Text(
                                    apiDataDestinationSirelaName,
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 2,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nominal',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Berita',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      controller: _commentController,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Text('Simpan ke Rekening Favorit'),
                        Spacer(),
                        Switch(
                          value: _saveToFavorite,
                          onChanged: (value) {
                            setState(() {
                              _saveToFavorite = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    ElevatedButton(
                      onPressed: () async {
                        if (_saveToFavorite) {
                          String accountNumber = apiDataDestinationSirelaName;
                          String accountHolder = apiDataDestinationSirelaId;
                          String accountAlias = apiDataDestinationSirelaName;

                          if (accountNumber.isNotEmpty &&
                              accountHolder.isNotEmpty &&
                              accountAlias.isNotEmpty) {
                            int result = await db.addAccount(_table,
                                accountNumber, accountHolder, accountAlias);
                            if (result != -1) {
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Account already exists')),
                              );
                            }
                          }
                        }
                        updateDetailsRek(
                            apiDataOwnSirelaId,
                            apiDataOwnSirelaAmount,
                            apiDataDestinationSirelaId,
                            apiDataDestinationSirelaName,
                            _amountController.text,
                            _commentController.text,
                            apiDataKodeTrx,
                            apiDataMetodeTransfer);
                        NavigationHelper.pushNamed(
                          AppRoutes.transaction_detail,
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
                          'Lanjut',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
