import 'dart:math' as math;

import 'rate_point.dart';

/// The 30-day daily series for one currency pair, and the derived statistics
/// FR-006–FR-008 require. [points] is assumed non-empty by the derived
/// getters below — the empty case is guarded at the usecase layer
/// (`GetHistoricalRateSeries`), not here.
class HistoricalRateSeries {
  const HistoricalRateSeries({
    required this.baseCode,
    required this.quoteCode,
    required this.points,
  });

  final String baseCode;
  final String quoteCode;

  /// Chronologically ordered, one entry per date Frankfurter actually
  /// returned — non-trading days are simply absent, no synthetic fill.
  final List<RatePoint> points;

  double get percentChange =>
      (points.last.rate - points.first.rate) / points.first.rate * 100;

  double get minRate => points.map((p) => p.rate).reduce(math.min);

  double get maxRate => points.map((p) => p.rate).reduce(math.max);

  bool get isPositiveTrend => percentChange >= 0;

  @override
  bool operator ==(Object other) =>
      other is HistoricalRateSeries &&
      other.baseCode == baseCode &&
      other.quoteCode == quoteCode &&
      _listEquals(other.points, points);

  @override
  int get hashCode => Object.hash(baseCode, quoteCode, Object.hashAll(points));

  static bool _listEquals(List<RatePoint> a, List<RatePoint> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
