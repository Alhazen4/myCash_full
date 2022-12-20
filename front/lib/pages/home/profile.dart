import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/services/local_notification_service.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      switch (transaction.user_status) {
        case "Health":
          notificationService.showLocalNotification(
              id: 0,
              title: "Status Financial:",
              body: "${transaction.user_status}",
              payload: "Notification");
          break;
        case "Balance":
          notificationService.showLocalNotification(
              id: 0,
              title: "Status Financial:",
              body: "${transaction.user_status}",
              payload: "Notification");
          break;
        case "Minus":
          notificationService.showLocalNotification(
              id: 0,
              title: "Status Financial:",
              body: "${transaction.user_status}",
              payload: "Notification");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    TransactionModel transaction = transactionProvider.transaction;
    bool isLoading = false;

    Provider.of<TransactionProvider>(context, listen: false)
        .getSUM(userid: user.id);

    // switch (transaction.user_status) {
    //   case "Health":
    //     notificationService.showLocalNotification(
    //         id: 0,
    //         title: "Status Financial:",
    //         body: "${transaction.user_status}",
    //         payload: "Notification");
    //     break;
    //   case "Balance":
    //     notificationService.showLocalNotification(
    //         id: 0,
    //         title: "Status Financial:",
    //         body: "${transaction.user_status}",
    //         payload: "Notification");
    //     break;
    //   case "Minus":
    //     notificationService.showLocalNotification(
    //         id: 0,
    //         title: "Status Financial:",
    //         body: "${transaction.user_status}",
    //         payload: "Notification");
    //     break;
    // }

    Widget Header() {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage(
            'assets/illustration/profile.png',
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "${user.fullname}",
          style: primaryTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
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
                    fontSize: 16, fontWeight: regular, color: blackColor)),
            SizedBox(
              width: 8,
            ),
            Text("${transaction.user_status}",
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold, color: primaryColor)),
          ],
        ),
      ]);
    }

    Widget Card() {
      return SafeArea(
        child: Container(
            width: double.infinity,
            height: 110,
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
            child: Column(
              children: [
                Text("Total Balance",
                    style: primaryTextStyle.copyWith(
                        fontSize: 13, fontWeight: regular, color: bglight)),
                SizedBox(
                  height: 8,
                  width: 16,
                ),
                Text("Rp. ${transaction.total_amount}",
                    style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                        color: primaryColor)),
              ],
            )),
      );
    }

    Widget Personal() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/edit-profile');
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 40, left: 24, right: 24),
          padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
          decoration: BoxDecoration(
            color: bglight,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icon/ic_profile.png',
                width: 24,
              ),
              SizedBox(
                width: 16,
              ),
              Text("Edit Profile",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold, color: blackColor)),
            ],
          ),
        ),
      );
    }

    Widget Notification() {
      return GestureDetector(
        onTap: () async {
          if (transaction.user_status == "Health") {
            await notificationService.showLocalNotification(
                id: 0,
                title: "Status Financial:",
                body: "${transaction.user_status}",
                payload: "Notification");
          }
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 16, left: 24, right: 24),
          padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
          decoration: BoxDecoration(
            color: bglight,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icon/ic_profile.png',
                width: 24,
              ),
              SizedBox(
                width: 16,
              ),
              Text("Notification",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold, color: blackColor)),
            ],
          ),
        ),
      );
    }

    Widget Logout() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 16, left: 24, right: 24),
          padding: EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
          decoration: BoxDecoration(
            color: bglight,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icon/ic_logout.png',
                width: 24,
              ),
              SizedBox(
                width: 16,
              ),
              Text("Logout",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold, color: blackColor)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bglight,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          children: [Header(), Card(), Personal(), Notification(), Logout()],
        ),
      )),
    );
  }
}
