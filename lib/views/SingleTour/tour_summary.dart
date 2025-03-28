import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class TourSummary extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;
  const TourSummary(
      {super.key, required this.title, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primaryColor.withOpacity(.3),
          ),
          child: Icon(
            icon,
            size: 16,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        )
      ],
    );
  }
}
