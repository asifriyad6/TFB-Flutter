import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../utils/colors.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Password Reset',
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: controller.passView.value,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            labelText: 'New Password',
                            prefixIcon: const Icon(Icons.password),
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
                        const SizedBox(height: 20),
                        TextFormField(
                          obscureText: controller.passViewConfirm.value,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.password),
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
                        const SizedBox(height: 5),
                        controller.confirmPassword.value.isEmpty
                            ? const SizedBox()
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
                        const SizedBox(height: 30),
                        CustomButton(
                          title: 'Reset Password',
                          onTap: () {
                            if (controller.isPasswordMatch() &&
                                controller.isPasswordValid()) {
                              controller.resetPassword();
                            } else {
                              Get.snackbar(
                                  'Error', 'Password criteria not fulfilled');
                            }
                          },
                        ),
                        const SizedBox(height: 20),
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
                            const SizedBox(width: 8),
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
                            const SizedBox(width: 8),
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
                            const SizedBox(width: 8),
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
                            const SizedBox(width: 8),
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
                    ),
                  );
          },
        ),
      ),
    );
  }
}
