import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/Helpers/payment_helper.dart';
import 'package:tfb/models/Tour/booking_request.dart';
import 'package:tfb/models/Tour/tour_details.dart';
import 'package:tfb/models/Tour/tour_model.dart';

import '../services/api_services.dart';

class TourController extends GetxController {
  final payment = Get.put(PaymentHelper());
  var tour = TourModel().obs;
  var tours = <TourModel>[].obs;
  var tourDetails = TourDetails().obs;
  RxBool isLoading = RxBool(false);
  RxList scheduleDate = [].obs;
  var selectedDate = Rx<DateTime?>(null);
  RxInt adultsCount = 1.obs;
  RxInt childCount = 0.obs;
  RxBool isBookingAmount = false.obs;
  RxDouble totalPrice = 0.0.obs;
  var tourBooking = TourBookingRequest().obs;

  getTourByLocation(String location) async {
    isLoading.value = true;
    final response = await ApiServices.getTourByLocation(location);
    if (response.statusCode == 200) {
      isLoading.value = false;
      tours.value = tourModelFromJson(response.body);
      update();
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getTourDetails() async {
    isLoading.value = true;
    final response = await ApiServices.getTourDetails(tour.value.slug!);
    if (response.statusCode == 200) {
      tourDetails.value = tourDetailsFromJson(response.body);
      scheduleDate.value = [];
      for (var schedule in tourDetails.value.schedule!) {
        scheduleDate.add(schedule.startDate);
      }
      isLoading.value = false;
      selectedDate.value = null;
      update();
    }
  }

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
    final double adultTotalPrice = double.parse(adultsCount.value.toString()) *
        double.parse(tour.value.discountedPrice.toString());
    final double childTotalPrice = childCount.value *
        double.parse(tourDetails.value.priceChild.toString());
    totalPrice.value = adultTotalPrice + childTotalPrice;
  }

  bookingPrice() {
    final double adultTotalPrice = adultsCount.value *
        double.parse(tourDetails.value.bookingPrice.toString());
    var childTotalPrice = childCount.value *
        double.parse(tourDetails.value.priceChild.toString());
    totalPrice.value = adultTotalPrice + childTotalPrice;
  }

  payBookingAmt() {
    if (isBookingAmount.value == true) {
      bookingPrice();
    } else {
      finalPrice();
    }
  }

  confirmBooking() async {
    isLoading.value = true;
    try {
      final response = await ApiServices.tourBooking(tourBooking.value);
      if (response.statusCode == 200) {
        final decode = jsonDecode(response.body);
        if (decode.containsKey('amount_paid') &&
            decode.containsKey('transaction_id')) {
          double amountPaid = double.parse(decode['amount_paid'].toString());
          String transactionId = decode['transaction_id'].toString();
          payment.onButtonTap(amountPaid, transactionId);
        } else {
          Get.snackbar('Error', 'Required fields are missing in the response.');
        }

        isLoading.value = false;
      } else {
        final decode = jsonDecode(response.body);
        isLoading.value = false;
        Get.snackbar('Error', decode['message'] ?? 'Something went wrong.');
        print(decode['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred: $e');
      print(e);
    }
  }

  // TextEditingController to manage the TextFormField
  TextEditingController dateController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    // Initially setting the date in the TextFormField
    dateController.text = 'Please Select Date';
  }

  // Function to update the selected date and the text field
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    dateController.text =
        DateFormat('yyyy-MM-dd').format(date); // Update TextFormField
  }
}
