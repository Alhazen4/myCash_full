import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/expense_model.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/data_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/services/local_notification_service.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:my_cash_mobile/widget/data_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool isIncome = true;
  late final NotificationService notificationService;

  @override
  void initState() {
    getInit();
    notificationService = NotificationService();
    Trigger();

    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.pushNamed(context, '/main', arguments: payload);
      });
  void Trigger() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TransactionProvider transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);
      TransactionModel transaction = transactionProvider.transaction;
      notificationService.showPeriodicLocalNotification(
          id: 0,
          title: 'Status Finacial',
          body: '${transaction.user_status}',
          payload: 'User Status');
    });
  }

  void getInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      UserModel user = authProvider.user;
      DataProvider dataProvider =
          Provider.of<DataProvider>(context, listen: false);
      Provider.of<DataProvider>(context, listen: false)
          .getIncome(userid: user.id);
      Provider.of<DataProvider>(context, listen: false)
          .getExpense(userid: user.id);
      Provider.of<TransactionProvider>(context, listen: false)
          .getSUM(userid: user.id);

      TransactionProvider? transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);
      TransactionModel? transaction = transactionProvider.transaction;
      List<TransactionModel> datas = dataProvider.datas;
    });
  }

  Widget build(BuildContext context) {
    // Provider
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    TransactionProvider? transactionProvider =
        Provider.of<TransactionProvider>(context);
    TransactionModel? transaction = transactionProvider.transaction;
    List<TransactionModel> datas = dataProvider.datas;

    // get data
    Provider.of<DataProvider>(context, listen: false)
        .getIncome(userid: user.id);
    Provider.of<DataProvider>(context, listen: false)
        .getExpense(userid: user.id);

    Provider.of<TransactionProvider>(context, listen: false)
        .getSUM(userid: user.id);

    print(datas);

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

    Widget Header() {
      return Container(
        width: double.infinity,
        height: 100,
        padding: EdgeInsets.only(right: 24, left: 24, top: 24, bottom: 16),
        decoration: BoxDecoration(
          color: bglight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(
                    'assets/illustration/profile.png',
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "${user.fullname}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.notifications,
            color: blackColor,
          ),
        ]),
      );
    }

    Widget Card() {
      return SafeArea(
        child: Container(
            width: double.infinity,
            height: 170,
            margin: EdgeInsets.only(top: 24, left: 24, right: 24),
            padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Total Balance",
                        style: primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: regular, color: bglight)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Rp. ${transaction.total_amount}",
                      style: primaryTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: semiBold,
                          color: primaryColor)),
                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.health_and_safety,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Status:",
                          style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: regular,
                              color: bglight)),
                      SizedBox(
                        width: 8,
                      ),
                      Text("${transaction.user_status}",
                          style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              color: primaryColor)),
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       width: 100,
                  //       margin: EdgeInsets.only(top: 16),
                  //       child: TextButton(
                  //         onPressed: (() => {
                  //               setState(() {
                  //                 isLoading = true;
                  //               }),
                  //               Future.delayed(Duration(seconds: 2), () {
                  //                 setState(() {
                  //                   isLoading = false;
                  //                 });
                  //               })
                  //             }),
                  //         style: TextButton.styleFrom(
                  //           backgroundColor: primaryColor,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           'Income',
                  //           style: primaryTextStyle.copyWith(
                  //               fontSize: 16, fontWeight: medium, color: bglight),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16,
                  //     ),
                  //     Container(
                  //       width: 100,
                  //       margin: EdgeInsets.only(top: 16),
                  //       child: TextButton(
                  //         onPressed: (() => {
                  //               setState(() {
                  //                 isLoading = true;
                  //               }),
                  //               Future.delayed(Duration(seconds: 2), () {
                  //                 setState(() {
                  //                   isLoading = false;
                  //                 });
                  //               })
                  //             }),
                  //         style: TextButton.styleFrom(
                  //           backgroundColor: primaryColor,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12),
                  //           ),
                  //         ),
                  //         child: Text(
                  //           'Expenses',
                  //           style: primaryTextStyle.copyWith(
                  //               fontSize: 16, fontWeight: medium, color: bglight),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )),
      );
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

    Widget Income() {
      return Container(
        margin: EdgeInsets.only(
          top: 8,
        ),
        child: Column(
          children: dataProvider.datas
              .map(
                (data) => DataList(data),
              )
              .toList(),
        ),
      );
    }

    Widget Expense() {
      return Container(
        margin: EdgeInsets.only(
          top: 8,
        ),
        child: Column(
          children: dataProvider.datas
              .map(
                (data) => DataList(data),
              )
              .toList(),
        ),
      );
    }

    Widget TextTransaction(String type) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(top: 20),
        child: Text(type,
            style: primaryTextStyle.copyWith(
              fontSize: 32,
              fontWeight: bold,
            )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(12),
          child: Container(
            color: Colors.white,
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: bglight,
        title: Header(),
      ),
      body: ListView(
        children: [
          Card(),
          Category(),
          isIncome ? TextTransaction('Income') : TextTransaction('Expenses'),
          isIncome ? Income() : Expense(),
        ],
      ),
    );
  }
}
