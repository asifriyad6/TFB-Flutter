import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:tfb/services/api_services.dart';

class SearchSuggestionController extends GetxController {
  var searchController = TextEditingController();
  var suggestions = [].obs;
  var isLoading = false.obs;
  var selectedDestination = "".obs;

  void fetchSuggestions(String query) async {
    if (query.isEmpty) {
      suggestions.clear();
      return;
    }
    try {
      isLoading(true);
      final response = await ApiServices.getSearchDestination(query);
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        suggestions.value = data;
        print(data);
      } else {
        final decode = jsonDecode(response.body);
        suggestions.clear();
        print(decode);
      }
    } catch (e) {
      print("Error fetching suggestions: $e");
      suggestions.clear();
    } finally {
      isLoading(false);
    }
  }

  // Select a destination
  void selectDestination(String destination) {
    selectedDestination.value = destination;
    searchController.text = destination;
  }
}
