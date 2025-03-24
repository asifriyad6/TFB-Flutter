import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/navigation_menu.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/BookingScreen/booking_all.dart';
import 'package:tfb/views/AccountScreen/widgets/menu_widget.dart';
import 'package:tfb/views/AuthWrapper/auth_wrapper.dart';

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
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        navController.selectedIndex.value = 0;
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    title: Text('Account'),
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 160,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: ClipOval(
                                      child: CircleAvatar(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              'https://media.licdn.com/dms/image/v2/C5103AQE_FlEO3vSvVA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1535960348058?e=2147483647&v=beta&t=uQEg4_Sun_SKdeEkBS-tO-KJvZJd-YMdrjv7aFXS3LY',
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error), // Error icon
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
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text(
                                //'Asif Iqbal Riyad',
                                authController.userModel.value.name!,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(authController.userModel.value.phone!),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFFFA534),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '9740 Points',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 10,
                          color: AppColor.secondaryColor,
                        ),
                        SizedBox(height: 30),
                        AccountMenu(
                            icon: Icons.person,
                            title: 'Profile',
                            onTap: () {},
                            iconBg: Colors.blueAccent),
                        AccountMenu(
                            icon: Icons.list,
                            title: 'Bookings',
                            onTap: () {
                              Get.to(AllBookings());
                            },
                            iconBg: Colors.lightGreen),
                        AccountMenu(
                            icon: Icons.favorite_outline,
                            title: 'Wishlist',
                            onTap: () {},
                            iconBg: Colors.redAccent),
                        AccountMenu(
                            icon: Icons.lock_outline,
                            title: 'Change Password',
                            onTap: () {},
                            iconBg: Colors.orangeAccent),
                        AccountMenu(
                            icon: Icons.call,
                            title: 'Contact Us',
                            onTap: () {},
                            iconBg: Colors.purple),
                        AccountMenu(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              authController.logout();
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
