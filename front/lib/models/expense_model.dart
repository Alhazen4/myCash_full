import 'package:my_cash_mobile/models/user_model.dart';

class ExpenseModel {
  int? userid;
  int? amount;

  ExpenseModel({
    this.amount,
    this.userid,
  });

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    userid = json['userID'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userid,
      'amount': amount,
    };
  }
}
