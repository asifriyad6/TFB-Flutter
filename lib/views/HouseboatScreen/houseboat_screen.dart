import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HouseboatScreen extends StatelessWidget {
  const HouseboatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Houseboat Packages'),
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/main');
            },
            icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}
