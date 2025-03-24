import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/widget/custom_button.dart';
import '../../utils/colors.dart';

class SaveCustomer extends StatelessWidget {
  const SaveCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Obx(
                () {
                  return controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: AppColor.primaryColor,
                                hintText: 'Your Name',
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                              onChanged: (value) {
                                controller.userModel.value.name = value;
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
                                controller.validatePassword(value);
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              obscureText: controller.passViewConfirm.value,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: AppColor.primaryColor,
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.passViewConfirm.value =
                                        !controller.passViewConfirm.value;
                                  },
                                  icon: Icon(controller.passViewConfirm.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              onChanged: (value) {
                                controller.confirmPassword.value = value;
                                controller.isPasswordMatch();
                              },
                            ),
                            SizedBox(height: 5),
                            controller.confirmPassword.value.isEmpty
                                ? SizedBox()
                                : Text(
                                    controller.isPasswordMatch()
                                        ? 'Password Matched'
                                        : 'Password Not Matched!',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller.isPasswordMatch()
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                            SizedBox(height: 30),
                            CustomButton(
                              title: 'Create Account',
                              onTap: () {
                                if (controller.isPasswordMatch() &&
                                    controller.isPasswordValid()) {
                                  controller.register();
                                } else {
                                  Get.snackbar('Error',
                                      'Password criteria not fulfilled');
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  controller.passLengthValid.value
                                      ? Icons.check
                                      : Icons.close_outlined,
                                  color: controller.passLengthValid.value
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Minimum 8 characters',
                                  style: TextStyle(
                                      color: controller.passLengthValid.value
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  controller.passHasLetter.value
                                      ? Icons.check
                                      : Icons.close_outlined,
                                  color: controller.passHasLetter.value
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'At least one letter',
                                  style: TextStyle(
                                      color: controller.passHasLetter.value
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  controller.passHasNumber.value
                                      ? Icons.check
                                      : Icons.close_outlined,
                                  color: controller.passHasNumber.value
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'At least one number',
                                  style: TextStyle(
                                      color: controller.passHasNumber.value
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  controller.isPasswordValid()
                                      ? Icons.check
                                      : Icons.close_outlined,
                                  color: controller.isPasswordValid()
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Password is valid',
                                  style: TextStyle(
                                      color: controller.isPasswordValid()
                                          ? Colors.green
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ))),
    );
  }
}
