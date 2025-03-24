import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tfb/controller/booking_controller.dart';
import 'package:tfb/models/Bookings/all_bookings.dart';
import 'package:tfb/views/AccountScreen/BookingScreen/booking_details.dart';

class UpcomingBookings extends StatelessWidget {
  final List<BookingsModel> bookings;
  const UpcomingBookings({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());
    return Padding(
      padding: EdgeInsets.all(10),
      child: bookings.isEmpty
          ? Center(
              child: Text('No data found'),
            )
          : ListView.builder(
              itemCount: bookings.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return InkWell(
                  onTap: () {
                    Get.to(BookingDetails(
                      details: booking,
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 3,
                              spreadRadius: 1)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                booking.bookableType == 'tour'
                                    ? Icons.tour
                                    : Icons.houseboat,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                booking.bookableType == 'tour'
                                    ? 'TOUR'
                                    : 'HOUSEBOAT',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking.bookingNo!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '৳ ${booking.amountPaid}',
                                  style: TextStyle(
                                    color: Colors.orange.shade800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        booking.status!,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        'Due',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${DateFormat.yMMMMd('en_US').format(DateTime.parse(booking.schedule.toString()))}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
