import 'package:flutter/material.dart';
import 'package:my_cash_mobile/pages/edit_profile.dart';
import 'package:my_cash_mobile/pages/home/article.dart';
import 'package:my_cash_mobile/pages/home/home.dart';
import 'package:my_cash_mobile/pages/home/main_page.dart';
import 'package:my_cash_mobile/pages/home/profile.dart';
import 'package:my_cash_mobile/pages/home/statistic.dart';
import 'package:my_cash_mobile/pages/login_page.dart';
import 'package:my_cash_mobile/pages/onboarding_page.dart';
import 'package:my_cash_mobile/pages/sign_up_page.dart';
import 'package:my_cash_mobile/pages/splash_screen.dart';
import 'package:my_cash_mobile/pages/transaction.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/data_provider.dart';
import 'package:my_cash_mobile/providers/page_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/services/local_notification_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initializePlatformNotifications(); // <----
  await NotificationService().requestIOSPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Cash',
        routes: {
          '/': (context) => SplashPage(),
          '/onboarding': (context) => OnBoardingPage(),
          '/login': (context) => LoginPage(),
          '/sign-up': (context) => SignUpPage(),
          '/main': (context) => MainPage(),
          '/home': (context) => HomePage(),
          '/edit-profile': (context) => EditProfile(),
          '/cart': (context) => ArticlePage(),
          '/statistic': (context) => StatisticPage(),
          '/profile': (context) => ProfilePage(),
          '/transaction': (context) => TransactionScreen(),
        },
        // home: HomePage(),
      ),
    );
  }
}
