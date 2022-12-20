import 'dart:convert';
import 'dart:io';

import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  String baseUrl = 'http://13.250.110.90:3000';
  // String baseUrl = 'https://reqres.in';

  Future<TransactionModel> income({
    int? amount,
    int? userid,
  }) async {
    var url = '$baseUrl/income/${userid}';
    // var url = '$baseUrl/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'amount': amount,
      'userID': userid,
    });
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.body);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']; //['data'];
        TransactionModel transaction = TransactionModel.fromJson(data);
        return transaction;
      } else {
        throw Exception('Gagal masukkin data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<TransactionModel> expense({
    int? amount,
    int? userid,
  }) async {
    var url = '$baseUrl/expense/${userid}';
    // var url = '$baseUrl/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'amount': amount,
      'userID': userid,
    });
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.body);
      print(response.statusCode);
      print(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']; //['data'];
        TransactionModel transaction = TransactionModel.fromJson(data);
        // data.token = 'Bearer ' + data['access_token'];
        // print(data['user']);
        return transaction;
      } else {
        throw Exception('Gagal masukkin data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<TransactionModel> getSUM({
    int? total_amount,
    int? userid,
  }) async {
    var url = '$baseUrl/trans/${userid}';
    // var url = '$baseUrl/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'total_amount': total_amount,
      'userID': userid,
    });
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.body);
      print(url);
      var data = jsonDecode(response.body);
      TransactionModel transaction = TransactionModel.fromJson(data);
      print(data);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body); //['data'];
        TransactionModel transaction = TransactionModel.fromJson(data);
        // data.token = 'Bearer ' + data['access_token'];
        // print(data['user']);
        return transaction;
      } else {
        throw Exception('Gagal masukkin data');
      }
    } catch (error) {
      throw error;
    }
  }
}
