import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transactions.dart';

class TransactionDB {
  final String dbName;

  TransactionDB({required this.dbName});

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), dbName);
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE transactions(keyID INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, details TEXT, country TEXT, era TEXT, imageUrl TEXT)',
      );
    }, version: 1);
  }

  Future<List<Transactions>> loadAllData() async {
    final db = await _initDB();
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return Transactions(
        keyID: maps[i]['keyID'],
        title: maps[i]['title'],
        details: maps[i]['details'],
        country: maps[i]['country'],
        era: maps[i]['era'],
        imageUrl: maps[i]['imageUrl'],
      );
    });
  }

  Future<void> insertDatabase(Transactions transaction) async {
    final db = await _initDB();
    await db.insert('transactions', {
      'title': transaction.title,
      'details': transaction.details,
      'country': transaction.country,
      'era': transaction.era,
      'imageUrl': transaction.imageUrl,
    });
  }

  Future<void> deleteDatabase(int? keyID) async {
    final db = await _initDB();
    await db.delete(
      'transactions',
      where: 'keyID = ?',
      whereArgs: [keyID],
    );
  }

  Future<void> updateDatabase(Transactions transaction) async {
    final db = await _initDB();
    await db.update(
      'transactions',
      {
        'title': transaction.title,
        'details': transaction.details,
        'country': transaction.country,
        'era': transaction.era,
        'imageUrl': transaction.imageUrl,
      },
      where: 'keyID = ?',
      whereArgs: [transaction.keyID],
    );
  }
}
