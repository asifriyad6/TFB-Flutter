import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/models/Houseboat/booking_request.dart';
import 'package:tfb/views/Checkout/checkout_view.dart';
import 'package:tfb/widget/custom_button.dart';

import '../../utils/colors.dart';
import '../../utils/config.dart';

class HouseboatBookingDetails extends StatelessWidget {
  const HouseboatBookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseboatController());
    controller.isBookingAmount.value = false;
    final houseboat = controller.houseboat.value;
    final cabinTotal = controller.selectedCabins
        .fold(0.0, (sum, room) => sum + room.basePrice);
    final childTotal = controller.selectedCabins
        .fold(0.0, (sum, room) => sum + room.childPrice);
    final grandTotal = controller.selectedCabins
        .fold(0.0, (sum, room) => sum + room.totalAmount);
    controller.grandTotal.value = grandTotal;
    final subTotal = cabinTotal + childTotal;
    final discountTotal = subTotal - grandTotal;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Review Your Booking'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: height * .12,
                          width: width * .3,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${AppConfig.houseboatImage}/${houseboat.thumbnail}'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  houseboat.title!,
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
                                    Icon(
                                      Icons.location_on,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      houseboat.location!,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.directions_boat,
                        color: Colors.black.withOpacity(.6),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Houseboat Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            houseboat.title!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.hotel,
                        color: Colors.black.withOpacity(.6),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cabin Number',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            controller.selectedCabins
                                .map((e) => e.cabinNumber ?? '')
                                .join(", "),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black.withOpacity(.6),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departure Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(.6),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${(DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!))}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cabin Price',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Qty. ${controller.selectedCabins.length}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '৳ ${cabinTotal}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  controller.selectedCabins
                              .fold(0, (sum, room) => sum + room.children) >
                          0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Child Total',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${controller.selectedCabins.fold(0, (sum, room) => sum + room.children)} Person',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '৳ ${childTotal}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '৳ ${subTotal}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '৳ ${discountTotal}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '৳ ${grandTotal}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payable Amount',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '৳ ${controller.grandTotal.value}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment Due',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.isBookingAmount == true
                                    ? '৳ ${controller.selectedCabins.fold(0.0, (sum, room) => sum + room.totalAmount) - controller.grandTotal.toInt()}'
                                    : '৳ 0.0',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Obx(
                        () {
                          return Transform.scale(
                            scale: .8,
                            child: Switch.adaptive(
                              inactiveTrackColor: Colors.white,
                              activeColor: AppColor.primaryColor,
                              value: controller.isBookingAmount.value,
                              onChanged: (value) {
                                controller.isBookingAmount.value = value;
                                controller.payBookingAmt();
                              },
                            ),
                          );
                        },
                      ),
                      Text(
                        'Pay Booking Amount',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.black.withOpacity(.3),
        child: Obx(
          () {
            return controller.isBookingLoading.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/horizontal_dot.json',
                        height: 32,
                      ),
                      Text(
                        'Please wait. Redirecting to payment page.',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      )
                    ],
                  )
                : CustomButton(
                    title: 'Proceed to Payment',
                    fullWidth: double.infinity,
                    onTap: () {
                      controller.houseboatBooking.value =
                          (HouseboatBookingRequest(
                        houseboatId: houseboat.id!,
                        schedule: (DateFormat('yyyy-MM-dd')
                            .format(controller.selectedDate.value!)),
                        totalAmount: subTotal,
                        payableAmount: grandTotal,
                        amountPaid: controller.grandTotal.value,
                        amountDue: grandTotal - controller.grandTotal.value,
                        cabins: controller.selectedCabins,
                      ));
                      Get.to(CheckoutView(
                        bookingType: 'houseboat',
                      ));
                    },
                  );
          },
        ),
      ),
    );
  }
}
