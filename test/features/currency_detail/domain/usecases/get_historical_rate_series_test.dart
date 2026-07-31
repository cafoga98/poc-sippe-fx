import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/historical_rate_series.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/rate_point.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/repositories/history_repository.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/usecases/get_historical_rate_series.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  late MockHistoryRepository repository;
  late GetHistoricalRateSeries usecase;

  setUp(() {
    repository = MockHistoryRepository();
    usecase = GetHistoricalRateSeries(repository);
  });

  test('returns the series unchanged when points is non-empty', () async {
    final series = HistoricalRateSeries(
      baseCode: 'USD',
      quoteCode: 'PEN',
      points: [RatePoint(date: DateTime(2026, 7, 30), rate: 3.71)],
    );
    when(
      () => repository.getThirtyDayHistory(baseCode: 'USD', quoteCode: 'PEN'),
    ).thenAnswer((_) async => Right(series));

    final result = await usecase(baseCode: 'USD', quoteCode: 'PEN');

    expect(result, Right<Failure, HistoricalRateSeries>(series));
  });

  test(
    'surfaces Failure.noData for an empty points list without touching derived getters',
    () async {
      final emptySeries = const HistoricalRateSeries(
        baseCode: 'USD',
        quoteCode: 'PEN',
        points: [],
      );
      when(
        () => repository.getThirtyDayHistory(baseCode: 'USD', quoteCode: 'PEN'),
      ).thenAnswer((_) async => Right(emptySeries));

      final result = await usecase(baseCode: 'USD', quoteCode: 'PEN');

      expect(
        result,
        const Left<Failure, HistoricalRateSeries>(Failure.noData()),
      );
    },
  );

  test('propagates a Failure from the repository unchanged', () async {
    when(
      () => repository.getThirtyDayHistory(baseCode: 'USD', quoteCode: 'PEN'),
    ).thenAnswer((_) async => const Left(Failure.network()));

    final result = await usecase(baseCode: 'USD', quoteCode: 'PEN');

    expect(
      result,
      const Left<Failure, HistoricalRateSeries>(Failure.network()),
    );
  });
}
