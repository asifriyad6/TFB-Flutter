import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/BookingScreen/booking_all.dart';
import 'package:tfb/views/AuthScreen/login_screen.dart';
import '../../../navigation_menu.dart';

class AppDrawer extends StatelessWidget {
  final String appVersion;

  const AppDrawer({Key? key, required this.appVersion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final navController = Get.put(NavigationController());
    return Theme(
        data: Theme.of(context).copyWith(
          drawerTheme: const DrawerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Removes border radius
            ),
          ),
        ),
        child: Obx(
          () {
            return Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(0)),
                      child: authController.isAuthenticated.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://media.licdn.com/dms/image/v2/C5103AQE_FlEO3vSvVA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1535960348058?e=2147483647&v=beta&t=uQEg4_Sun_SKdeEkBS-tO-KJvZJd-YMdrjv7aFXS3LY',
                                  ),
                                  maxRadius: 40,
                                ),
                                SizedBox(height: 10),
                                Text(authController.userModel.value.name!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            )
                          : InkWell(
                              onTap: () => Get.to(LoginScreen()),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    minRadius: 40,
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello, Traveller',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Log In')
                                    ],
                                  )
                                ],
                              ),
                            )),

                  // Drawer Items
                  _buildDrawerItem(
                    Icons.home,
                    'Home',
                    () => Get.back(),
                  ),
                  _buildDrawerItem(
                    Icons.airplane_ticket,
                    'Bookings',
                    () => Get.to(const AllBookings(),
                        transition: Transition.fadeIn),
                  ),
                  _buildDrawerItem(
                    Icons.tour,
                    'Tours',
                    () {
                      navController.selectedIndex.value = 1;
                      Get.back();
                    },
                  ),
                  _buildDrawerItem(
                    Icons.houseboat,
                    'Houseboat',
                    () {
                      navController.selectedIndex.value = 2;
                      Get.back();
                    },
                  ),
                  _buildDrawerItem(
                    Icons.person,
                    "Account",
                    () {
                      navController.selectedIndex.value = 3;
                      Get.back();
                    },
                  ),
                  _buildDrawerItem(
                    Icons.description,
                    'Terms & Conditions',
                    () {},
                  ),
                  _buildDrawerItem(
                    Icons.call,
                    'Contact Us',
                    () {},
                  ),
                  _buildDrawerItem(Icons.logout, "Logout", () {
                    authController.logout();
                  }),

                  const Spacer(),

                  // App Version at Bottom
                  Column(
                    children: [
                      Image.asset(
                        'assets/tfb_logo.png',
                        width: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('App Version: $appVersion',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryColor),
      title: Text(title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      onTap: onTap,
    );
  }
}
