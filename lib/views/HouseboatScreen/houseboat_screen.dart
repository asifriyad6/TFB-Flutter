import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/views/HouseboatScreen/shimmer/houseboat_shimmer.dart';
import 'package:tfb/widget/appbar_bottomborder.dart';

import '../../controller/houseboat_controller.dart';
import '../../navigation_menu.dart';
import '../../widget/tour_card_1.dart';
import '../SingleHouseboat/single_houseboat.dart';

class HouseboatScreen extends StatefulWidget {
  const HouseboatScreen({super.key});

  @override
  State<HouseboatScreen> createState() => _HouseboatScreenState();
}

class _HouseboatScreenState extends State<HouseboatScreen> {
  final houseboatController = Get.put(HouseboatController());
  final navController = Get.put(NavigationController());
  @override
  void initState() {
    super.initState();
    houseboatController.getAllHouseboat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: const AppbarBottomborder(),
        title: const Text(
          'Houseboat Packages',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              navController.selectedIndex.value = 0;
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await houseboatController.getAllHouseboat();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'All Houseboat Packages',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  if (houseboatController.isLoading.value) {
                    return const HouseboatShimmer();
                  } else if (houseboatController.houseboats.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      child: const Text(
                          textAlign: TextAlign.center,
                          'No houseboats found. Please check back later.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: houseboatController.houseboats.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        final houseboat = houseboatController.houseboats[index];
                        return TourCard1(
                          title: houseboat.title!,
                          thumbnail: houseboat.thumbnail!,
                          schedule: houseboat.firstSchedule,
                          location: '${houseboat.location}, ${houseboat.city}',
                          capacity: houseboat.capacity!,
                          destination:
                              '${houseboat.city}, ${houseboat.country}',
                          starting_price: double.tryParse(
                                  houseboat.startingPrice ?? '0.0') ??
                              0.0,
                          discounted_price: double.tryParse(
                                  houseboat.discountedPrice ?? '0.0') ??
                              0.0,
                          onTap: () {
                            houseboatController.houseboat.value = houseboat;
                            Get.to(const SingleHouseboat());
                          },
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
