import 'package:flutter_test/flutter_test.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/historical_rate_series.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/rate_point.dart';

void main() {
  group('HistoricalRateSeries', () {
    test(
      'computes percentChange, minRate, maxRate and isPositiveTrend for a rising series',
      () {
        final series = HistoricalRateSeries(
          baseCode: 'USD',
          quoteCode: 'PEN',
          points: [
            RatePoint(date: DateTime(2026, 7, 1), rate: 3.70),
            RatePoint(date: DateTime(2026, 7, 15), rate: 3.60),
            RatePoint(date: DateTime(2026, 7, 30), rate: 3.80),
          ],
        );

        expect(series.percentChange, closeTo((3.80 - 3.70) / 3.70 * 100, 1e-9));
        expect(series.minRate, 3.60);
        expect(series.maxRate, 3.80);
        expect(series.isPositiveTrend, isTrue);
      },
    );

    test('computes a negative trend correctly', () {
      final series = HistoricalRateSeries(
        baseCode: 'USD',
        quoteCode: 'PEN',
        points: [
          RatePoint(date: DateTime(2026, 7, 1), rate: 4.00),
          RatePoint(date: DateTime(2026, 7, 30), rate: 3.60),
        ],
      );

      expect(series.percentChange, closeTo((3.60 - 4.00) / 4.00 * 100, 1e-9));
      expect(series.isPositiveTrend, isFalse);
    });

    test('a single-point series has 0 percentChange and equal min/max', () {
      final series = HistoricalRateSeries(
        baseCode: 'USD',
        quoteCode: 'PEN',
        points: [RatePoint(date: DateTime(2026, 7, 15), rate: 3.71)],
      );

      expect(series.percentChange, 0);
      expect(series.minRate, 3.71);
      expect(series.maxRate, 3.71);
      expect(series.isPositiveTrend, isTrue);
    });

    test(
      'handles non-contiguous dates (non-trading-day gaps) without error',
      () {
        final series = HistoricalRateSeries(
          baseCode: 'USD',
          quoteCode: 'PEN',
          points: [
            RatePoint(date: DateTime(2026, 7, 3), rate: 3.70),
            // Weekend gap: no 2026-07-04/05 entries.
            RatePoint(date: DateTime(2026, 7, 6), rate: 3.72),
            RatePoint(date: DateTime(2026, 7, 10), rate: 3.65),
          ],
        );

        expect(series.percentChange, closeTo((3.65 - 3.70) / 3.70 * 100, 1e-9));
        expect(series.minRate, 3.65);
        expect(series.maxRate, 3.72);
      },
    );
  });
}
