import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/Splash/splash_screen.dart';
import 'package:tfb/navigation_menu.dart';
import 'package:tfb/services/firebase_notification.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/account_screen.dart';
import 'package:tfb/views/HomeScreen/home_screen.dart';
import 'package:tfb/views/HouseboatScreen/houseboat_screen.dart';
import 'package:tfb/views/payment/payment_failed.dart';
import 'package:tfb/views/payment/payment_success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  //FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Freak BD',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.bgColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      //themeMode: ThemeMode.light,
      //home: OtpVerify(),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/main',
          page: () => NavigationMenu(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(
          name: '/home',
          page: () => HomeScreen(),
          transition: Transition.fadeIn,
          transitionDuration: Duration(milliseconds: 200),
        ),
        GetPage(name: '/houseboat', page: () => HouseboatScreen()),
        GetPage(
            name: '/account',
            page: () => AccountScreen(),
            transition: Transition.fadeIn,
            transitionDuration: Duration(milliseconds: 200)),
        GetPage(name: '/paymentSuccess', page: () => PaymentSuccess()),
        GetPage(name: '/paymentFailed', page: () => PaymentFailed()),
      ],
    );
  }
}
