import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/historical_rate_series.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/entities/rate_point.dart';
import 'package:poc_sippe_fx/features/currency_detail/domain/usecases/get_historical_rate_series.dart';
import 'package:poc_sippe_fx/features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import 'package:poc_sippe_fx/features/currency_detail/presentation/cubit/currency_detail_state.dart';

class MockGetHistoricalRateSeries extends Mock
    implements GetHistoricalRateSeries {}

void main() {
  late MockGetHistoricalRateSeries getHistoricalRateSeries;

  final series = HistoricalRateSeries(
    baseCode: 'USD',
    quoteCode: 'PEN',
    points: [RatePoint(date: DateTime(2026, 7, 30), rate: 3.71)],
  );

  setUp(() {
    getHistoricalRateSeries = MockGetHistoricalRateSeries();
  });

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'load(): loading -> loaded on success',
    build: () {
      when(
        () => getHistoricalRateSeries(baseCode: 'USD', quoteCode: 'PEN'),
      ).thenAnswer((_) async => Right(series));
      return CurrencyDetailCubit(getHistoricalRateSeries);
    },
    act: (cubit) => cubit.load(baseCode: 'USD', quoteCode: 'PEN'),
    expect: () => [
      const CurrencyDetailState.loading(),
      CurrencyDetailState.loaded(series: series),
    ],
  );

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'load(): loading -> error on failure with no prior data',
    build: () {
      when(
        () => getHistoricalRateSeries(baseCode: 'USD', quoteCode: 'PEN'),
      ).thenAnswer((_) async => const Left(Failure.network()));
      return CurrencyDetailCubit(getHistoricalRateSeries);
    },
    act: (cubit) => cubit.load(baseCode: 'USD', quoteCode: 'PEN'),
    expect: () => const [
      CurrencyDetailState.loading(),
      CurrencyDetailState.error(failure: Failure.network()),
    ],
  );

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'refresh(): loaded -> loading -> staleData when the refresh fails, keeping the prior series',
    build: () {
      when(
        () => getHistoricalRateSeries(baseCode: 'USD', quoteCode: 'PEN'),
      ).thenAnswer((_) async => Right(series));
      return CurrencyDetailCubit(getHistoricalRateSeries);
    },
    act: (cubit) async {
      await cubit.load(baseCode: 'USD', quoteCode: 'PEN');
      when(
        () => getHistoricalRateSeries(baseCode: 'USD', quoteCode: 'PEN'),
      ).thenAnswer((_) async => const Left(Failure.server(500)));
      await cubit.refresh();
    },
    expect: () => [
      const CurrencyDetailState.loading(),
      CurrencyDetailState.loaded(series: series),
      const CurrencyDetailState.loading(),
      CurrencyDetailState.staleData(
        series: series,
        lastFailure: const Failure.server(500),
      ),
    ],
  );
}
