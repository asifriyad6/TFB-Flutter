import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/navigation_menu.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/utils/config.dart';
import 'package:tfb/views/AccountScreen/BookingScreen/booking_all.dart';
import 'package:tfb/views/AccountScreen/ChangePassword/change_password.dart';
import 'package:tfb/views/AccountScreen/ContactUs/contact_us.dart';
import 'package:tfb/views/AccountScreen/ProfileScreen/profile_screen.dart';
import 'package:tfb/views/AccountScreen/WishlistScreen/wishlist_screen.dart';
import 'package:tfb/views/AccountScreen/widgets/menu_widget.dart';
import 'package:tfb/views/AuthWrapper/auth_wrapper.dart';

import '../../widget/custom_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final navController = Get.put(NavigationController());
    return AuthWrapper(
      child: Obx(
        () {
          return authController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        navController.selectedIndex.value = 0;
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: const Text(
                      'Account',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () {
                                  return authController.isUploading.value
                                      ? CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                          padding: const EdgeInsets.all(52),
                                        )
                                      : Stack(
                                          children: [
                                            Container(
                                              width: 160,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ClipOval(
                                                child: CircleAvatar(
                                                  child: CachedNetworkImage(
                                                    width: 160,
                                                    height: 160,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        '${AppConfig.profileImage}/${authController.profileImageUrl}',
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons
                                                            .error), // Error icon
                                                  ),
                                                  minRadius: 70,
                                                  maxRadius: 70,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 80,
                                              right: -8,
                                              child: Container(
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    authController.pickImage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                },
                              ),
                              const SizedBox(height: 15),
                              Text(
                                //'Asif Iqbal Riyad',
                                authController.userModel.value.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(authController.userModel.value.phone!),
                              const SizedBox(height: 10),
                              authController.userModel.value.points != null
                                  ? Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: AppColor.secondaryColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFA534),
                                            size: 18,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${authController.userModel.value.points ?? '0'} Points',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 10,
                          color: AppColor.secondaryColor,
                        ),
                        const SizedBox(height: 30),
                        AccountMenu(
                            icon: Icons.person,
                            title: 'Profile',
                            onTap: () {
                              Get.to(const ProfileScreen());
                            },
                            iconBg: Colors.blueAccent),
                        AccountMenu(
                            icon: Icons.list,
                            title: 'Bookings',
                            onTap: () {
                              Get.to(const AllBookings());
                            },
                            iconBg: Colors.lightGreen),
                        AccountMenu(
                            icon: Icons.favorite_outline,
                            title: 'Wishlist',
                            onTap: () {
                              Get.to(const WishlistScreen());
                            },
                            iconBg: Colors.redAccent),
                        AccountMenu(
                            icon: Icons.lock_outline,
                            title: 'Change Password',
                            onTap: () {
                              Get.to(const ChangePassword());
                            },
                            iconBg: Colors.orangeAccent),
                        AccountMenu(
                            icon: Icons.call,
                            title: 'Contact Us',
                            onTap: () {
                              Get.to(const ContactUs());
                            },
                            iconBg: Colors.purple),
                        AccountMenu(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              Get.dialog(AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                backgroundColor: Colors.white,
                                content: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Text(
                                    "Are you sure you want to logout?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                actions: [
                                  CustomButton(
                                      title: 'NO',
                                      onTap: () => Get.back(result: false)),
                                  const SizedBox(height: 10),
                                  CustomButton(
                                      title: 'YES',
                                      color: AppColor.tertiaryColor,
                                      onTap: () => authController.logout()),
                                ],
                              ));
                            },
                            iconBg: Colors.black),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
