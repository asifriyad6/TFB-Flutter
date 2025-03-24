import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/views/SingleHouseboat/houseboat_rooms.dart';
import 'package:tfb/widget/custom_button.dart';

import '../../utils/colors.dart';

class HouseboatDateSelect extends StatelessWidget {
  const HouseboatDateSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseboatController());
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      padding: EdgeInsets.all(15),
      height: height * .22,
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
                    fontSize: 20,
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
          CustomButton(
            title: 'See Houseboat Cabins',
            fullWidth: double.infinity,
            onTap: () {
              if (controller.selectedDate.value == null) {
                Get.back();
                Get.snackbar('Info', 'Please select a schedule.');
              } else {
                Get.to(BoatLayoutPage());
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
