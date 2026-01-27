import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashWidth;
  final double radius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2,
    this.gap = 5,
    this.dashWidth = 8,
    this.radius = 16,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLength = metrics.length;
    
    double distance = 0;
    while (distance < totalLength) {
      final len = dashWidth.clamp(0.0, totalLength - distance);
      final extractPath = metrics.extractPath(distance, distance + len);
      canvas.drawPath(extractPath, paint);
      distance += dashWidth + gap;
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.radius != radius;
  }
}

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashWidth;
  final double radius;

  const DashedBorderContainer({
    super.key,
    required this.child,
    required this.color,
    this.strokeWidth = 2,
    this.gap = 5,
    this.dashWidth = 8,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        dashWidth: dashWidth,
        radius: radius,
      ),
      child: child,
    );
  }
}
