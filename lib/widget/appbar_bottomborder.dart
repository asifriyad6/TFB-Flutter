import 'package:flutter/material.dart';

class AppbarBottomborder extends StatelessWidget {
  const AppbarBottomborder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(.2),
            width: 1,
          ),
        ),
      ),
    );
  }
}
