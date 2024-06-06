import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bank_accounts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Update version number if schema changes
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE same_bank (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account_number TEXT NOT NULL UNIQUE,
      account_holder TEXT NOT NULL,
      account_alias TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE different_bank_TO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account_number TEXT NOT NULL UNIQUE,
      account_holder TEXT NOT NULL,
      account_bank TEXT NOT NULL,
      account_code_bank TEXT NOT NULL,
      account_alias TEXT
    )
    ''');

    
    await db.execute('''
    CREATE TABLE different_bank_BIFAST (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account_number TEXT NOT NULL UNIQUE,
      account_holder TEXT NOT NULL,
      account_bank TEXT NOT NULL,
      account_code_bank TEXT NOT NULL,
      account_alias TEXT
    )
    ''');


    await db.execute('''
    CREATE TABLE different_bank_RTGS (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      account_number TEXT NOT NULL UNIQUE,
      account_holder TEXT NOT NULL,
      account_bank TEXT NOT NULL,
      account_code_bank TEXT NOT NULL,
      account_alias TEXT
    )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Perform database schema changes if necessary
      // For example, adding a new column:
      await db.execute('ALTER TABLE same_bank ADD COLUMN account_alias TEXT');
      await db.execute('ALTER TABLE different_bank ADD COLUMN account_alias TEXT');
    }
  }

  Future<int> addAccount(String table, String accountNumber, String accountHolder, String accountAlias) async {
    final db = await instance.database;
    final data = {
      'account_number': accountNumber,
      'account_holder': accountHolder,
      'account_alias': accountAlias
    };

    try {
      return await db.insert(table, data);
    } catch (e) {
      return -1; // if there's a conflict (duplicate entry)
    }
  }

  Future<int> addAccountDifBank(String table, String accountNumber, String accountHolder, String accountAlias,String account_bank,String account_code_bank) async {
    final db = await instance.database;
    final data = {
      'account_number': accountNumber,
      'account_holder': accountHolder,
      'account_alias': accountAlias,
      'account_bank': account_bank,
      'account_code_bank': account_code_bank,
    };

    try {
      return await db.insert(table, data);
    } catch (e) {
      return -1; // if there's a conflict (duplicate entry)
    }
  }

  Future<int> updateAccount(String table, String accountNumber, String accountHolder, String accountAlias) async {
    final db = await instance.database;
    final data = {
      'account_holder': accountHolder,
      'account_alias': accountAlias
    };

    return await db.update(table, data, where: 'account_number = ?', whereArgs: [accountNumber]);
  }

  Future<int> deleteAccount(String table, String accountNumber) async {
    final db = await instance.database;
    return await db.delete(table, where: 'account_number = ?', whereArgs: [accountNumber]);
  }

  Future<List<Map<String, dynamic>>> fetchAccounts(String table) async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> searchAccounts(String table, String query) async {
    final db = await instance.database;
    return await db.query(
      table,
      where: 'account_number LIKE ? OR account_holder LIKE ? OR account_alias LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
  }
}
