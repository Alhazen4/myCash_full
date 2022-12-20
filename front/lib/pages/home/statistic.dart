import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/data_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:my_cash_mobile/widget/chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  // List<StatisticModel> statistic = [];
  // bool loading = true;
  // NetworkHelper _networkHelper = NetworkHelper();
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // void getData() async {
  //   var response = await _networkHelper.get("http://10.0.2.2:3000/income/1");
  //   List<StatisticModel> tempdata = statisticModelFromJson(response.body);
  //   setState(() {
  //     statistic = tempdata;
  //     loading = false;
  //   });
  //   print(tempdata);
  // }

  bool isIncome = true;
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel user = authProvider.user;
    List<TransactionModel> datas = dataProvider.datas;
    datas.length;
    print(datas.length);
    TransactionProvider? transactionProvider =
        Provider.of<TransactionProvider>(context);
    final _week = [0, 0, 0, 0, 0, 0, 0];

    List<String> weekText() {
      return [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
      ];
    }

    changeIncome() async {
      await Provider.of<DataProvider>(context, listen: false)
          .getIncome(userid: user.id);
      setState(() {
        isIncome = true;
        print(isIncome);
      });
    }

    changeExpenses() async {
      await Provider.of<DataProvider>(context, listen: false)
          .getExpense(userid: user.id);
      setState(() {
        isIncome = false;
        print(isIncome);
      });
    }

    Widget Category() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Row(
          children: [
            SizedBox(
              width: defaultMargin,
            ),
            ChoiceChip(
              label: Text("Income",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      color: isIncome ? bglight : blackColor)),
              selected: isIncome ? true : false,
              disabledColor: bglight,
              selectedColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value) {
                  setState(() {
                    changeIncome();
                  });
                }
              },
            ),
            SizedBox(
              width: 16,
            ),
            ChoiceChip(
              label: Text("Expense",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      color: isIncome ? blackColor : bglight)),
              selected: isIncome ? false : true,
              disabledColor: bglight,
              selectedColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value) {
                  setState(() {
                    changeExpenses();
                  });
                }
              },
            ),
          ],
        ),
      );
    }

    AspectRatio weekly() {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: DChartBar(
          data: [
            {
              'id': 'Bar',
              'data': [
                {"domain": "1", "measure": 555555},
                {"domain": "2", "measure": 50000},
                {"domain": "3", "measure": 200000},
                {"domain": "4", "measure": 30000},
                {"domain": "5", "measure": 30000},
              ],

              // 'data': List.generate(8, (index) {
              //   return {
              //     'domain': weekText()[index],
              //     'measure': datas
              //         .map((e) =>
              //             dataProvider.getIncome(userid: user.id).toString())
              //         .toList()[index],
              //   };
              // }),
            }
          ],
          domainLabelPaddingToAxisLine: 8,
          axisLineTick: 2,
          axisLinePointWidth: 10,
          axisLineColor: primaryColor,
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) => primaryColor,
          showBarValue: true,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(widthFactor: 1, child: Category()),
                SizedBox(
                  height: 250,
                ),
                Center(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: Text(
                      'Feature is Not Available',
                      style: primaryTextStyle.copyWith(
                        fontSize: 32,
                        fontWeight: medium,
                      ),
                    )),
                SizedBox(
                  height: 12,
                ),
                // Center(
                //   child: Container(
                //     child: SfCartesianChart(
                //       primaryXAxis: NumericAxis(),
                //       primaryYAxis: NumericAxis(),
                //       series: <ColumnSeries<TransactionModel, num>>[
                //         ColumnSeries<TransactionModel, num>(
                //             dataSource: datas,
                //             xValueMapper: (TransactionModel datas, _) =>
                //                 datas.userid,
                //             yValueMapper: (TransactionModel datas, _) =>
                //                 datas.amount,
                //             dataLabelSettings:
                //                 DataLabelSettings(isVisible: true)),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     changeIncome();
      //   },
      //   child: const Icon(Icons.refresh, color: Colors.white),
      // )
    );
  }
}
