import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/auth_controller.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/utils/config.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tfb/views/AccountScreen/ContactUs/contact_us.dart';
import 'package:tfb/views/SingleHouseboat/houseboat_dateSelect.dart';
import 'package:tfb/widget/custom_button.dart';
import 'package:tfb/widget/highlights.dart';

import '../../controller/wishlist_controller.dart';
import '../../utils/colors.dart';
import '../SingleTour/tour_summary.dart';

class SingleHouseboat extends StatefulWidget {
  final String houseboatSlug;
  const SingleHouseboat({super.key, required this.houseboatSlug});

  @override
  State<SingleHouseboat> createState() => _SingleHouseboatState();
}

class _SingleHouseboatState extends State<SingleHouseboat> {
  final controller = Get.find<HouseboatController>();
  final wishlistController = Get.put(WishlistController());
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authController.isAuthenticated.value) {
        wishlistController.checkWishlist(
            null, controller.houseboatDetails.value.id);
      }
      controller.getHouseboatDetails(widget.houseboatSlug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.houseboatDetails.value.title == null) {
            return const Text("Loading title...");
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    height: height * .5,
                    fit: BoxFit.cover,
                    imageUrl:
                        '${AppConfig.houseboatImage}/${controller.houseboatDetails.value.thumbnail}',
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Error icon
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: Obx(
                                () => IconButton(
                                  onPressed: () {
                                    if (authController.isAuthenticated.value) {
                                      if (!wishlistController
                                          .isWishlist.value) {
                                        wishlistController
                                                .wishlist.value.houseboatId =
                                            controller
                                                .houseboatDetails.value.id;
                                        wishlistController.addToWishlist();
                                      } else {
                                        wishlistController.removeFromWishlist(
                                            null,
                                            controller
                                                .houseboatDetails.value.id);
                                      }
                                    } else {
                                      Get.snackbar('Error',
                                          'You must logged in to add this houseboat to your wishlist');
                                    }
                                  },
                                  icon: Icon(
                                    wishlistController.isWishlist.value
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: wishlistController.isWishlist.value
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * .28),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${controller.houseboatDetails.value.location?.name}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  controller.houseboatDetails.value.title!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: width * .5,
                                      child: Column(
                                        children: [
                                          const TourSummary(
                                            icon: Icons.timer_outlined,
                                            title: 'Duration',
                                            text: '3 Days 2 Nights',
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TourSummary(
                                            icon: Icons.people,
                                            title: 'Capacity',
                                            text: controller
                                                .houseboatDetails.value.capacity
                                                .toString(),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TourSummary(
                                            icon: Icons.person,
                                            title: 'Total Rooms',
                                            text: controller.houseboatDetails
                                                .value.totalRooms
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: width * .5,
                                        child: Column(
                                          children: [
                                            const TourSummary(
                                              icon: Icons.calendar_month,
                                              title: 'Tour Date',
                                              text: '24-01-2025',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const TourSummary(
                                              icon: Icons.hiking,
                                              title: 'Tour Type',
                                              text: 'Adventure',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TourSummary(
                                              icon: Icons.train,
                                              title: 'Pickup From',
                                              text: controller.houseboatDetails
                                                  .value.location!.name!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                HtmlWidget(
                                  '${controller.houseboatDetails.value.description}',
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Highlights(
                                  highlights: controller
                                      .houseboatDetails.value.highlights!
                                      .split('\r,'),
                                  title: 'Highlights',
                                  icon: Icons.check_circle_outline_rounded,
                                  iconColor: Colors.blue,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Highlights(
                                    highlights: controller
                                        .houseboatDetails.value.visibleSpots!
                                        .split('\r,'),
                                    title: 'Visible Spots',
                                    icon: Icons.check_box_outlined,
                                    iconColor: Colors.blueAccent),
                                const SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                Highlights(
                                    highlights: controller
                                        .houseboatDetails.value.includes!
                                        .split('\r,'),
                                    title: 'Includes',
                                    icon: Icons.check,
                                    iconColor: AppColor.primaryColor),
                                const SizedBox(
                                  height: 15,
                                ),
                                Highlights(
                                    highlights: controller
                                        .houseboatDetails.value.excludes!
                                        .split('\r,'),
                                    title: 'Excludes',
                                    icon: Icons.close,
                                    iconColor: Colors.red),
                                const SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                const Text(
                                  'Gallery Images',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                controller.houseboatDetails.value.images!
                                            .length >
                                        0
                                    ? CarouselSlider.builder(
                                        itemCount: controller.houseboatDetails
                                            .value.images!.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          return Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    '${AppConfig.houseboatImage}/${controller.houseboatDetails.value.images![index].imageName}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    const Icon(Icons
                                                        .error), // Error icon
                                              ),
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: height * .2,
                                          aspectRatio: 16 / 9,
                                          viewportFraction: 0.8,
                                          initialPage: 0,
                                          enableInfiniteScroll: true,
                                          reverse: false,
                                          autoPlay: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enlargeCenterPage: false,
                                          enlargeFactor: 0.3,
                                          scrollDirection: Axis.horizontal,
                                        ),
                                      )
                                    : const Text(
                                        'No Gallary Images Found!',
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: BottomAppBar(
          height: 70,
          color: Colors.white,
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Starting from',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            '৳${double.parse(controller.houseboatDetails.value.discountedPrice ?? '0.0')}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          double.parse(controller.houseboatDetails.value
                                          .startingPrice ??
                                      '0.0') >
                                  double.parse(controller.houseboatDetails.value
                                          .discountedPrice ??
                                      '0.0')
                              ? Text(
                                  '৳ ${double.parse(controller.houseboatDetails.value.startingPrice.toString())}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () {
                  if (controller.scheduleDate.isEmpty) {
                    return CustomButton(
                      fullWidth: width * .5,
                      color: AppColor.tertiaryColor,
                      title: "Contact Us",
                      onTap: () {
                        Get.to(const ContactUs());
                      },
                    );
                  } else {
                    return CustomButton(
                      title: 'Book Now',
                      fullWidth: width * .36,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return const HouseboatDateSelect();
                            });
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
