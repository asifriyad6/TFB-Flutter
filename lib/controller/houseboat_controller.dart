import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/Helpers/payment_helper.dart';
import 'package:tfb/models/Houseboat/booking_request.dart';
import 'package:tfb/models/Houseboat/cabin_details.dart';
import 'package:tfb/models/houseboat_details.dart';
import 'package:tfb/models/houseboat_model.dart';

import '../services/api_services.dart';

class HouseboatController extends GetxController {
  final payment = Get.put(PaymentHelper());
  var houseboatDetails = HouseboatDetails().obs;
  var houseboat = HouseboatModel().obs;
  var houseboats = <HouseboatModel>[].obs;
  var houseboatCabins = <HouseboatCabin>[].obs;
  RxBool isLoading = RxBool(false);
  RxBool isCabinLoading = RxBool(false);
  RxBool isBookingLoading = false.obs;
  var selectedDate = Rx<DateTime?>(null);
  RxInt childCount = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxList scheduleDate = [].obs;
  var selectedCabins = <CabinSelection>[].obs;
  RxDouble grandTotal = 0.0.obs;
  RxBool isBookingAmount = false.obs;
  var houseboatBooking = HouseboatBookingRequest().obs;

  getHouseboatByLocation(String location) async {
    isLoading.value = true;
    final response = await ApiServices.getHouseboatByLocation(location);
    if (response.statusCode == 200) {
      isLoading.value = false;
      houseboats.value = houseboatModelFromJson(response.body);
      update();
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getAllHouseboat() async {
    isLoading.value = true;
    final response = await ApiServices.getHouseboatByLocation('all');
    if (response.statusCode == 200) {
      isLoading.value = false;
      houseboats.value = houseboatModelFromJson(response.body);
      update();
    } else {
      isLoading.value = false;
      Get.snackbar('Error', 'Internal Server Error');
    }
  }

  getHouseboatDetails() async {
    isLoading.value = true;
    final response =
        await ApiServices.getHouseboatDetails(houseboat.value.slug!);
    if (response.statusCode == 200) {
      houseboatDetails.value = houseboatDetailsFromJson(response.body);
      for (var schedule in houseboatDetails.value.schedule!) {
        scheduleDate.add(schedule.startDate);
      }
      //selectedDate.value = scheduleDate.value.first;
      isLoading.value = false;
      selectedDate.value = null;
      update();
    }
  }

  getHouseboatCabins() async {
    isCabinLoading.value = true;
    houseboatCabinRequest data = houseboatCabinRequest(
      houseboatId: houseboat.value.id.toString(),
      schedule: DateFormat('yyyy-MM-dd').format(selectedDate.value!),
    );
    final response = await ApiServices.getHouseboatCabins(data);
    if (response.statusCode == 200) {
      houseboatCabins.value = houseboatCabinFromJson(response.body);
      isCabinLoading.value = false;
      selectedCabins.clear();
      isBookingAmount.value = false;
      grandTotal.value = 0.0;
      isBookingLoading.value = false;
      update();
    }
  }

  finalPrice(double childPrice, double basePrice) {
    var childTotal = childCount.value * childPrice;
    totalPrice.value = basePrice + childTotal;
    update();
  }

  void selectCabin(int cabinId) {
    var cabin = houseboatCabins.firstWhere((c) => c.id == cabinId);
    var existingCabinIndex =
        selectedCabins.indexWhere((c) => c.cabinId == cabinId);
    if (existingCabinIndex != -1) {
      selectedCabins.removeAt(existingCabinIndex);
    } else {
      selectedCabins.add(CabinSelection(
        boatId: houseboat.value.id!,
        cabinId: cabinId,
        cabinNumber: cabin.cabinNumber!,
        children: childCount.value,
        basePrice: double.parse(cabin.basePrice!),
        childPrice: double.parse(cabin.childPrice!),
        bookingPrice: double.parse(cabin.bookingPrice!),
        totalAmount: totalPrice.value,
      ));
    }
    calculateTotalAmount();
    childCount.value = 0;
    totalPrice.value = 0.0;
  }

  void calculateTotalAmount() {
    grandTotal.value =
        selectedCabins.fold(0, (sum, item) => sum + item.totalAmount);
  }

  bookingPrice() {
    var cabinTotal =
        selectedCabins.fold(0.0, (sum, item) => sum + item.bookingPrice);
    var childTotal = selectedCabins.fold(0.0, (sum, item) {
      if (item.children > 0) {
        return sum + (item.childPrice * item.children);
      }
      return sum;
    });
    grandTotal.value = cabinTotal + childTotal;
  }

  payBookingAmt() {
    if (isBookingAmount.value == true) {
      bookingPrice();
    } else {
      calculateTotalAmount();
    }
  }

  confirmBooking() async {
    isLoading.value = true;
    try {
      final response =
          await ApiServices.houseboatBooking(houseboatBooking.value);
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
