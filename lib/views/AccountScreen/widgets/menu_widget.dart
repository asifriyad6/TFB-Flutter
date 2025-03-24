import 'package:flutter/material.dart';

class AccountMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconBg;
  final VoidCallback onTap;
  const AccountMenu(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.iconBg});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
      onTap: onTap,
      leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          )),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
