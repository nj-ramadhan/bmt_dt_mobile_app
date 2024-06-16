import 'package:flutter/material.dart';

import '../components/app_table_items.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/database_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.instance;

  String _table = 'same_bank';
  List<Map<String, dynamic>> _accounts = [];

  @override
  void initState() {
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: 'Account Number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    String accountHolder =
                        await ApiHelper.getAccountHolderSirela(
                      idSirela: _accountNumberController.text,
                      loginToken: apiLoginToken,
                    );
                    if (accountHolder != 'error') {
                      setState(() {
                        _accountHolderController.text = accountHolder;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("ID Sirela Tidak Ditemukan"),
                      ));
                    }
                  },
                ),
              ),
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

              if (accountNumber.isNotEmpty &&
                  accountHolder.isNotEmpty &&
                  accountAlias.isNotEmpty) {
                int result = await db.addAccount(
                    _table, accountNumber, accountHolder, accountAlias);
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
  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(0, screenHeight * 0.01, 0, 0),
        children: [
          GradientBackground(
            colors: const [Colors.transparent, Colors.transparent],
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => NavigationHelper.pushNamed(AppRoutes.transfer),
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
                    style: TextStyle(color: Colors.black),
                    onChanged: _searchAccounts,
                  ),
                ),
                SizedBox(width: 8.0),
                TextButton(
                  onPressed: () => _showAddDialog(context),
                  child: Text('Tambah', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          // Add a condition to check if the data is loaded
          _accounts.isEmpty
              ? Center()
              : Column(
                  children: _accounts.map((account) {
                    return Card(
                      color: AppColors.lightGreen,
                      child: InkWell(
                        onTap: () {
                            updateDetailsRek(
                          apiDataOwnSirelaId,
                          apiDataOwnSirelaAmount,
                          account['account_number'],
                          account['account_holder'],
                          // account['account_alias'],
                          apiDataSendaAmount,
                          apiDataSendaComment,
                          apiDataKodeTrx,
                          apiDataMetodeTransfer,
                          apiDataAdminAmount
                        );
                        NavigationHelper.pushReplacementNamed(
                          AppRoutes.input_amount,
                        );

                        }, // Add your onTap functionality here
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Table(
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(),
                                    1: FixedColumnWidth(10),
                                    2: FlexColumnWidth(),
                                  },
                                  children: [
                                    CustomTableRow.build("Nama", account['account_holder']),
                                    CustomTableRow.build("No. rek", account['account_number']),
                                    CustomTableRow.build("Alias", account['account_alias']),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      _showEditDialog(context, account);// Add your edit functionality here
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      _showDeleteDialog(context, account['account_number']);// Add your delete functionality here
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                NavigationHelper.pushNamed(AppRoutes.input_account);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
    ),
  );
}
  
}


