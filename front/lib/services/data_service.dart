import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_cash_mobile/models/expense_model.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class DataService {
  String baseUrl = 'http://13.250.110.90:3000';

  Future<List<TransactionModel>> getIncome({int? userid, int? amount}) async {
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user = authProvider.user;
    var url = '$baseUrl/income/${userid}';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(url);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<TransactionModel> datas = [];

      for (var item in data) {
        datas.add(TransactionModel.fromJson(item));
      }

      return datas;
    } else {
      throw Exception('Gagal Get Data!');
    }
  }

  Future<List<TransactionModel>> getExpense({int? userid, context}) async {
    // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // UserModel user = authProvider.user;
    var url = '$baseUrl/expense/${userid}';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(url);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<TransactionModel> datas = [];

      for (var item in data) {
        datas.add(TransactionModel.fromJson(item));
      }

      return datas;
    } else {
      throw Exception('Gagal Get Data!');
    }
  }
}
