import 'dart:math' as math;

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFE91E63), Color(0xFF9C27B0), Color(0xFF00BCD4)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width; x += 10) {
      final y =
          size.height * 0.5 + 20 * math.sin((x / size.width) * 4 * math.pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
