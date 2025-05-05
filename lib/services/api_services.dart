import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:tfb/models/Houseboat/booking_request.dart';
import 'package:tfb/models/Tour/booking_request.dart';
import 'package:tfb/utils/config.dart';
import 'package:tfb/utils/endpoints.dart';

import '../Helpers/token_helper.dart';
import '../models/houseboat_model.dart';
import '../models/user_model.dart';

class ApiServices {
  static Future<http.Response> getSearchDestination(String query) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.searchDestination}?query=$query'),
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getBanner() async {
    return await http.get(
      ApiEndpoints.bannerImages,
      headers: {
        'X-App-Platform': getAppPlatform(),
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getGeneralSettings() async {
    return await http.get(
      ApiEndpoints.getGeneralSettings,
      headers: {
        'X-App-Platform': getAppPlatform(),
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getLocation() async {
    return await http.get(
      ApiEndpoints.locationList,
      headers: {
        'X-App-Platform': getAppPlatform(),
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getHouseboat() async {
    return await http.get(
      ApiEndpoints.houseboatList,
      headers: {
        'X-App-Platform': getAppPlatform(),
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getHouseboatByLocation(String id) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.houseboatByLocation}/$id'),
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getTour() async {
    return await http.get(
      ApiEndpoints.tourList,
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getTourByLocation(String id) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.tourByLocation}/$id'),
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getHouseboatDetails(String id) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.houseboatDetails}/$id'),
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getTourDetails(String id) async {
    return await http.get(
      Uri.parse('${ApiEndpoints.tourDetails}/$id'),
      headers: {
        'Accept': 'Application/json',
      },
    );
  }

  static Future<http.Response> getHouseboatCabins(
      houseboatCabinRequest data) async {
    String requestBody = jsonEncode(data.toJson());
    return await http.post(
      ApiEndpoints.houseboatCabins,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'Application/json',
      },
      body: requestBody,
    );
  }

  static Future<http.Response> houseboatBooking(
      HouseboatBookingRequest data) async {
    String requestBody = jsonEncode(data.toJson());
    return await http.post(
      ApiEndpoints.houseboatBooking,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'Application/json',
        'Authorization': await authToken(),
      },
      body: requestBody,
    );
  }

  static Future<http.Response> tourBooking(TourBookingRequest data) async {
    String requestBody = jsonEncode(data.toJson());
    print(data);
    return await http.post(
      ApiEndpoints.tourBooking,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'Application/json',
        'Authorization': await authToken(),
      },
      body: requestBody,
    );
  }

  static Future<http.Response> getHouseboatRoom(
      houseboatRoomRequest data) async {
    String requestBody = jsonEncode(data.toJson());
    return await http.post(
      ApiEndpoints.houseboatRoomList,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: requestBody,
    );
  }

  static Future<http.Response> login(UserModel data) async {
    return await http.post(
      ApiEndpoints.login,
      headers: {
        'Accept': 'application/json',
      },
      body: data.toLogin(),
    );
  }

  static Future<http.Response> sendOtpRegister(String phone) async {
    print(phone);
    return await http.post(
      ApiEndpoints.sendOtpRegister,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'phone': phone}),
    );
  }

  static Future<http.Response> verifyOtp(UserModel data) async {
    return await http.post(
      ApiEndpoints.verifyOtp,
      headers: {
        'Accept': 'application/json',
      },
      body: data.verifyOtp(),
    );
  }

  static Future<http.Response> logout() async {
    return await http.post(
      ApiEndpoints.logout,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> register(UserModel data) async {
    return await http.post(
      ApiEndpoints.register,
      headers: {
        'Accept': 'application/json',
      },
      body: data.toRegister(),
    );
  }

  static Future<http.Response> updateProfile(UserModel data) async {
    return await http.post(
      ApiEndpoints.updateProfile,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
      body: data.updateProfile(),
    );
  }

  static Future<http.Response> changePassword(UserModel data) async {
    return await http.post(
      ApiEndpoints.changePassword,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
      },
      body: data.changePassword(),
    );
  }

  static Future<http.Response> getBookings() async {
    return await http.get(
      ApiEndpoints.bookingList,
      headers: {
        'Accept': 'Application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> getWishlist() async {
    return await http.get(
      ApiEndpoints.getWishlist,
      headers: {
        'Accept': 'Application/json',
        'Authorization': await authToken(),
      },
    );
  }

  static Future<http.Response> addToWishlist(
      Map<String, dynamic> wishlistData) async {
    return await http.post(
      ApiEndpoints.addToWishlist,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(wishlistData),
    );
  }

  static Future<http.Response> checkWishlist(
      int? tourId, int? houseboatId) async {
    Map<String, dynamic> wishlistData = {
      'tour_id': tourId,
      'houseboat_id': houseboatId,
    };
    return await http.post(
      ApiEndpoints.checkWishlist,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(wishlistData),
    );
  }

  static Future<http.Response> removeWishlist(
      int? tourId, int? houseboatId) async {
    Map<String, dynamic> wishlistData = {
      'tour_id': tourId,
      'houseboat_id': houseboatId,
    };
    return await http.post(
      ApiEndpoints.removeWishlist,
      headers: {
        'Accept': 'application/json',
        'Authorization': await authToken(),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(wishlistData),
    );
  }
}
