import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/models/Houseboat/cabin_details.dart';
import 'package:tfb/models/houseboat_details.dart';
import 'package:tfb/models/houseboat_model.dart';
import 'package:tfb/models/houseboat_room_suggestion.dart';

import '../services/api_services.dart';

class HotelController extends GetxController {
  var houseboatDetails = HouseboatDetails().obs;
  var houseboat = HouseboatModel().obs;
  var houseboatCabins = <HouseboatCabin>[].obs;
  var roomRequest = <houseboatRoomRequest>[].obs;
  var houseboatRoomSuggestion = <HouseboatRoomSuggestionModel>[].obs;
  RxBool isLoading = RxBool(false);
  var selectedDate = DateTime.now().obs;
  RxInt adultsCount = 1.obs;
  RxInt childCount = 0.obs;
  RxInt price = 0.obs;
  RxInt childPrice = 0.obs;
  RxInt tourPrice = 0.obs;
  RxInt totalPrice = 0.obs;
  RxBool isBookingAmount = false.obs;
  var roomList = <Room>[].obs;
  RxList scheduleDate = [].obs;
  var selectedRooms = <RoomSelection>[].obs;
  var selectedRoomIndices = <int>[].obs;
  RxDouble totalAmount = 0.0.obs;

  getHouseboatDetails() async {
    isLoading.value = true;
    final response =
        await ApiServices.getHouseboatDetails(houseboat.value.slug!);
    if (response.statusCode == 200) {
      houseboatDetails.value = houseboatDetailsFromJson(response.body);
      for (var schedule in houseboatDetails.value.schedule!) {
        scheduleDate.add(schedule.startDate);
      }
      selectedDate.value = scheduleDate.value.first;
      isLoading.value = false;
      update();
    }
  }

  getHouseboatRooms() async {
    //isLoading.value = true;
    houseboatRoomRequest data = houseboatRoomRequest(
        houseboatId: houseboat.value.id.toString(),
        schedule: DateFormat('yyyy-MM-dd').format(selectedDate.value),
        rooms: roomList.toList());
    final response = await ApiServices.getHouseboatRoom(data);
    final decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      houseboatRoomSuggestion.value =
          houseboatRoomSuggestionModelFromJson(response.body);
      totalAmount.value = 0.0;
      selectedRooms.value = [];
      //isLoading.value = false;
      update();
    }
  }

  // Function to add a new Room
  void addRoom() {
    if (roomList.length < houseboatDetails.value.totalRooms!.toInt()) {
      roomList.add(Room());
    }
  }

  void removeRoom(int index) {
    if (roomList.length > 1) {
      roomList.removeAt(index); // Remove room at the specified index
    }
  }

  // Update the room with a given index with new adults and children values
  void updateRoom(int index, int adults, int children) {
    roomList[index].adults = adults;
    roomList[index].children = children;
    roomList.refresh(); // Refresh the list to update UI
  }

  adultIncrement(int index, int children) {
    if (roomList[index].adults < 4) {
      roomList[index].adults++;
      roomList[index].children = children;
      roomList.refresh();
    }
  }

  adultDecrement(int index, int children) {
    if (roomList[index].adults > 1) {
      roomList[index].adults--;
      roomList[index].children = children;
      roomList.refresh();
    }
  }

  childIncrement(int index, int adults) {
    if (roomList[index].children < 4) {
      roomList[index].children++;
      roomList[index].adults = adults;
      roomList.refresh();
    }
  }

  childDecrement(int index, int adults) {
    if (roomList[index].children > 0) {
      roomList[index].children--;
      roomList[index].adults = adults;
      roomList.refresh();
    }
  }

  // void toggleRoomSelection(int index, int roomId) {
  //   if (selectedRoomIndices.contains(index)) {
  //     selectedRoomIndices.remove(index); // Deselect
  //   } else {
  //     if (selectedRoomIndices.length < roomList.value.length) {
  //       selectedRoomIndices.add(index);
  //     } else {
  //       Get.snackbar('Info', 'You have selected your maximum requested rooms.');
  //     }
  //   }
  //   calculateTotalPrice();
  // }

  void toggleSelection(int index, int roomId, double basePrice,
      double discountedPrice, double childPrice, double childSum) {
    final existingIndex =
        selectedRooms.indexWhere((room) => room.index == index);

    if (existingIndex != -1) {
      selectedRooms.removeAt(existingIndex); // Deselect
    } else {
      if (selectedRooms.value.length < roomList.value.length) {
        selectedRooms.add(
          RoomSelection(
            index: index,
            roomId: roomId,
            basePrice: basePrice,
            discountedPrice: discountedPrice,
            childPrice: childPrice,
            childSum: childSum,
          ),
        ); // Select
      } else {
        Get.snackbar('Error', 'You have selected your maximum requested rooms');
      }
    }
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    double roomTotal = selectedRooms
        .map((item) => item.discountedPrice)
        .fold(0, (sum, price) => sum + price);
    double childTotal = selectedRooms
        .map((item) => item.childSum)
        .fold(0, (sum, price) => sum + price);
    totalAmount.value = roomTotal + childTotal;
  }

  bool isSelectedRoom(int index) {
    return selectedRooms.any((room) => room.index == index);
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
    dateController.text = 'Please Select Date';
  }

  // Function to update the selected date and the text field
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    dateController.text =
        DateFormat('yyyy-MM-dd').format(date); // Update TextFormField
  }
}
