import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/hotel_controller.dart';
import 'package:tfb/utils/colors.dart';

import '../models/houseboat_room_suggestion.dart';
import '../utils/config.dart';

class RoomSuggestionCard extends StatelessWidget {
  final HouseboatRoomSuggestionModel room;
  final int index;

  const RoomSuggestionCard(
      {super.key, required this.room, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HotelController());
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Obx(
      () {
        //final isSelected = controller.selectedRoomIndices.contains(index);
        final isSelected = controller.isSelectedRoom(index);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height * .28,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 5,
                    spreadRadius: 3,
                  )
                ]),
            child: Row(
              children: [
                Container(
                  width: width * .4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${AppConfig.houseboatImage}/${controller.houseboatDetails.value.thumbnail}'),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          room.name!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${room.capacity.toString()} Adults, 1 Child',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.bed,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${room.bedNumber} ${room.bedSize}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Amenities",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          room.amenities!
                              .map((e) => e.name ?? 'Unknown')
                              .join(", "),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '৳ ${room.discountedPrice}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '৳ ${room.basePrice}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Child Price :',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '৳ ${room.childPrice}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            InkWell(
                              onTap: () {
                                //controller.toggleRoomSelection(index, room.id!);
                                controller.toggleSelection(
                                  index,
                                  room.id!,
                                  double.parse(room.basePrice!),
                                  double.parse(room.discountedPrice!),
                                  double.parse(room.childPrice!),
                                  double.parse(room.childSum!),
                                );
                              },
                              child: Container(
                                width: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.red
                                      : AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  isSelected ? 'Deselect' : 'Select',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
        );
      },
    );
  }
}
