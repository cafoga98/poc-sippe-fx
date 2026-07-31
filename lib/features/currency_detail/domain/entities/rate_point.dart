/// One day's rate for a currency pair in a `HistoricalRateSeries`.
class RatePoint {
  const RatePoint({required this.date, required this.rate});

  final DateTime date;
  final double rate;

  @override
  bool operator ==(Object other) =>
      other is RatePoint && other.date == date && other.rate == rate;

  @override
  int get hashCode => Object.hash(date, rate);

  @override
  String toString() => 'RatePoint(date: $date, rate: $rate)';
}
