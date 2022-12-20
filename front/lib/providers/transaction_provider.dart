import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  TransactionModel _transaction = TransactionModel();

  TransactionModel get transaction => _transaction;

  set transaction(TransactionModel transaction) {
    _transaction = transaction;
    notifyListeners();
  }

  Future<bool> income({
    int? amount,
    int? userid,
  }) async {
    try {
      TransactionModel transaction = await TransactionService().income(
        amount: amount,
        userid: userid,
      );
      print(amount);

      _transaction = transaction as TransactionModel;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> expense({
    int? amount,
    int? userid,
  }) async {
    try {
      TransactionModel transaction = await TransactionService().expense(
        amount: amount,
        userid: userid,
      );
      print(amount);

      _transaction = transaction as TransactionModel;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getSUM({
    int? total_amount,
    int? userid,
  }) async {
    try {
      TransactionModel transaction = await TransactionService().getSUM(
        total_amount: total_amount,
        userid: userid,
      );
      print(total_amount);

      _transaction = transaction as TransactionModel;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
