import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/pages/home/article.dart';
import 'package:my_cash_mobile/pages/home/home.dart';
import 'package:my_cash_mobile/pages/home/profile.dart';
import 'package:my_cash_mobile/pages/home/statistic.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/page_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/services/local_notification_service.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

TextEditingController amountController = TextEditingController(text: '');
bool isLoading = false;
bool isIncome = true;

class _MainPageState extends State<MainPage> {
  late final NotificationService notificationService;
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    print(user.id);

    changeIncome() async {
      setState(() {
        isIncome = true;
        print(isIncome);
      });
      Navigator.pushNamed(context, '/main');
    }

    changeExpenses() async {
      setState(() {
        isIncome = false;
        print(isIncome);
      });
      Navigator.pushNamed(context, '/main');
    }

    handleIncome() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.income(
          amount: int.parse(amountController.text), userid: user.id)) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    handleExpenses() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.expense(
          amount: int.parse(amountController.text), userid: user.id)) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    PageProvider pageProvider = Provider.of<PageProvider>(context);

    Widget addButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/transaction');
        },
        elevation: 8,
        backgroundColor: primaryColor,
        child: Image.asset(
          'assets/icon/ic_add.png',
          width: 20,
          color: bglight,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              // color: blackColor,
            ),
            backgroundColor: bglight,
            currentIndex: pageProvider.currentIndex,
            onTap: (value) {
              print(value);
              pageProvider.currentIndex = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/ic_home.png',
                    width: 24,
                    color: pageProvider.currentIndex == 0
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/ic_chart.png',
                    width: 24,
                    color: pageProvider.currentIndex == 1
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: 'statictic',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/ic_article.png',
                    width: 24,
                    color: pageProvider.currentIndex == 2
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: 'article',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Image.asset(
                    'assets/icon/ic_profile.png',
                    width: 24,
                    color: pageProvider.currentIndex == 3
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: 'profile',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomePage();
        // break;
        case 1:
          return StatisticPage();
        // break;
        case 2:
          return ArticlePage();
        // break;
        case 3:
          return ProfilePage();
        // break;

        default:
          return HomePage();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: pageProvider.currentIndex == 0 ? navColor : navColor,
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
