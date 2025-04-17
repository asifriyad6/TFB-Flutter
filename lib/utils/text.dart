import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final Color? color;

  const AppText({
    Key? key,
    required this.text,
    required this.style,
    this.textAlign,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: color != null ? Colors.black : color),
      textAlign: textAlign,
    );
  }

  static Widget textH1(String text, {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: textAlign,
      color: color,
    );
  }

  static Widget textBody(String text, {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(fontSize: 14),
      textAlign: textAlign,
      color: color,
    );
  }

  static Widget textBody2(String text, {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(fontSize: 12),
      textAlign: textAlign,
      color: color,
    );
  }

  static Widget textBodyBold(String text,
      {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      textAlign: textAlign,
      color: color,
    );
  }

  static Widget textTitle(String text, {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
      textAlign: textAlign,
      color: color,
    );
  }

  static Widget textSubtitle(String text,
      {TextAlign? textAlign, Color? color}) {
    return AppText(
      text: text,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      textAlign: textAlign,
      color: color,
    );
  }
}
