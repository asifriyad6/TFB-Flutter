import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/widget/appbar_bottomborder.dart';

import '../../controller/tour_controller.dart';
import '../../navigation_menu.dart';
import '../../widget/tour_card.dart';
import '../SingleTour/single_tour.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  final tourController = Get.put(TourController());
  final navController = Get.put(NavigationController());
  @override
  void initState() {
    super.initState();
    tourController.getAllTour();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: const AppbarBottomborder(),
        title: const Text(
          'Tour Packages',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              navController.selectedIndex.value = 0;
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'All Tour Packages',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () {
                if (tourController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (tourController.tours.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: const Text(
                        textAlign: TextAlign.center,
                        'No tours found in this location. Please check back later.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: tourController.tours.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final tour = tourController.tours[index];
                      return TourCard(
                        image: tour.thumbnail!,
                        title: tour.title!,
                        city: tour.city!,
                        location: tour.location!,
                        schedule: tour.firstSchedule!,
                        duration: tour.duration!,
                        base_price: double.parse(tour.priceAdult!),
                        discounted_price: double.parse(
                          tour.discountedPrice.toString(),
                        ),
                        onTap: () {
                          tourController.tour.value = tour;
                          Get.to(const SingleTour());
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
