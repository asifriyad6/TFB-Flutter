import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';
import '../../widget/custom_button.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * .2,
            ),
            LottieBuilder.asset(
              'assets/payment_failed.json',
              height: 200,
            ),
            SizedBox(height: 80),
            const Text(
              'PAYMENT FAILED',
              style: TextStyle(
                color: Colors.red,
                fontSize: 32,
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
