import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:tfb/services/api_services.dart';

import '../models/location_model.dart';

class SearchSuggestionController extends GetxController {
  var searchController = TextEditingController();
  var suggestions = <LocationModel>[].obs;
  var isLoading = false.obs;
  var selectedDestination = LocationModel().obs;

  void fetchSuggestions(String query) async {
    if (query.isEmpty) {
      suggestions.clear();
      return;
    }
    try {
      isLoading(true);
      final response = await ApiServices.getSearchDestination(query);
      if (response.statusCode == 200) {
        //final List data = json.decode(response.body);
        suggestions.value = locationModelFromJson(response.body);
      } else {
        final decode = jsonDecode(response.body);
        suggestions.clear();
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
      suggestions.clear();
    } finally {
      isLoading(false);
    }
  }

  // Select a destination
  void selectDestination(LocationModel destination) {
    selectedDestination.value = destination;
    searchController.text = destination.name!;
  }
}
