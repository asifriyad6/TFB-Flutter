import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/Helpers/payment_helper.dart';
import 'package:tfb/controller/houseboat_controller.dart';
import 'package:tfb/controller/tour_controller.dart';
import 'package:tfb/views/Checkout/widget/paymentmethod_tile.dart';

import '../../utils/colors.dart';

class CheckoutView extends StatelessWidget {
  final String bookingType;
  const CheckoutView({super.key, required this.bookingType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentHelper());
    final tourController = Get.put(TourController());
    final houseboatController = Get.put(HouseboatController());
    List<Map> gateways = [
      {
        'name': 'SslCommerz',
        'logo': 'sslcommerz.png',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                        'Select a payment method',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (_, index) {
                          return PaymentMethodTile(
                            logo: gateways[index]['logo'],
                            name: gateways[index]['name'],
                            selected: controller.selected.value ?? '',
                            onTap: () {
                              controller.selected.value = gateways[index]
                                      ['name']
                                  .toString()
                                  .replaceAll(' ', '_')
                                  .toLowerCase();
                            },
                          );
                        },
                        separatorBuilder: (_, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: gateways.length,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: controller.selected.value == ''
                      ? null
                      : () => bookingType == 'tour'
                          ? tourController.confirmBooking()
                          : houseboatController.confirmBooking(),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.selected.value == ''
                          ? AppColor.primaryColor.withOpacity(.5)
                          : AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Continue to payment',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
