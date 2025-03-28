import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/controller/booking_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/BookingScreen/widgets/upcoming_bookings.dart';
import 'package:tfb/views/AuthWrapper/auth_wrapper.dart';

import '../../../navigation_menu.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  final controller = Get.put(BookingController());
  final authController = Get.put(AuthController());
  final navController = Get.put(NavigationController());
  @override
  void initState() {
    super.initState();
    controller.fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(child: Obx(
      () {
        return authController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      title: Text('All Bookings'),
                      bottom: TabBar(
                          indicatorColor: AppColor.primaryColor,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              child: Text('Upcoming'),
                            ),
                            Tab(
                              child: Text('Past'),
                            ),
                            Tab(
                              child: Text('Cancelled'),
                            ),
                          ]),
                    ),
                    body: Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : TabBarView(
                              children: [
                                UpcomingBookings(
                                    bookings:
                                        controller.upcomingBookings.value),
                                UpcomingBookings(
                                  bookings: controller.pastBookings.value,
                                ),
                                UpcomingBookings(
                                  bookings: controller.cancelledBookings.value,
                                ),
                              ],
                            ),
                    )),
              );
      },
    ));
  }
}
