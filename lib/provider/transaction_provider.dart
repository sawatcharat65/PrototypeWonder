import 'package:flutter/material.dart';
import '../databases/transaction_db.dart';
import '../models/transactions.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transactions> _transactions = [];
  final TransactionDB _db = TransactionDB(dbName: 'transactions.db');

  List<Transactions> get transactions => _transactions;

  Future<void> initData() async {
    _transactions = await _db.loadAllData();
    notifyListeners();
  }

  Future<void> addTransaction(Transactions transaction) async {
    await _db.insertDatabase(transaction);
    await initData();
  }

  Future<void> deleteTransaction(int? keyID) async {
    await _db.deleteDatabase(keyID);
    await initData();
  }

  Future<void> updateTransaction(Transactions transaction) async {
    await _db.updateDatabase(transaction);
    await initData();
  }

  List<Transactions> getTransactionsByEra(String era) {
    return _transactions.where((transaction) => transaction.era == era).toList();
  }
}
