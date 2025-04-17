import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/widget/custom_button.dart';

class OtpVerify extends StatelessWidget {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final TextEditingController otpController = TextEditingController();
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter Your\nOTP Verification Code',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'We just send you an one time passcode to this phone number ${controller.userModel.value.phone ?? 0}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30),
              Pinput(
                controller: otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: width * .14,
                  height: 60,
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.primaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                onCompleted: (otp) {
                  controller.userModel.value.otp = otp;
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      return InkWell(
                        onTap: controller.countdown.value == 0
                            ? () {
                                controller.resetTimer();
                                controller.sendOtp(true);
                              }
                            : null,
                        child: Container(
                          width: width * .45,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.countdown.value == 0
                                ? AppColor.primaryColor
                                : AppColor.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Resend (${controller.countdown.value ~/ 60}:${(controller.countdown.value % 60).toString().padLeft(2, '0')})',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: width * .45,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Change Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                title: 'Verify OTP',
                onTap: () {
                  controller.verifyOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
