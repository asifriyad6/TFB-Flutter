import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;
  RxInt adultsCount = 1.obs;
  RxInt childCount = 0.obs;
  RxInt price = 0.obs;
  RxInt childPrice = 0.obs;
  RxInt tourPrice = 0.obs;
  RxInt totalPrice = 0.obs;
  RxBool isBookingAmount = false.obs;

  adultIncrement() {
    if (adultsCount < 9) {
      adultsCount++;
      finalPrice();
      update();
    }
  }

  adultDecrement() {
    if (adultsCount > 1) {
      adultsCount--;
      finalPrice();
      update();
    }
  }

  childIncrement() {
    if (childCount < 5) {
      childCount++;
      finalPrice();
      update();
    }
  }

  childDecrement() {
    if (childCount > 0) {
      childCount--;
      finalPrice();
      update();
    }
  }

  finalPrice() {
    var adultTotalPrice = adultsCount.value * price.value;
    var childTotalPrice = childCount.value * childPrice.value;
    totalPrice.value = adultTotalPrice + childTotalPrice;
  }

  bookingPrice() {
    var adultTotalPrice = adultsCount.value * 2000;
    var childTotalPrice = childCount.value * 2000;
    totalPrice.value = adultTotalPrice + childTotalPrice;
  }

  payBookingAmt() {
    if (isBookingAmount.value == true) {
      bookingPrice();
    } else {
      finalPrice();
    }
  }

  // TextEditingController to manage the TextFormField
  TextEditingController dateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initially setting the date in the TextFormField
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  @override
  void onClose() {
    super.onClose();
    dateController.dispose(); // Dispose the controller to avoid memory leaks
  }

  // Function to update the selected date and the text field
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    dateController.text =
        DateFormat('yyyy-MM-dd').format(date); // Update TextFormField
  }
}
