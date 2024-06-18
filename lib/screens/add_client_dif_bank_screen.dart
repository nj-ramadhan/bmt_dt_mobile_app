import 'package:flutter/material.dart';

import '../components/app_drop_down_form_field.dart';
import '../components/app_drop_down_items.dart';
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
import '../components/base_layout.dart';

class AddClientDifBankPage extends StatefulWidget {
  const AddClientDifBankPage({super.key});

  @override
  State<AddClientDifBankPage> createState() => _AddClientDifBankPageState();
}

class _AddClientDifBankPageState extends State<AddClientDifBankPage> {
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
        title: const Text('Edit Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Account Number',
              ),
              readOnly: true,
            ),
            TextField(
              controller: _accountHolderController,
              decoration: const InputDecoration(labelText: 'Account Holder'),
              readOnly: true,
            ),
            TextField(
              controller: _accountAliasController,
              decoration: const InputDecoration(labelText: 'Account Alias'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await db.updateAccount(
                _table,
                _accountNumberController.text,
                _accountHolderController.text,
                _accountAliasController.text,
              );
              _fetchAccounts();
              if (mounted) Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String accountNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete this account?'),
        actions: [
          TextButton(
            onPressed: () async {
              await db.deleteAccount(_table, accountNumber);
              _fetchAccounts();
              if (mounted) Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
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
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Account'),
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
                  setDialogState(() {
                    valueDownCodeBank = value;
                  });
                },
                onItemSelected: (title) {
                  setDialogState(() {
                    valueDownBank = title;
                  });
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      String accountHolder =
                          await ApiHelper.getAccountHolderDifBank(
                        apiLoginToken,
                        _accountNumberController.text,
                        valueDownCodeBank.toString(),
                        apiDataMetodeTransfer,
                      );

                      if (accountHolder != 'error') {
                        setDialogState(() {
                          _accountHolderController.text = accountHolder;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("ID Sirela Tidak Ditemukan"),
                          ),
                        );
                      }
                    },
                  ),
                ),
                enabled: valueDownCodeBank != null,
              ),
              TextField(
                controller: _accountHolderController,
                decoration: const InputDecoration(labelText: 'Account Holder'),
                readOnly: true,
              ),
              TextField(
                controller: _accountAliasController,
                decoration: const InputDecoration(labelText: 'Account Alias'),
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
                    valueDownCodeBank.toString(),
                  );
                  if (result != -1) {
                    _fetchAccounts();
                    if (mounted) Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account already exists')),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
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
                        onPressed: () =>
                            NavigationHelper.pushNamed(AppRoutes.transfer),
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
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Cari...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        onChanged: _searchAccounts,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () => _showAddDialog(context),
                      child: const Text(
                        'Tambah',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
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
                          NavigationHelper.pushNamed(
                              AppRoutes.input_amount_dif_bank,
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
                    NavigationHelper.pushNamed(AppRoutes.input_account_dif_bank);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64.0),
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
      ),
    );
  }
}
