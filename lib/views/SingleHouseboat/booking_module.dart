import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/hotel_controller.dart';
import 'package:tfb/views/SingleHouseboat/houseboat_room_suggestion.dart';

import '../../utils/colors.dart';

class HouseboatBooking extends StatelessWidget {
  const HouseboatBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HotelController());
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.all(15),
      height: height * .9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            onTap: () async {
              // Show Date Picker when the user taps the TextFormField inside bottom sheet
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
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return Column(
                      children:
                          List.generate(controller.roomList.length, (index) {
                        var room = controller.roomList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          elevation: 1,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Room ${index + 1}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    if (index > 0)
                                      TextButton(
                                          onPressed: () {
                                            controller.removeRoom(index);
                                          },
                                          child: Text('Remove')),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Adults',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Age above 5 years',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black.withOpacity(.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent
                                            .withOpacity(.3),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                controller.adultDecrement(
                                                    index, room.children);
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            room.adults.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                                controller.adultIncrement(
                                                    index, room.children);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Child',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Age below 5 years',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black.withOpacity(.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent
                                            .withOpacity(.3),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                controller.childDecrement(
                                                  index,
                                                  room.adults,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            room.children.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                                controller.childIncrement(
                                                  index,
                                                  room.adults,
                                                );
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
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                  TextButton(
                      onPressed: () {
                        controller.addRoom();
                      },
                      child: Text('Add Room')),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(HouseboatRoomSuggestion());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                textAlign: TextAlign.center,
                'See Booking Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
