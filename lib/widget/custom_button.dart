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
    return Container(
      width: fullWidth ?? double.infinity,
      decoration: BoxDecoration(
        color: color != null ? color : AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
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
