import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String> highlights;
  const Highlights(
      {super.key,
      required this.highlights,
      required this.title,
      required this.icon,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: highlights.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    highlights[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
