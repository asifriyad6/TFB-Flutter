import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/utils/config.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tfb/views/SingleHouseboat/houseboat_dateSelect.dart';
import 'package:tfb/widget/highlights.dart';

import '../../utils/colors.dart';
import '../SingleTour/tour_summary.dart';

class SingleHouseboat extends StatefulWidget {
  const SingleHouseboat({super.key});

  @override
  State<SingleHouseboat> createState() => _SingleHouseboatState();
}

class _SingleHouseboatState extends State<SingleHouseboat> {
  final controller = Get.put(HouseboatController());
  @override
  void initState() {
    super.initState();
    controller.getHouseboatDetails();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
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
                            '${AppConfig.houseboatImage}/${controller.houseboat.value.thumbnail}',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error), // Error icon
                      ),
                      SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(height: height * .3),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${controller.houseboat.value.location}, ${controller.houseboat.value.city}',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      controller.houseboat.value.title!,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
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
                                                text: '3 Days 2 Nights',
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TourSummary(
                                                icon: Icons.people,
                                                title: 'Capacity',
                                                text: controller
                                                    .houseboatDetails
                                                    .value
                                                    .capacity
                                                    .toString(),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TourSummary(
                                                icon: Icons.person,
                                                title: 'Total Rooms',
                                                text: controller
                                                    .houseboatDetails
                                                    .value
                                                    .totalRooms
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
                                                TourSummary(
                                                  icon: Icons.calendar_month,
                                                  title: 'Tour Date',
                                                  text: '24-01-2025',
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TourSummary(
                                                  icon: Icons.hiking,
                                                  title: 'Tour Type',
                                                  text: 'Adventure',
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TourSummary(
                                                  icon: Icons.train,
                                                  title: 'Pickup From',
                                                  text: controller.houseboat
                                                      .value.location!,
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    HtmlWidget(
                                      '${controller.houseboatDetails.value.description}',
                                      textStyle: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(.1),
                                    ),
                                    SizedBox(
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Highlights(
                                        highlights: controller.houseboatDetails
                                            .value.visibleSpots!
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
                                            .houseboatDetails.value.includes!
                                            .split('\r,')!,
                                        title: 'Includes',
                                        icon: Icons.check,
                                        iconColor: AppColor.primaryColor),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Highlights(
                                        highlights: controller
                                            .houseboatDetails.value.excludes!
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
                                      'Gallery Images',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CarouselSlider.builder(
                                      itemCount: controller.houseboatDetails
                                          .value.images!.length,
                                      itemBuilder: (context, index, realIndex) {
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
                                                  '${AppConfig.houseboatImage}/${controller.houseboatDetails.value.images![index].imageName}',
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
          height: 80,
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
                    Text('Starting from'),
                    Row(
                      children: [
                        Text(
                          '৳ ${double.parse(controller.houseboat.value.discountedPrice.toString())}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        double.parse(controller.houseboat.value.startingPrice
                                    .toString()) >
                                double.parse(controller
                                    .houseboat.value.discountedPrice
                                    .toString())
                            ? Text(
                                '৳ ${double.parse(controller.houseboat.value.startingPrice.toString())}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return HouseboatDateSelect();
                      });
                },
                child: Container(
                  width: width * .35,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
