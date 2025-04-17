import 'package:flutter/material.dart';
import 'package:tfb/utils/text.dart';
import 'package:tfb/widget/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:tfb/widget/custom_button.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
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
                          enabled: false,
                          controller: controller.userPhone,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            labelText: 'Phone',
                            prefixIcon: const Icon(Icons.smartphone),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.phone = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controller.userName,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your Name',
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.person),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.name = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.userEmail,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your Email',
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.email = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controller.userDob,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your Date of Birth',
                            labelText: 'Date of Birth',
                            prefixIcon: const Icon(Icons.calendar_month),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950, 1, 1),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              controller.setSelectedDob(pickedDate);
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controller.userProfession,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your Profession',
                            labelText: 'Profession',
                            prefixIcon: const Icon(Icons.person_pin_rounded),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.profession = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controller.userAddress,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your Address',
                            labelText: 'Address',
                            prefixIcon: const Icon(Icons.location_on),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.address = value;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controller.userCity,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusColor: AppColor.primaryColor,
                            hintText: 'Your City',
                            labelText: 'City',
                            prefixIcon: const Icon(Icons.location_city),
                          ),
                          onChanged: (value) {
                            controller.userModel.value.city = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          title: 'Save Details',
                          onTap: () {
                            controller.updateProfile();
                          },
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
