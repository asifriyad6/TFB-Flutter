import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/models/Tour/booking_request.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/utils/config.dart';
import 'package:tfb/views/Checkout/checkout_view.dart';
import 'package:tfb/widget/custom_button.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final controller = Get.put(TourController());
    final basePrice = double.parse(controller.tour.value.priceAdult!);
    final discountedPrice =
        double.parse(controller.tour.value.discountedPrice.toString());
    final childPrice = double.parse(controller.tourDetails.value.priceChild!);
    final totalAmount = ((basePrice * controller.adultsCount.value) +
        (childPrice * controller.childCount.value));
    final payableAmount = ((discountedPrice * controller.adultsCount.value) +
        (childPrice * controller.childCount.value));
    final dueAmount = (((discountedPrice * controller.adultsCount.value) +
            (childPrice * controller.childCount.value)) -
        controller.totalPrice.value);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Review Your Booking',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                            height: height * .1,
                            width: width * .3,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${AppConfig.tourImage}/${controller.tour.value.thumbnail!}'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
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
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${controller.tour.value.city}, ${controller.tour.value.location}',
                                        style: TextStyle(
                                          fontSize: 14,
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
                      height: 10,
                    ),
                    Text(
                      'Booking Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.tour,
                          color: Colors.black.withOpacity(.6),
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Tour Package',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ),
                            Text(
                              controller.tour.value.title!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.black.withOpacity(.6),
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guests/Passengers',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ),
                            Text(
                              '${controller.adultsCount.value} Adults, ${controller.childCount.value} Child',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.black.withOpacity(.6),
                          size: 14,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Departure Date',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(.6),
                              ),
                            ),
                            Text(
                              '${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!)}',
                              style: TextStyle(
                                fontSize: 12,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adults Total',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${controller.adultsCount.value} X ${basePrice}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '৳ ${basePrice * controller.adultsCount.value}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    controller.childCount.value > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Child Total',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${controller.childCount.value} X ${controller.tourDetails.value.priceChild}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '৳ ${childPrice * controller.childCount.value}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '৳ $totalAmount',
                          style: TextStyle(
                            fontSize: 14,
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '৳ ${(basePrice * controller.adultsCount.value) - (discountedPrice * controller.adultsCount.value)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Payable',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '৳ $payableAmount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    controller.isBookingAmount.value == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Paid Amount',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '৳ ${(controller.totalPrice)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    controller.isBookingAmount.value == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment Due',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '৳ $dueAmount',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: CustomButton(
            title: 'Procced to Payment',
            onTap: () {
              controller.tourBooking.value = TourBookingRequest(
                tourId: controller.tour.value.id,
                schedule: controller.selectedDate.value.toString(),
                totalAmount: totalAmount,
                payableAmount: payableAmount,
                amountPaid: controller.totalPrice.value,
                amountDue: dueAmount,
                adults: controller.adultsCount.value,
                children: controller.childCount.value,
              );
              Get.to(CheckoutView(
                bookingType: 'tour',
              ));
            },
          ),
        ));
  }
}
