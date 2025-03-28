import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? fullWidth;
  final Color? color;
  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.fullWidth,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: fullWidth ?? double.infinity,
        decoration: BoxDecoration(
          color: color != null ? color : AppColor.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
