import 'package:flutter/material.dart';

class OverlayPainter extends CustomPainter {
  final Rect rect;

  OverlayPainter(this.rect);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());

    final bgPaint = Paint()
      ..color = Colors.black.withOpacity(0.8);

    canvas.drawRect(Offset.zero & size, bgPaint);

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      clearPaint,
    );

    final borderPaint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      borderPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}