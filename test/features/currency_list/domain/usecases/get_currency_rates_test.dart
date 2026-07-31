import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/entities/currency.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/entities/exchange_rate.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/repositories/currency_repository.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/usecases/get_currency_rates.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late MockCurrencyRepository repository;
  late GetCurrencyRates usecase;

  setUp(() {
    repository = MockCurrencyRepository();
    usecase = GetCurrencyRates(repository);
  });

  final currencies = [
    Currency(code: 'USD', name: 'US Dollar'),
    Currency(code: 'EUR', name: 'Euro'),
    Currency(code: 'JPY', name: 'Japanese Yen'),
  ];

  final rates = [
    ExchangeRate(
      baseCode: 'USD',
      quoteCode: 'USD',
      rate: 1.0,
      asOf: DateTime(2026, 7, 30),
    ),
    ExchangeRate(
      baseCode: 'USD',
      quoteCode: 'EUR',
      rate: 0.92,
      asOf: DateTime(2026, 7, 30),
    ),
    ExchangeRate(
      baseCode: 'USD',
      quoteCode: 'JPY',
      rate: 150.2,
      asOf: DateTime(2026, 7, 30),
    ),
  ];

  test('joins currencies and rates by code into CurrencyRowData', () async {
    when(
      () => repository.getAvailableCurrencies(),
    ).thenAnswer((_) async => Right(currencies));
    when(
      () => repository.getLatestRates(baseCode: 'USD'),
    ).thenAnswer((_) async => Right(rates));

    final result = await usecase(baseCode: 'USD');

    expect(
      result.getOrElse((_) => []),
      equals(const [
        CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.0),
        CurrencyRowData(code: 'EUR', name: 'Euro', rate: 0.92),
        CurrencyRowData(code: 'JPY', name: 'Japanese Yen', rate: 150.2),
      ]),
    );
  });

  test(
    'propagates a Failure from getAvailableCurrencies without calling getLatestRates',
    () async {
      when(
        () => repository.getAvailableCurrencies(),
      ).thenAnswer((_) async => const Left(Failure.network()));

      final result = await usecase(baseCode: 'USD');

      expect(
        result,
        const Left<Failure, List<CurrencyRowData>>(Failure.network()),
      );
      verifyNever(
        () => repository.getLatestRates(baseCode: any(named: 'baseCode')),
      );
    },
  );

  test('propagates a Failure from getLatestRates', () async {
    when(
      () => repository.getAvailableCurrencies(),
    ).thenAnswer((_) async => Right(currencies));
    when(
      () => repository.getLatestRates(baseCode: 'USD'),
    ).thenAnswer((_) async => const Left(Failure.server(500)));

    final result = await usecase(baseCode: 'USD');

    expect(
      result,
      const Left<Failure, List<CurrencyRowData>>(Failure.server(500)),
    );
  });
}
