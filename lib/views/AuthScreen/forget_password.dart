import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/widget/custom_button.dart';

import '../../controller/auth_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Forget Password'),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "Please enter your registered mobile number and we'll send you an OTP code to reset your password.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.smartphone),
                  label: Text('Mobile Number'),
                  hintText: 'Format: 016********'),
              onChanged: (value) {
                controller.userModel.value.phone = value;
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Submit',
              onTap: () {
                controller.sendOtpPassReset(false);
              },
            )
          ],
        ),
      )),
    );
  }
}
