import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? fullname,
    String? age,
    String? phonenumber,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        fullname: fullname,
        age: age,
        phonenumber: phonenumber,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> edit({
    int? id,
    String? fullname,
    String? age,
    String? phonenumber,
    String? email,
  }) async {
    try {
      UserModel user = await AuthService().edit(
        id: id,
        fullname: fullname,
        age: age,
        phonenumber: phonenumber,
        email: email,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
