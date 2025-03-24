import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/widget/custom_button.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Forget Password'),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Please enter your mobile number and we'll send you a OTP code to reset your password.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.smartphone),
                  label: Text('Mobile Number'),
                  hintText: 'Format: 016********'),
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Submit',
              onTap: () {},
            )
          ],
        ),
      )),
    );
  }
}
