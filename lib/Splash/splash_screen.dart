import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Get.offAllNamed('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/tfb_logo.png',
                width: width * .6,
              ),
            ),
            Positioned(
              bottom: height * .32,
              child: LottieBuilder.asset(
                'assets/lottie/location_animation.json',
                width: width * 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
