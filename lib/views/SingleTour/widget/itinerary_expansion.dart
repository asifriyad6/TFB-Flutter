import 'package:flutter/material.dart';

class ItineraryExpansion extends StatelessWidget {
  final String itineraryDay;
  final String itineraryName;
  const ItineraryExpansion(
      {super.key, required this.itineraryDay, required this.itineraryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: ExpansionTile(
        dense: true,
        expandedAlignment: Alignment.bottomLeft,
        shape: RoundedRectangleBorder(),
        childrenPadding: EdgeInsets.fromLTRB(15, 0, 10, 15),
        title: Text(
          itineraryDay,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Column(
            children: [
              Text(
                itineraryName,
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
