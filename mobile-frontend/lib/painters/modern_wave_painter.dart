import 'dart:math' as math;

import 'package:flutter/material.dart';

class ModernWavePainter extends CustomPainter {
  final double waveValue;

  ModernWavePainter({required this.waveValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Create gradient for the wave
    final gradient = LinearGradient(
      colors: [
        Color(0xFF9C27B0).withOpacity(0.3),
        Color(0xFF673AB7).withOpacity(0.1),
        Colors.transparent,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = gradient.createShader(rect);

    // Draw multiple wave layers
    for (int i = 0; i < 3; i++) {
      final path = Path();
      final waveHeight = 30.0 - (i * 8);
      final frequency = 0.02 + (i * 0.01);
      final phase = waveValue + (i * math.pi / 3);

      path.moveTo(0, size.height);

      for (double x = 0; x <= size.width; x += 1) {
        final y =
            size.height / 2 +
            waveHeight * math.sin(frequency * x + phase) +
            (waveHeight / 2) * math.sin(frequency * x * 2 + phase * 1.5);

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      paint.color = Color(0xFF9C27B0).withOpacity(0.1 - i * 0.03);
      canvas.drawPath(path, paint);
    }

    // Add floating particles
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 12; i++) {
      final x =
          (size.width / 12) * i +
          20 * math.sin(waveValue * 2 + i * math.pi / 6);
      final y = size.height / 2 + 15 * math.cos(waveValue + i * math.pi / 4);

      particlePaint.color = Color(0xFF9C27B0).withOpacity(0.4);
      canvas.drawCircle(Offset(x, y), 2, particlePaint);
    }
  }

  @override
  bool shouldRepaint(ModernWavePainter oldDelegate) {
    return oldDelegate.waveValue != waveValue;
  }
}
