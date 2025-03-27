import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/models/location_model.dart';

import '../../utils/config.dart';
import '../../widget/section_title.dart';
import '../../widget/tour_card.dart';
import '../../widget/tour_card_1.dart';
import '../SingleHouseboat/single_houseboat.dart';
import '../SingleTour/single_tour.dart';

class LocationWise extends StatefulWidget {
  final LocationModel location;
  const LocationWise({super.key, required this.location});

  @override
  State<LocationWise> createState() => _LocationWiseState();
}

class _LocationWiseState extends State<LocationWise> {
  final houseboatController = Get.put(HouseboatController());
  final tourController = Get.put(TourController());
  @override
  void initState() {
    super.initState();
    houseboatController.getHouseboatByLocation(widget.location.slug!);
    tourController.getTourByLocation(widget.location.slug!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: height * .44,
              fit: BoxFit.cover,
              imageUrl:
                  '${AppConfig.locationImage}/${widget.location.thumbnail}',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error), // Error icon
            ),
            SafeArea(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .3),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Tours & Houseboats in ${widget.location.name!}',
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SectionTitle(title: 'Tours'),
                        SizedBox(height: 20),
                        Obx(
                          () {
                            if (tourController.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (tourController.tours.isEmpty) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                child: Text(
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
                        SizedBox(
                          height: 20,
                        ),
                        SectionTitle(
                          title: 'Houseboats',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() {
                          if (houseboatController.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (houseboatController.houseboats.isEmpty) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  'No houseboats found in this location. Please check back later.'),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: houseboatController.houseboats.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                final houseboat =
                                    houseboatController.houseboats[index];
                                return TourCard1(
                                  title: houseboat.title!,
                                  thumbnail: houseboat.thumbnail!,
                                  schedule: houseboat.firstSchedule,
                                  location:
                                      '${houseboat.location}, ${houseboat.city}',
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
                                    houseboatController.houseboat.value =
                                        houseboat;
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
                      ],
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
