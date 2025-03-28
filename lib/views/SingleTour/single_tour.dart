import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/SingleTour/tour_summary.dart';
import 'package:tfb/views/SingleTour/widget/booking_module.dart';
import 'package:tfb/views/SingleTour/widget/itinerary_expansion.dart';
import 'package:tfb/widget/custom_button.dart';
import '../../utils/config.dart';
import '../../widget/highlights.dart';

class SingleTour extends StatefulWidget {
  const SingleTour({
    super.key,
  });

  @override
  State<SingleTour> createState() => _SingleTourState();
}

class _SingleTourState extends State<SingleTour> {
  final controller = Get.find<TourController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTourDetails();
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
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Per Person',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '৳ ${controller.tour.value.discountedPrice}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        double.parse(controller.tour.value.discountedPrice
                                        ?.toString() ??
                                    '0') !=
                                double.parse(controller.tour.value.priceAdult
                                        ?.toString() ??
                                    '0')
                            ? Text(
                                '৳ ${controller.tour.value.priceAdult}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              CustomButton(
                title: 'Book Now',
                fullWidth: 180,
                onTap: () {
                  Get.bottomSheet(
                    DatePickerBottomSheet(),
                    isScrollControlled: true,
                  );
                },
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () {
          return controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: height * .5,
                        fit: BoxFit.cover,
                        imageUrl:
                            '${AppConfig.tourImage}/${controller.tourDetails.value.thumbnail}',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error), // Error icon
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
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
                                    icon: Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.favorite_outline),
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
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${controller.tour.value.city!} , ${controller.tour.value.location!}',
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      controller.tour.value.title!,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
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
                                                text: controller
                                                    .tour.value.duration!,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TourSummary(
                                                icon: Icons.people,
                                                title: 'Group Size',
                                                text:
                                                    '${controller.tour.value.maxPeople} Persons',
                                              ),
                                              SizedBox(
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
                                                  text:
                                                      '${DateFormat('yyyy-MM-dd').format(controller.tour.value.firstSchedule!)}',
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TourSummary(
                                                  icon: Icons.hiking,
                                                  title: 'Tour Type',
                                                  text: controller
                                                      .tourDetails.value.type!,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TourSummary(
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(.1),
                                    ),
                                    HtmlWidget(
                                      '${controller.tourDetails.value.description}',
                                      textStyle: TextStyle(
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Highlights(
                                        highlights: controller
                                            .tourDetails.value.visibleSpots!
                                            .split('\r,'),
                                        title: 'Visible Spots',
                                        icon: Icons.check_box_outlined,
                                        iconColor: Colors.blueAccent),
                                    SizedBox(
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Highlights(
                                        highlights: controller
                                            .tourDetails.value.excludes!
                                            .split('\r,')!,
                                        title: 'Excludes',
                                        icon: Icons.close,
                                        iconColor: Colors.red),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(.1),
                                    ),
                                    Text(
                                      'Itinerary',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      itemCount: controller.tourDetails.value
                                          .itineraries?.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (context, index) {
                                        final itinerary = controller.tourDetails
                                            .value.itineraries![index];
                                        return ItineraryExpansion(
                                          itineraryDay:
                                              itinerary.itineraryName!,
                                          itineraryName:
                                              itinerary.itineraryDetails!,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(.1),
                                    ),
                                    Text(
                                      'Gallery Images',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
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
                                          margin: EdgeInsets.symmetric(
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
                                                  '${AppConfig.tourImage}/${image.imageName}',
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons
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
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: false,
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ),
                                    SizedBox(
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
        },
      ),
    );
  }
}
