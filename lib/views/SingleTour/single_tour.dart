import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/controller/wishlist_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/AccountScreen/ContactUs/contact_us.dart';
import 'package:tfb/views/SingleTour/tour_summary.dart';
import 'package:tfb/views/SingleTour/widget/booking_module.dart';
import 'package:tfb/views/SingleTour/widget/itinerary_expansion.dart';
import 'package:tfb/widget/custom_button.dart';
import '../../controller/auth_controller.dart';
import '../../utils/config.dart';
import '../../widget/highlights.dart';

class SingleTour extends StatefulWidget {
  final String slug;
  const SingleTour({
    super.key,
    required this.slug,
  });

  @override
  State<SingleTour> createState() => _SingleTourState();
}

class _SingleTourState extends State<SingleTour> {
  final controller = Get.find<TourController>();
  final wishlistController = Get.put(WishlistController());
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authController.isAuthenticated.value) {
        wishlistController.checkWishlist(controller.tour.value.id, null);
      }
      controller.getTourDetails(widget.slug);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Per Person',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            '৳ ${controller.tourDetails.value.discountedPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          double.parse(controller
                                          .tourDetails.value.discountedPrice
                                          ?.toString() ??
                                      '0') !=
                                  double.parse(controller
                                          .tourDetails.value.priceAdult
                                          ?.toString() ??
                                      '0')
                              ? Text(
                                  '৳ ${controller.tourDetails.value.priceAdult}',
                                  style: const TextStyle(
                                    fontSize: 14,
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
                      fullWidth: width * .5,
                      onTap: () {
                        Get.bottomSheet(
                          DatePickerBottomSheet(),
                          isScrollControlled: true,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.tourDetails.value.title == null) {
            return const Text("Loading Details...");
          } else {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    height: height * .5,
                    fit: BoxFit.cover,
                    imageUrl:
                        '${AppConfig.tourImage}/${controller.tourDetails.value.thumbnail}',
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
                                icon: const Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                              child: Obx(
                                () {
                                  return IconButton(
                                    onPressed: () {
                                      if (authController
                                          .isAuthenticated.value) {
                                        if (!wishlistController
                                            .isWishlist.value) {
                                          wishlistController
                                                  .wishlist.value.tourId =
                                              controller.tourDetails.value.id;
                                          wishlistController.addToWishlist();
                                        } else {
                                          wishlistController.removeFromWishlist(
                                              controller.tourDetails.value.id,
                                              null);
                                        }
                                      } else {
                                        Get.snackbar('Error',
                                            'You must logged in to add this tour to your wishlist');
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
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * .28),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      '${controller.tourDetails.value.location?.name} , ${controller.tourDetails.value.location?.city?.name}',
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  controller.tourDetails.value.title!,
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
                                          TourSummary(
                                            icon: Icons.timer_outlined,
                                            title: 'Duration',
                                            text: controller.tourDetails.value
                                                        .duration !=
                                                    null
                                                ? controller
                                                    .tourDetails.value.duration!
                                                : 'Flexible',
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TourSummary(
                                            icon: Icons.people,
                                            title: 'Group Size',
                                            text:
                                                '${controller.tourDetails.value.maxPeople} Persons',
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TourSummary(
                                            icon: Icons.person,
                                            title: 'Minimum Age',
                                            text:
                                                '${controller.tourDetails.value.childAge}+',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: width * .5,
                                        child: Column(
                                          children: [
                                            TourSummary(
                                              icon: Icons.calendar_month,
                                              title: 'Tour Date',
                                              text: controller.tourDetails.value
                                                          .firstSchedule !=
                                                      null
                                                  ? '${DateFormat('yyyy-MM-dd').format(controller.tourDetails.value.firstSchedule!)}'
                                                  : 'Flexible',
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TourSummary(
                                              icon: Icons.hiking,
                                              title: 'Tour Type',
                                              text: controller
                                                  .tourDetails.value.type!,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const TourSummary(
                                              icon: Icons.train,
                                              title: 'Pickup From',
                                              text: 'Dhaka',
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
                                HtmlWidget(
                                  '${controller.tourDetails.value.description}',
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                ),
                                Highlights(
                                  highlights: controller
                                      .tourDetails.value.highlights!
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
                                        .tourDetails.value.visibleSpots!
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
                                        .tourDetails.value.includes!
                                        .split('\r,')!,
                                    title: 'Includes',
                                    icon: Icons.check,
                                    iconColor: AppColor.primaryColor),
                                const SizedBox(
                                  height: 15,
                                ),
                                Highlights(
                                    highlights: controller
                                        .tourDetails.value.excludes!
                                        .split('\r,')!,
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
                                  'Itinerary',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                  itemCount: controller
                                      .tourDetails.value.itineraries?.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    final itinerary = controller
                                        .tourDetails.value.itineraries![index];
                                    return ItineraryExpansion(
                                      itineraryDay: itinerary.itineraryName!,
                                      itineraryName:
                                          itinerary.itineraryDetails!,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
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
                                CarouselSlider.builder(
                                  itemCount: controller
                                      .tourDetails.value.images!.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final image = controller
                                        .tourDetails.value.images![index];
                                    return Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              '${AppConfig.tourImage}/${image.imageName}',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                  Icons.error), // Error icon
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
    );
  }
}
