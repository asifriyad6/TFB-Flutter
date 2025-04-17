import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfb/controller/wishlist_controller.dart';
import 'package:tfb/views/AccountScreen/WishlistScreen/shimmer/wishlist_shimmer.dart';
import 'package:tfb/views/AccountScreen/WishlistScreen/wishlist_widget.dart';
import 'package:tfb/widget/custom_appbar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final controller = Get.put(WishlistController());
  @override
  void initState() {
    super.initState();
    controller.fetchWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Wishlist'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const WishlistShimmer();
              } else if (controller.wishlistItems.isEmpty) {
                return const Center(
                  heightFactor: 30,
                  child: Text(
                    "You haven't added anything to wishlist.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.wishlistItems.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final wishlist = controller.wishlistItems[index];
                    return WishlistWidget(wishlist: wishlist);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
