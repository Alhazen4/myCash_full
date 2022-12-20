import 'package:my_cash_mobile/providers/auth_provider.dart';

class ChartList {
  AuthProvider _auth = AuthProvider();

  List<String> _amount = [];
  ChartList(this._amount);

  List get amount => _amount;
}
