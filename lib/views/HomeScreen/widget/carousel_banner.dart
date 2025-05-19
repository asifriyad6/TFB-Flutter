import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tfb/models/banner_images.dart';

import '../../../utils/config.dart';

class CarouselBanner extends StatelessWidget {
  final List<BannerImages> banner;
  const CarouselBanner({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return CarouselSlider.builder(
      itemCount: banner.length,
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              imageUrl: '${AppConfig.bannerImage}/${banner[index].name!}',
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error), // Error icon
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: height * .2,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.0,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
