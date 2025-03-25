import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/account_screen.dart';
import 'package:tfb/views/HomeScreen/home_screen.dart';
import 'package:tfb/views/HomeScreen/widget/app_drawer.dart';
import 'package:tfb/views/HouseboatScreen/houseboat_screen.dart';
import 'package:tfb/views/TourScreen/tour_screen.dart';
import 'package:tfb/widget/custom_button.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          controller.selectedIndex.value = 0; // Go to Home screen
          return false;
        }
        return await _showExitConfirmation();
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: NavigationBar(
              backgroundColor: Colors.white,
              height: 80,
              elevation: 10,
              indicatorColor: Colors.transparent,
              shadowColor: Colors.black,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: [
                NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: Colors.black.withOpacity(.5),
                    ),
                    selectedIcon: Icon(Icons.home,
                        size: 30, color: AppColor.primaryColor),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(
                      Icons.tour_outlined,
                      size: 30,
                      color: Colors.black.withOpacity(.5),
                    ),
                    selectedIcon: Icon(Icons.tour,
                        size: 30, color: AppColor.primaryColor),
                    label: 'Tours'),
                NavigationDestination(
                    icon: Icon(
                      Icons.houseboat_outlined,
                      size: 30,
                      color: Colors.black.withOpacity(.5),
                    ),
                    selectedIcon: Icon(Icons.houseboat,
                        size: 30, color: AppColor.primaryColor),
                    label: 'Houseboat'),
                NavigationDestination(
                    icon: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Colors.black.withOpacity(.5),
                    ),
                    selectedIcon: Icon(Icons.person,
                        size: 30, color: AppColor.primaryColor),
                    label: 'Account')
              ],
            ),
          ),
        ),
        drawer: AppDrawer(appVersion: '1.0.1'),
        body: Obx(() => controller.screens[controller.selectedIndex.value]),
      ),
    );
  }

  Future<bool> _showExitConfirmation() async {
    bool? exit = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text(
            "Are you sure you want to exit?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          CustomButton(
              title: 'NO',
              fullWidth: 150,
              onTap: () => Get.back(result: false)),
          CustomButton(
              title: 'YES',
              fullWidth: 150,
              color: AppColor.tertiaryColor,
              onTap: () => Get.back(result: true)),
        ],
      ),
    );
    if (exit == true) {
      SystemNavigator.pop();
    }
    return exit ?? false;
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [
    HomeScreen(),
    TourScreen(),
    HouseboatScreen(),
    AccountScreen(),
  ];
}
