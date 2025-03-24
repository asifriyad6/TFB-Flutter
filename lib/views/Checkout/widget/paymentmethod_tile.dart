import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  final String logo;
  final String name;
  final Function()? onTap;
  final String selected;

  const PaymentMethodTile({
    super.key,
    required this.logo,
    required this.name,
    this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected == name.replaceAll(' ', '_').toLowerCase()
                ? Colors.blueAccent
                : Colors.black.withOpacity(.1),
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Image.asset(
            'assets/paymentGateway/$logo',
            height: 35,
            width: 35,
          ),
          title: Text(name),
        ),
      ),
    );
  }
}
