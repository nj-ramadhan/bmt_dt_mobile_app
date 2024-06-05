import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/helpers/database_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer ke Sesama'),
        backgroundColor: Colors.green, // Reference color from second image
      ),
      body: Container(
        color: Color(0xFFD5F5E3), // Set the background color of the screen
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green, // Reference color from second image
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        apiDataOwnSirelaId,
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        'Saldo: Rp $apiDataOwnSirelaAmount',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green, // Reference color from second image
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.account_balance, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '$apiDataDestinationSirelaName',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '$apiDataDestinationSirelaId',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
            SizedBox(height: 16),
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
            Spacer(),
            ElevatedButton(
              onPressed: () async{
                if (_saveToFavorite) {
                  String accountNumber = apiDataDestinationSirelaName;
              String accountHolder = apiDataDestinationSirelaId;
              String accountAlias = apiDataDestinationSirelaName;

              if (accountNumber.isNotEmpty && accountHolder.isNotEmpty && accountAlias.isNotEmpty) {
                int result = await db.addAccount(_table, accountNumber, accountHolder, accountAlias);
                if (result != -1) {
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account already exists')),
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
                    _commentController.text
                  );
                NavigationHelper.pushReplacementNamed(
                        AppRoutes.transaction_detail,);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Reference color from second image
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
