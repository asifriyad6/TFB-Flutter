// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/BookingDetails/booking_details.dart';

import '../../../widget/custom_button.dart';

class DatePickerBottomSheet extends StatelessWidget {
  final controller = Get.put(TourController());

  DatePickerBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 400, // Adjust the height to fit the content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
              ),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
              controller: controller.dateController,
              readOnly: true,
              decoration: InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              onTap: () async {
                //Show Date Picker when the user taps the TextFormField inside bottom sheet
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.scheduleDate.value.first,
                  firstDate: controller.scheduleDate.value.first,
                  lastDate: controller.scheduleDate.value.last,
                  selectableDayPredicate: (DateTime date) {
                    return controller.scheduleDate.value.contains(date);
                  },
                );
                if (pickedDate != null) {
                  // Update the date in the controller and close the bottom sheet
                  controller.setSelectedDate(pickedDate);
                }
              }),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adults',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Age above ${controller.tourDetails.value.childAge} years',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent.withOpacity(.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.adultDecrement();
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 16,
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return Text(
                          controller.adultsCount.value.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.adultIncrement();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Child',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Age below ${controller.tourDetails.value.childAge} years',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent.withOpacity(.3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.childDecrement();
                        },
                        icon: Icon(
                          Icons.remove,
                          size: 16,
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return Text(
                          controller.childCount.value.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.childIncrement();
                        },
                        icon: Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () {
                  return Text(
                    '৳ ${(controller.totalPrice.value != 0 ? controller.totalPrice.value : controller.tour.value.discountedPrice)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Obx(
                () {
                  return Transform.scale(
                    alignment: Alignment.center,
                    scale: .53,
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
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            title: 'Confirm Booking',
            fullWidth: double.infinity,
            onTap: () {
              if (controller.selectedDate.value == null) {
                Get.back();
                Get.snackbar('Info', 'Please select a schedule.');
              } else {
                Get.to(BookingDetails());
              }
            },
          ),
        ],
      ),
    );
  }
}
