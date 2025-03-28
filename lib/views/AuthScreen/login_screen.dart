import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AuthScreen/forget_password.dart';
import 'package:tfb/views/AuthScreen/register_screen.dart';
import 'package:tfb/widget/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.offAllNamed('/main'),
            icon: Icon(
              Icons.close_outlined,
              size: 30,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Continue your holiday with TravelFreak BD',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: AppColor.primaryColor,
                      hintText: 'Format : 016*******',
                      labelText: 'Mobile Number',
                      prefixIcon: Icon(Icons.smartphone),
                    ),
                    onChanged: (value) {
                      controller.userModel.value.phone = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: controller.passView.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: AppColor.primaryColor,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.passView.value =
                              !controller.passView.value;
                        },
                        icon: Icon(controller.passView.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    onChanged: (value) {
                      controller.userModel.value.password = value;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    title: controller.loadingLogin.value
                        ? 'Please Wait...'
                        : 'Log In',
                    onTap: () {
                      controller.login();
                    },
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Get.to(ForgetPassword());
                    },
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have a account?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.to(RegisterScreen());
                },
                child: Text(
                  'Create Account!',
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
