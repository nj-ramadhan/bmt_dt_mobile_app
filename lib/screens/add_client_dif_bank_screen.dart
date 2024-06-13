import 'package:flutter/material.dart';

import '../components/app_drop_down_form_field.dart';
import '../components/dropdown_V2.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/database_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class AddClientDifBankPage extends StatefulWidget {
  const AddClientDifBankPage({super.key});

  @override
  State<AddClientDifBankPage> createState() => _AddClientDifBankPageState();
}

class _AddClientDifBankPageState extends State<AddClientDifBankPage> {
// //   final Color backgroundColor = Color(
// //       0xFFD5F5E3); // Adjust this color to match the exact color from the image.

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       theme: ThemeData(
// //         primaryColor: Color(0xFFD0F0C0), // Specific green color from your image
// //         colorScheme: ColorScheme.fromSwatch().copyWith(
// //           secondary: Colors.greenAccent, // Accent color if needed
// //           primary: Color(0xFFD0F0C0), // Primary color
// //         ),
// //         textTheme: TextTheme(
// //           bodyLarge: TextStyle(color: Colors.black), // Black text color
// //           bodyMedium: TextStyle(color: Colors.black), // Black text color
// //         ),
// //       ),
// //       home: FavoriteAccountsPage(),
// //     );
// //   }
// // }

// // class FavoriteAccountsPage extends StatefulWidget {
//   @override
//   _FavoriteAccountsPageState createState() => _FavoriteAccountsPageState();
// }

// class _FavoriteAccountsPageState extends State<FavoriteAccountsPage> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;
  late String _table;

  List<Map<String, dynamic>> _accounts = [];

  @override
  void initState() {
    if (apiDataMetodeTransfer == "TO") {
      _table = 'different_bank_TO';
    } else if (apiDataMetodeTransfer == "BIFAST") {
      _table = 'different_bank_BIFAST';
    } else {
      _table = 'different_bank_RTGS';
    }
    super.initState();
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    final accounts = await db.fetchAccounts(_table);
    setState(() {
      _accounts = accounts;
    });
  }

  Future<void> _searchAccounts(String query) async {
    final accounts = await db.searchAccounts(_table, query);
    setState(() {
      _accounts = accounts;
    });
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> account) {
    final TextEditingController _accountNumberController =
        TextEditingController(text: account['account_number']);
    final TextEditingController _accountHolderController =
        TextEditingController(text: account['account_holder']);
    final TextEditingController _accountAliasController =
        TextEditingController(text: account['account_alias']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account Number',
              ),
              readOnly: true,
            ),
            TextField(
              controller: _accountHolderController,
              decoration: InputDecoration(labelText: 'Account Holder'),
              readOnly: true,
            ),
            TextField(
              controller: _accountAliasController,
              decoration: InputDecoration(labelText: 'Account Alias'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await db.updateAccount(_table, _accountNumberController.text,
                  _accountHolderController.text, _accountAliasController.text);
              _fetchAccounts();
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String accountNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () async {
              await db.deleteAccount(_table, accountNumber);
              _fetchAccounts();
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final TextEditingController _accountNumberController =
        TextEditingController();
    final TextEditingController _accountHolderController =
        TextEditingController();
    final TextEditingController _accountAliasController =
        TextEditingController();
    late Future<List<DropdownItemsStringIdModel>> _listBank;
    if (apiDataMetodeTransfer == "TO") {
      _listBank = ApiHelper.getListBankTO(loginToken: apiLoginToken);
    } else if (apiDataMetodeTransfer == "BIFAST") {
      _listBank = ApiHelper.getListBankBIFAST(loginToken: apiLoginToken);
    } else {
      _listBank = ApiHelper.getListBankRTGS(loginToken: apiLoginToken);
    }

    String? valueDownBank;
    String? valueDownCodeBank;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDropdownFormBank(
              future: _listBank,
              labelText: 'Bank',
              value: valueDownCodeBank,
              hint: "Pilih Bank",
              dropdownColor: Colors.blue[100],
              onChanged: (value) {
                setState(() {
                  valueDownCodeBank = value;
                });
              },
              onItemSelected: (title) {
                print('Selected bank title: $valueDownBank $title');
                valueDownBank = title;
                // Lakukan sesuatu dengan title bank yang dipilih
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    String accountHolder =
                        await ApiHelper.getAccountHolderDifBank(
                      apiLoginToken,
                      _accountNumberController.text,
                      valueDownCodeBank.toString(),
                      apiDataMetodeTransfer,
                    );

                    print("hasil $accountHolder");
                    if (accountHolder != 'error') {
                      print("masuk kesini");
                      setState(() {
                        _accountHolderController.text = accountHolder;
                      });
                    } else {
                      print("masuk kesini error");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("ID Sirela Tidak Ditemukan"),
                      ));
                    }
                  },
                ),
              ),
              enabled: (valueDownCodeBank != null),
            ),
            TextField(
              controller: _accountHolderController,
              decoration: InputDecoration(labelText: 'Account Holder'),
              readOnly: true,
            ),
            TextField(
              controller: _accountAliasController,
              decoration: InputDecoration(labelText: 'Account Alias'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String accountNumber = _accountNumberController.text;
              String accountHolder = _accountHolderController.text;
              String accountAlias = _accountAliasController.text;

              if (accountNumber.isNotEmpty && accountHolder.isNotEmpty) {
                int result = await db.addAccountDifBank(
                    _table,
                    accountNumber,
                    accountHolder,
                    accountAlias,
                    valueDownBank.toString(),
                    valueDownCodeBank.toString());
                if (result != -1) {
                  _fetchAccounts();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account already exists')),
                  );
                }
              }
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

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
                        AppStrings.transferToOtherBank,
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Cari...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style:
                            TextStyle(color: Colors.black), // Black text color
                        onChanged: _searchAccounts,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () => _showAddDialog(context),
                      child:
                          Text('Tambah', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  // dataProvider.keys.map((i) {
                  for (var i = 1; i <= _accounts.length; i++)
                    // debugPrint('response: $dataProvider');
                    Card(
                      color: AppColors.lightGreen,
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    _accounts[0]['account_holder'],
                                    style: AppTheme.bodySmall,
                                  ),
                                  Container(
                                    width: screenWidth * 0.7,
                                    child: Text(
                                      _accounts[i]['account_number'] ?? '',
                                      style: AppTheme.bodyTiny,
                                      textAlign: TextAlign.center,
                                      maxLines: 3,
                                    ),
                                  ),
                                  Text(_accounts[i]['account_alias'] ?? '',
                                      style: AppTheme.bodyMedium),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () =>
                                        _showEditDialog(context, _accounts[i]),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () => _showDeleteDialog(context,
                                        _accounts[i]['account_number']),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          updateDetailsRek(
                            apiDataOwnSirelaId,
                            apiDataSendaAmount,
                            _accounts[i]['account_number'],
                            _accounts[i]['account_holder'],
                            _accounts[i]['account_holder'],
                            apiDataSendaComment,
                            apiDataKodeTrx,
                            apiDataMetodeTransfer,
                          );
                        },
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    NavigationHelper.pushReplacementNamed(
                      AppRoutes.input_account_dif_bank,
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
                      'Transfer Baru',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
