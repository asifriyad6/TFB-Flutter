import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/controller/home_controller.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/utils/config.dart';
import 'package:tfb/views/HomeScreen/shimmer/carousel_shimmer.dart';
import 'package:tfb/views/HomeScreen/shimmer/location_shimmer.dart';
import 'package:tfb/views/HomeScreen/widget/carousel_banner.dart';
import 'package:tfb/views/HomeScreen/widget/location_widget.dart';
import 'package:tfb/views/HouseboatScreen/shimmer/houseboat_shimmer.dart';
import 'package:tfb/views/SingleHouseboat/single_houseboat.dart';
import 'package:tfb/views/SingleTour/single_tour.dart';
import 'package:tfb/views/TourScreen/shimmer/tour_card.dart';
import 'package:tfb/widget/section_title.dart';
import 'package:tfb/widget/tour_card.dart';
import 'package:tfb/widget/tour_card_1.dart';
import '../../navigation_menu.dart';
import '../SearchScreen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final controller = Get.put(HomeController());
    final navController = Get.put(NavigationController());
    final houseboatController = Get.put(HouseboatController());
    final tourController = Get.put(TourController());
    final authController = Get.put(AuthController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshPage();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/saint_martin.webp',
                width: double.infinity,
                height: height * .3,
                fit: BoxFit.cover,
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        Obx(
                          () => Text(
                            authController.isAuthenticated.value
                                ? 'Hello, ${authController.userModel.value.name}'
                                : 'Hello, Traveller',
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .17,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => SearchScreen(),
                              transition: Transition.fadeIn);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 8),
                              Text("Where you want to plan your next trip?",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () {
                        return controller.carouselLoading.value
                            ? const CarouselShimmer()
                            : CarouselBanner(banner: controller.banner);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SectionTitle(
                      title: 'Top Locations',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.locationLoading.value
                          ? const LocationShimmer()
                          : const LocationWidget(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SectionTitle(
                      title: 'Upcoming Houseboat',
                      onTap: () {
                        navController.selectedIndex.value = 2;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const HouseboatShimmer();
                      } else if (controller.houseboats.isEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: Text(
                              textAlign: TextAlign.center,
                              'No houseboats are scheduled at the moment. Please check back later.'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.houseboats.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final houseboat = controller.houseboats[index];
                            return TourCard1(
                              title: houseboat.title!,
                              thumbnail: houseboat.thumbnail!,
                              schedule: houseboat.firstSchedule,
                              location:
                                  '${houseboat.location}, ${houseboat.city}',
                              capacity: houseboat.capacity!,
                              destination:
                                  '${houseboat.city}, ${houseboat.country}',
                              starting_price:
                                  double.parse(houseboat.startingPrice!),
                              discounted_price:
                                  double.parse(houseboat.discountedPrice!),
                              onTap: () {
                                houseboatController.houseboat.value = houseboat;
                                Get.to(const SingleHouseboat());
                              },
                            );
                          },
                        );
                      }
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    SectionTitle(
                      title: 'Upcoming Tours',
                      onTap: () {
                        navController.selectedIndex.value = 1;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () {
                        if (controller.tourLoading.value) {
                          return const TourCardShimmer();
                        } else if (controller.tours.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            child: const Text(
                                textAlign: TextAlign.center,
                                'No tours are scheduled at the moment. Please check back later.'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: controller.tours.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              final tour = controller.tours[index];
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
