import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/search_controller.dart';
import 'package:tfb/views/Location/location_wise.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = Get.put(SearchSuggestionController());
  final FocusNode searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController.searchController,
          onChanged: (value) => searchController.fetchSuggestions(value),
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            hintText: "Enter destination...",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (!searchController.selectedDestination.value.isNull) {
                  Get.to(
                      () => LocationWise(
                            location:
                                searchController.selectedDestination.value,
                          ),
                      transition: Transition.rightToLeftWithFade);
                } else {
                  Get.snackbar("Error", "Please select a destination",
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (searchController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (searchController.suggestions.isEmpty) {
            return Center(child: Text("No results found"));
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: ListView.builder(
              itemCount: searchController.suggestions.length,
              itemBuilder: (context, index) {
                var item = searchController.suggestions[index];
                return ListTile(
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  minTileHeight: 40,
                  leading: Icon(
                    Icons.room,
                    size: 18,
                  ),
                  title: Text(
                    item.name!,
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    searchController.selectDestination(item);
                    Get.to(
                        () => LocationWise(
                              location: item,
                            ),
                        transition: Transition.fadeIn);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
