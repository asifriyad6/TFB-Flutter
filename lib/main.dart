import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/Splash/splash_screen.dart';
import 'package:tfb/navigation_menu.dart';
import 'package:tfb/theme/theme_data.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/account_screen.dart';
import 'package:tfb/views/HomeScreen/home_screen.dart';
import 'package:tfb/views/HouseboatScreen/houseboat_screen.dart';
import 'package:tfb/views/payment/payment_failed.dart';
import 'package:tfb/views/payment/payment_success.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      //home: PaymentSuccess(),
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
