import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation_menu.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Packages'),
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/main');
            },
            icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}
