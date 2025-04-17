import 'dart:convert';

import 'package:get/get.dart';
import 'package:tfb/models/wishlist_model.dart';

import '../services/api_services.dart';

class WishlistController extends GetxController {
  final RxBool isLoading = false.obs;
  final wishlist = WishlistModel().obs;
  var wishlistItems = <WishlistResponse>[].obs;
  final RxBool isWishlist = false.obs;

  void addToWishlist() async {
    try {
      isLoading.value = true;
      final wishlistData = wishlist.value.addWishlist();
      final response = await ApiServices.addToWishlist(wishlistData);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isWishlist.value = true;
        Get.snackbar('Success', decode['message']);
      } else {
        Get.snackbar('Error', decode['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }

  void checkWishlist(int? tourId, int? houseboatId) async {
    try {
      isLoading.value = true;
      final response = await ApiServices.checkWishlist(tourId, houseboatId);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isWishlist.value = decode['in_wishlist'];
        update();
      } else {
        Get.snackbar('Error', decode['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }

  void removeFromWishlist(int? tourId, int? houseboatId) async {
    try {
      isLoading.value = true;
      final response = await ApiServices.removeWishlist(tourId, houseboatId);
      isLoading.value = false;
      final decode = jsonDecode(response.body);
      if (response.statusCode == 200) {
        isWishlist.value = false;
        Get.snackbar('Success', decode['message']);
        fetchWishlist();
      } else {
        Get.snackbar('Error', decode['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'An unexpected error occurred: $e');
    }
  }

  void fetchWishlist() async {
    try {
      isLoading(true);
      final response = await ApiServices.getWishlist();
      if (response.statusCode == 200) {
        wishlistItems.value = wishlistResponseFromJson(response.body);
      } else {
        Get.snackbar('Error', 'Internal server error');
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print("Error fetching bookings: $e");
    } finally {
      isLoading(false);
    }
  }
}
