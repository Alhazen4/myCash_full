import 'package:my_cash_mobile/models/user_model.dart';

class TransactionModel {
  int? userid;
  int? amount;
  int? total_amount;
  String? user_status;

  TransactionModel(
      {this.amount, this.userid, this.total_amount, this.user_status});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    userid = json['userID'];
    amount = json['amount'];
    total_amount = json['total_amount'];
    user_status = json['user_status'];
  }

  get week => null;

  Map<String, dynamic> toJson() {
    return {
      'userID': userid,
      'amount': amount,
      'total_amount': total_amount,
      'user_status': user_status
    };
  }
}
