import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/views/SingleHouseboat/houseboat_booking_details.dart';
import 'package:tfb/views/SingleHouseboat/widget/select_cabin_dialog.dart';
import 'package:tfb/widget/custom_button.dart';

import '../../controller/houseboat_controller.dart';
import '../../utils/config.dart';
import '../../widget/houseboat_shape.dart';

class BoatLayoutPage extends StatefulWidget {
  const BoatLayoutPage({super.key});

  @override
  State<BoatLayoutPage> createState() => _BoatLayoutPageState();
}

class _BoatLayoutPageState extends State<BoatLayoutPage> {
  final controller = Get.put(HouseboatController());
  @override
  void initState() {
    super.initState();
    controller.getHouseboatCabins();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Obx(
        () {
          if (controller.isCabinLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.houseboatCabins.isEmpty) {
            return const Center(child: Text('No cabins available'));
          }
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: height * .4,
                  decoration: BoxDecoration(
                      color: Color(0xFFA0E7E5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(
                          30,
                        ),
                      )),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.only(
                //     bottomRight: Radius.circular(30),
                //     bottomLeft: Radius.circular(30),
                //   ),
                //   child: CachedNetworkImage(
                //     width: double.infinity,
                //     height: height * .4,
                //     fit: BoxFit.cover,
                //     imageUrl:
                //         '${AppConfig.houseboatImage}/${controller.houseboat.value.thumbnail}',
                //     placeholder: (context, url) =>
                //         Center(child: CircularProgressIndicator()),
                //     errorWidget: (context, url, error) =>
                //         Icon(Icons.error), // Error icon
                //   ),
                // ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        height: height * .74,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double boatWidth = constraints.maxWidth;
                            double boatHeight = constraints.maxHeight;
                            double cellWidth = boatWidth * .475;
                            double cellHeight = boatHeight * .155;
                            return Stack(
                              children: [
                                CustomPaint(
                                  size: Size(boatWidth, boatHeight),
                                  painter: BoatShapePainter(),
                                ),
                                ...controller.houseboatCabins.map((cabin) {
                                  double leftPosition =
                                      (cabin.colPosition! - 0.87) * cellWidth;
                                  double topPosition =
                                      (cabin.rowPosition! + 0.30) * cellHeight;
                                  return Positioned(
                                    left: leftPosition,
                                    top: topPosition,
                                    child: GestureDetector(onTap: () {
                                      if (cabin.isAvailable == 0) {
                                        Get.snackbar('Info',
                                            'This Cabin is Unavailable!');
                                      } else if (cabin.isBooked!) {
                                        Get.snackbar('Info',
                                            'This Cabin is already booked!');
                                      } else if (controller.selectedCabins.any(
                                          (selected) =>
                                              selected.cabinId == cabin.id)) {
                                        controller.selectCabin(cabin.id!);
                                      } else {
                                        Future.microtask(() {
                                          Get.dialog(
                                              CabinDetailsDialog(cabin: cabin));
                                        });
                                      }
                                    }, child: Obx(
                                      () {
                                        bool isSelected = controller
                                            .selectedCabins
                                            .any((selected) =>
                                                selected.cabinId == cabin.id);
                                        return Container(
                                          width: boatWidth * 0.4,
                                          height: boatHeight * 0.14,
                                          decoration: BoxDecoration(
                                            color: cabin.isBooked!
                                                ? Colors.red
                                                : cabin.isAvailable == 0
                                                    ? Colors.grey
                                                    : isSelected
                                                        ? Colors.blueAccent
                                                        : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                cabin.cabinNumber.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                cabin.name!.toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              cabin.isAc == 1
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .ac_unit_outlined,
                                                          size: 16,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text('Air Condition')
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.people_alt_outlined,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(cabin.capacity
                                                      .toString()),
                                                  SizedBox(width: 5),
                                                  Text('|'),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.king_bed,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      '${cabin.bedNumber.toString()}'),
                                                  SizedBox(width: 5),
                                                  Text('|'),
                                                  SizedBox(width: 5),
                                                  Icon(Icons.dinner_dining,
                                                      size: 16),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10),
                              Text('Available'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text('Booked'),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 10),
                              Text('Unavailable'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 75,
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Payable',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () {
                      return Text(
                        '৳ ${controller.grandTotal.value.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
              CustomButton(
                title: 'Confirm Booking',
                fullWidth: 180,
                onTap: () {
                  if (controller.selectedCabins.length <= 0) {
                    Get.snackbar('Info', 'Please select a cabin.');
                  } else {
                    Get.to(HouseboatBookingDetails());
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
