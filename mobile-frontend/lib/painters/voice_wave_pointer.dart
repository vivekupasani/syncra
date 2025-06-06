import 'dart:math' as math;

import 'package:flutter/material.dart';

class VoiceWavePainter extends CustomPainter {
  final double pulseValue;
  final double waveValue;
  final bool isListening;

  VoiceWavePainter({
    required this.pulseValue,
    required this.waveValue,
    required this.isListening,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()..style = PaintingStyle.stroke;

    if (!isListening) return;

    // Draw pulsing circles
    for (int i = 1; i <= 5; i++) {
      final radius = (30 + i * 20) * pulseValue;
      final opacity = (1.0 - (i * 0.15)).clamp(0.0, 1.0);

      paint.color = Color(0xFFE91E63).withOpacity(opacity * 0.3);
      paint.strokeWidth = 2.0;
      canvas.drawCircle(center, radius, paint);
    }

    // Draw animated wave patterns
    for (int ring = 0; ring < 3; ring++) {
      final baseRadius = 80.0 + (ring * 25);
      final waveOffset = waveValue + (ring * math.pi / 4);

      Path wavePath = Path();
      bool isFirst = true;

      for (double angle = 0; angle < 2 * math.pi; angle += 0.05) {
        final waveAmplitude = 8 * math.sin(waveOffset + angle * 4);
        final radius = baseRadius + waveAmplitude;
        final x = center.dx + radius * math.cos(angle);
        final y = center.dy + radius * math.sin(angle);

        if (isFirst) {
          wavePath.moveTo(x, y);
          isFirst = false;
        } else {
          wavePath.lineTo(x, y);
        }
      }

      wavePath.close();

      paint.color = Color(0xFF9C27B0).withOpacity(0.2 - ring * 0.05);
      paint.strokeWidth = 1.5;
      canvas.drawPath(wavePath, paint);
    }
  }

  @override
  bool shouldRepaint(VoiceWavePainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue ||
        oldDelegate.waveValue != waveValue ||
        oldDelegate.isListening != isListening;
  }
}
