import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartList extends StatelessWidget {
  final TransactionModel data;
  List<TransactionModel> datas;
  ChartList(this.data, this.datas);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/edit-profile');
      },
      child: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
            series: <ColumnSeries<TransactionModel, num>>[
              ColumnSeries<TransactionModel, num>(
                  dataSource: datas,
                  xValueMapper: (TransactionModel data, _) => data.userid,
                  yValueMapper: (TransactionModel data, _) => data.amount,
                  dataLabelSettings: DataLabelSettings(isVisible: true)),
            ],
          ),
        ),
      ),
    );
  }
}
