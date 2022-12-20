import 'dart:convert';
import 'dart:io';

import 'package:my_cash_mobile/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://13.250.110.90:3000';
  // String baseUrl = 'https://reqres.in';

  Future<UserModel> register({
    String? fullname,
    String? age,
    String? phonenumber,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/user/';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'fullname': fullname,
      'age': age,
      'phonenumber': phonenumber,
      'email': email,
      'password': password,
    });

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> edit({
    int? id,
    String? fullname,
    String? age,
    String? phonenumber,
    String? email,
  }) async {
    var url = '$baseUrl/user/${id}';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'fullname': fullname,
      'age': age,
      'phonenumber': phonenumber,
      'email': email,
    });
    print(url);

    http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception('Gagal Ganti Data');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/user/login';
    // var url = '$baseUrl/api/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      print(data);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data']; //['data'];
        UserModel user = UserModel.fromJson(data);
        // data.token = 'Bearer ' + data['access_token'];
        // print(data['user']);
        return user;
      } else {
        throw Exception('Gagal Login');
      }
    } catch (error) {
      throw error;
    }
  }
}
