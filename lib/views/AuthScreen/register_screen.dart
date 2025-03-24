import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/views/AuthScreen/login_screen.dart';
import 'package:tfb/views/AuthScreen/otp_verify.dart';

import '../../widget/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close_outlined,
              size: 30,
            )),
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(
              () {
                return controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Text(
                            'create Account!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your journey with TravelFreak BD starts here',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.smartphone),
                                label: Text('Mobile Number'),
                                hintText: 'Format: 016********'),
                            onChanged: (value) {
                              controller.userModel.value.phone = value;
                            },
                          ),
                          SizedBox(height: 20),
                          CustomButton(
                            title: 'Continue',
                            onTap: () {
                              controller.sendOtp();
                            },
                          ),
                        ],
                      );
              },
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Text(
                  "Let's Log in!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
