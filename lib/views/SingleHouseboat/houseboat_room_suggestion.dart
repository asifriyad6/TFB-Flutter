import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/hotel_controller.dart';
import 'package:tfb/utils/colors.dart';
import 'package:tfb/views/SingleHouseboat/widget/room_count.dart';
import 'package:tfb/widget/room_suggestion_card.dart';
import '../../utils/config.dart';

class HouseboatRoomSuggestion extends StatefulWidget {
  const HouseboatRoomSuggestion({super.key});

  @override
  State<HouseboatRoomSuggestion> createState() =>
      _HouseboatRoomSuggestionState();
}

class _HouseboatRoomSuggestionState extends State<HouseboatRoomSuggestion> {
  final controller = Get.put(HotelController(), permanent: true);
  @override
  void initState() {
    super.initState();
    controller.getHouseboatRooms();
  }

  @override
  Widget build(BuildContext context) {
    final totalPerson =
        controller.roomList.fold(0, (sum, room) => sum + room.adults);
    final totalChild =
        controller.roomList.fold(0, (sum, room) => sum + room.children);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text('Select Room'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(controller.selectedDate.value),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 5),
                Text("|"),
                SizedBox(width: 5),
                Icon(
                  Icons.king_bed_outlined,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  controller.roomList.length.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 5),
                Text("|"),
                SizedBox(width: 5),
                Icon(
                  Icons.people_alt_outlined,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  totalPerson.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.child_care_outlined,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(
                  totalChild.toString(),
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.houseboatRoomSuggestion.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final room = controller.houseboatRoomSuggestion[index];
                      final isSelected =
                          controller.selectedRoomIndices.contains(index);
                      return RoomSuggestionCard(room: room, index: index);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.white,
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () {
                    return Text(
                      '৳ ${controller.totalAmount}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'Confirm Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () {
          return controller.selectedRooms.length > 0
              ? FloatingRoomCount(
                  text:
                      '${controller.selectedRooms.length} of ${controller.roomList.length} Rooms Selected')
              : SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
