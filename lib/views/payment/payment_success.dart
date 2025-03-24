import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/widget/custom_button.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * .2,
            ),
            LottieBuilder.asset(
              'assets/payment_success.json',
              height: 200,
            ),
            SizedBox(height: 80),
            Text(
              'Thank You!',
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Payment Done Successfully.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              title: 'Back to Home',
              onTap: () {
                Get.offAllNamed('/main');
              },
              fullWidth: 200,
            ),
          ],
        ),
      ),
    );
  }
}
