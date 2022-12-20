import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/services/data_service.dart';

class DataProvider with ChangeNotifier {
  List<TransactionModel> _datas = [];

  List<TransactionModel> get datas => _datas;

  set datas(List<TransactionModel> datas) {
    _datas = datas;
    notifyListeners();
  }

  Future<void> getIncome({
    int? userid,
    int? amount,
  }) async {
    try {
      List<TransactionModel> datas =
          await DataService().getIncome(userid: userid, amount: amount);
      _datas = datas;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getExpense({int? userid}) async {
    try {
      List<TransactionModel> datas =
          await DataService().getExpense(userid: userid);
      _datas = datas;
    } catch (e) {
      print(e);
    }
  }
}
