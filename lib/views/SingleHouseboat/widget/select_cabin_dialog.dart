import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/models/Houseboat/cabin_details.dart';

class CabinDetailsDialog extends StatelessWidget {
  final HouseboatCabin cabin;

  CabinDetailsDialog({Key? key, required this.cabin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseboatController());
    final childPrice = double.parse(cabin.childPrice!);
    final basePrice = double.parse(cabin.discountedPrice!);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.totalPrice.value = basePrice;
    });
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Cabin ${cabin.cabinNumber}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
      content: Container(
        height: cabin.isAc == 1 ? 345 : 325,
        child: Column(
          children: [
            Text("Category: ${cabin.name}",
                style: const TextStyle(fontSize: 18)),
            SizedBox(height: 5),
            cabin.isAc == 1
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ac_unit,
                        size: 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text("Air Condition Available",
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
                    ],
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.king_bed, size: 18),
                    SizedBox(width: 5),
                    Text('${cabin.bedNumber} ${cabin.bedSize} Bed'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.people_alt, size: 16),
                    SizedBox(width: 5),
                    Text('${cabin.capacity.toString()} Person'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.bathroom, size: 18),
                    SizedBox(width: 5),
                    Text('Private Washroom'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.restaurant, size: 16),
                    SizedBox(width: 5),
                    Text('All Meals'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Price : ৳${cabin.discountedPrice}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '৳${cabin.basePrice}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                  ),
                )
              ],
            ),
            Text(
              '(Price for ${cabin.capacity} persons.)',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 5),
            Text(
              'Child (2-5 yrs) Price: ৳${cabin.childPrice}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            // Number of Children Selection (Using Obx)
            Obx(() => Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Children: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (controller.childCount.value > 0) {
                            controller.childCount.value--;
                            controller.finalPrice(childPrice, basePrice);
                          }
                        },
                      ),
                      Text("${controller.childCount.value}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (controller.childCount.value < 5) {
                            controller.childCount.value++;
                            controller.finalPrice(childPrice, basePrice);
                          }
                        },
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 15),
            Obx(() => Text(
                  "Total Price: ৳${controller.totalPrice.value}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),

            const SizedBox(height: 15),

            // Select Cabin Button
            ElevatedButton(
              onPressed: () {
                controller.selectCabin(cabin.id!);
                Get.back();
              },
              child: const Text("Select Cabin"),
            ),
          ],
        ),
      ),
    );
  }
}
