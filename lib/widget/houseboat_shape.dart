import 'package:flutter/material.dart';

class BoatShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var fillPaint = Paint()
      //..color = Color(0xFFc88034)
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var borderPaint = Paint()
      ..color = Colors.black.withOpacity(.2) // Border color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1; // Border thickness

    var path = Path();
    path.moveTo(size.width * 0.05, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.5, -size.height * 0.2,
        size.width * 0.95, size.height * 0.2);
    path.lineTo(size.width * 0.95, size.height * 1);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1, size.width * 0.05, size.height * 1);
    path.close();

    // **Draw shadow**
    canvas.drawShadow(path, Colors.black.withOpacity(0.6), 8.0, false);

    // **Draw filled shape**
    canvas.drawPath(path, fillPaint);

    // **Draw border outline**
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
