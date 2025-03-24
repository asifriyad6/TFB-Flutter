import 'package:get/get.dart';
import 'package:tfb/models/Bookings/all_bookings.dart';

import '../services/api_services.dart';

class BookingController extends GetxController {
  var allBookings = <BookingsModel>[].obs;
  var upcomingBookings = <BookingsModel>[].obs;
  var pastBookings = <BookingsModel>[].obs;
  var cancelledBookings = <BookingsModel>[].obs;
  var isLoading = true.obs;

  void fetchBookings() async {
    try {
      isLoading(true);
      final response = await ApiServices.getBookings();
      if (response.statusCode == 200) {
        allBookings.value = bookingsModelFromJson(response.body);
        filterBookings();
      }
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading(false);
    }
  }

  void filterBookings() {
    DateTime today = DateTime.now();

    upcomingBookings.value = allBookings.where((booking) {
      DateTime scheduleDate = DateTime.parse(booking.schedule.toString());
      return scheduleDate.isAfter(today) && booking.status != 'cancelled';
    }).toList();

    pastBookings.value = allBookings.where((booking) {
      DateTime scheduleDate = DateTime.parse(booking.schedule.toString());
      return scheduleDate.isBefore(today) && booking.status != 'cancelled';
    }).toList();

    cancelledBookings.value = allBookings.where((booking) {
      return booking.status == 'cancelled';
    }).toList();
  }
}
