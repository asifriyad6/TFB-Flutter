import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class ContactCard extends StatelessWidget {
  final String title;
  final String details;
  final IconData icon;
  final VoidCallback onTap;
  const ContactCard(
      {super.key,
      required this.title,
      required this.details,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Icon(
              icon,
              size: 18,
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
              onPressed: onTap,
              child: Text(
                details,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        )
      ],
    );
  }
}
