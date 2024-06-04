// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';
import '../utils/helpers/api_helper.dart';
// import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/database_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';
// import '../utils/helpers/navigation_helper.dart';
// import '../values/app_colors.dart';
// import '../values/app_strings.dart';
// import '../values/app_theme.dart';

class AddClientPage extends StatefulWidget {
  const AddClientPage({super.key});

  @override
  State<AddClientPage> createState() => _AddClientPageState();
}

class _AddClientPageState extends State<AddClientPage> {
  final Color backgroundColor = Color(0xFFD5F5E3); // Adjust this color to match the exact color from the image.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFD0F0C0), // Specific green color from your image
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.greenAccent, // Accent color if needed
          primary: Color(0xFFD0F0C0), // Primary color
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black), // Black text color
          bodyMedium: TextStyle(color: Colors.black), // Black text color
        ),
      ),
      home: FavoriteAccountsPage(),
    );
  }
}

class FavoriteAccountsPage extends StatefulWidget {
  @override
  _FavoriteAccountsPageState createState() => _FavoriteAccountsPageState();
}

class _FavoriteAccountsPageState extends State<FavoriteAccountsPage> {
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
 Future<String?> fetchAccountHolder(String accountNumber) async {
    // Simulasi panggilan API
    // Gantilah URL dan logika ini dengan panggilan API yang sesuai
    await Future.delayed(Duration(seconds: 1)); // Simulasi waktu tunggu API
    if (accountNumber == "0011777711") {
      return "BAZNAS";
    } else if (accountNumber == "0011555510") {
      return "BAZNAS";
    } else if (accountNumber == "0011210077") {
      return "Inisiatif Zakat Indonesia";
    } else if (accountNumber == "0011210044") {
      return "Inisiatif Zakat Indonesia";
    } else if (accountNumber == "0016000066") {
      return "LAZ Baitul Maal Hidayatullah";
    } else if (accountNumber == "0011002002") {
      return "LAZIS Dewan Da'wah";
    } else {
      return null;
    }
  }
  void _showEditDialog(BuildContext context, Map<String, dynamic> account) {
    final TextEditingController _accountNumberController = TextEditingController(text: account['account_number']);
    final TextEditingController _accountHolderController = TextEditingController(text: account['account_holder']);
    final TextEditingController _accountAliasController = TextEditingController(text: account['account_alias']);

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
                // suffixIcon: IconButton(
                //   icon: Icon(Icons.search),
                //   onPressed: () async {
                //     String accountHolder = await ApiHelper.getAccountHolderSirela(idSirela: _accountNumberController.text,LoginToken: apiLoginToken) ?? 'Not Found';
                //     _accountHolderController.text = accountHolder;
                //   },
                // ),
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
              await db.updateAccount(_table, _accountNumberController.text, _accountHolderController.text, _accountAliasController.text);
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
    final TextEditingController _accountNumberController = TextEditingController();
    final TextEditingController _accountHolderController = TextEditingController();
    final TextEditingController _accountAliasController = TextEditingController();

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
                    String accountHolder = await ApiHelper.getAccountHolderSirela(idSirela: _accountNumberController.text,LoginToken: apiLoginToken);
                    _accountHolderController.text = accountHolder;
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

              if (accountNumber.isNotEmpty && accountHolder.isNotEmpty && accountAlias.isNotEmpty) {
                int result = await db.addAccount(_table, accountNumber, accountHolder, accountAlias);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer ke Sesama'),
        backgroundColor: Color(0xFFD0F0C0), // Specific green color from your image
      ),
      backgroundColor: Color(0xFFD0F0C0), // Specific green color from your image
      body: Column(
        children: [
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
                    style: TextStyle(color: Colors.black), // Black text color
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
          Expanded(
            child: ListView.builder(
              itemCount: _accounts.length,
              itemBuilder: (context, index) {
                final account = _accounts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(account['account_holder'][0]),
                  ),
                  title: Text(account['account_holder']),
                  subtitle: Text('${account['account_number']} (${account['account_alias']})'),
                  onTap: () {

                    updateDetailsRek(
                      apiDataOwnSirelaId,
                      apiDataOwnSirelaAmount,
                      account['account_number'],
                      account['account_holder'],
                    );
                    NavigationHelper.pushReplacementNamed(
                        AppRoutes.home,);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditDialog(context, account),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _showDeleteDialog(context, account['account_number']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Transfer Baru'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Using green for button
                minimumSize: Size(double.infinity, 50), // Make button full-width
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildAccountItem(String title, String subtitle, String initials) {
  //   return ListTile(
  //     leading: CircleAvatar(
  //       child: Text(initials, style: TextStyle(color: Colors.white)),
  //       backgroundColor: Colors.green, // Use green color for avatar background
  //     ),
  //     title: Text(title, style: TextStyle(color: Colors.black)), // Black text color
  //     subtitle: Text(subtitle, style: TextStyle(color: Colors.black)), // Black text color
  //     onTap: () {},
  //   );
  // }
}
