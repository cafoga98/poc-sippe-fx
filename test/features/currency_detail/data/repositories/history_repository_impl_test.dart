import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_detail/data/datasources/history_remote_data_source.dart';
import 'package:poc_sippe_fx/features/currency_detail/data/models/time_series_response_dto.dart';
import 'package:poc_sippe_fx/features/currency_detail/data/repositories/history_repository_impl.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/rate_point.dart';

class MockHistoryRemoteDataSource extends Mock
    implements HistoryRemoteDataSource {}

void main() {
  late MockHistoryRemoteDataSource dataSource;
  late HistoryRepositoryImpl repository;

  setUp(() {
    dataSource = MockHistoryRemoteDataSource();
    repository = HistoryRepositoryImpl(dataSource);
  });

  test('maps the date-keyed response into ascending RatePoints', () async {
    when(
      () => dataSource.getThirtyDayHistory(
        base: 'USD',
        quote: 'PEN',
        asOfDate: null,
      ),
    ).thenAnswer(
      (_) async => const Right(
        TimeSeriesResponseDto(
          amount: 1.0,
          base: 'USD',
          startDate: '2026-07-01',
          endDate: '2026-07-03',
          rates: {
            '2026-07-03': {'PEN': 3.72},
            '2026-07-01': {'PEN': 3.70},
            '2026-07-02': {'PEN': 3.71},
          },
        ),
      ),
    );

    final result = await repository.getThirtyDayHistory(
      baseCode: 'USD',
      quoteCode: 'PEN',
    );

    final series = result.getOrElse((_) => throw StateError('expected Right'));
    expect(series.baseCode, 'USD');
    expect(series.quoteCode, 'PEN');
    expect(
      series.points,
      equals([
        RatePoint(date: DateTime(2026, 7, 1), rate: 3.70),
        RatePoint(date: DateTime(2026, 7, 2), rate: 3.71),
        RatePoint(date: DateTime(2026, 7, 3), rate: 3.72),
      ]),
    );
  });

  test('passes a Failure through unchanged', () async {
    when(
      () => dataSource.getThirtyDayHistory(
        base: 'USD',
        quote: 'PEN',
        asOfDate: null,
      ),
    ).thenAnswer((_) async => const Left(Failure.server(500)));

    final result = await repository.getThirtyDayHistory(
      baseCode: 'USD',
      quoteCode: 'PEN',
    );

    expect(result.isLeft(), isTrue);
  });
}
