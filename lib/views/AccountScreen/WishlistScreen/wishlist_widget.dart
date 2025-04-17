import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tfb/controller/wishlist_controller.dart';
import 'package:get/get.dart';

import '../../../models/wishlist_model.dart';
import '../../../utils/config.dart';

class WishlistWidget extends StatelessWidget {
  final WishlistResponse wishlist;
  const WishlistWidget({super.key, required this.wishlist});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 5,
              color: Colors.black.withOpacity(.3),
            )
          ]),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: CachedNetworkImage(
          width: width * .2,
          fit: BoxFit.cover,
          imageUrl:
              '${wishlist.type == 'tour' ? AppConfig.tourImage : AppConfig.houseboatImage}/${wishlist.thumbnail}',
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error), // Error icon
        ),
        title: Text("${wishlist.title}"),
        subtitle: Text('Location: ${wishlist.location}'),
        trailing: IconButton(
            onPressed: () {
              wishlist.type == 'tour'
                  ? controller.removeFromWishlist(wishlist.id, null)
                  : controller.removeFromWishlist(null, wishlist.id);
            },
            icon: const Icon(Icons.delete)),
      ),
    );
  }
}
