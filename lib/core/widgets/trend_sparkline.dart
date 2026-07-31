import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design/design_tokens.dart';

/// Supporting widget (research.md §2), not a named Figma component — a
/// `CustomPainter` line through normalized [points], used by both `TrendCard`
/// (48px tall) and `CurrencyDetailPage`'s chart area (180px tall).
class TrendSparkline extends StatelessWidget {
  const TrendSparkline({
    super.key,
    required this.points,
    required this.isPositive,
  });

  final List<double> points;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrendSparklinePainter(points: points, isPositive: isPositive),
      size: Size.infinite,
    );
  }
}

class _TrendSparklinePainter extends CustomPainter {
  _TrendSparklinePainter({required this.points, required this.isPositive});

  final List<double> points;
  final bool isPositive;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final minValue = points.reduce(math.min);
    final maxValue = points.reduce(math.max);
    final range = maxValue - minValue;

    final paint = Paint()
      ..color = isPositive
          ? DesignTokens.colorAccentPositive
          : DesignTokens.colorAccentNegative
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    for (var i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final normalized = range == 0 ? 0.5 : (points[i] - minValue) / range;
      final y = size.height * (1 - normalized);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrendSparklinePainter oldDelegate) {
    return oldDelegate.points != points || oldDelegate.isPositive != isPositive;
  }
}
