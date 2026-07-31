import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';
import 'package:poc_sippe_fx/features/currency_list/data/datasources/currency_remote_data_source.dart';
import 'package:poc_sippe_fx/features/currency_list/data/models/currency_dto.dart';
import 'package:poc_sippe_fx/features/currency_list/data/models/rates_response_dto.dart';
import 'package:poc_sippe_fx/features/currency_list/data/repositories/currency_repository_impl.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/entities/currency.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/entities/exchange_rate.dart';

class MockCurrencyRemoteDataSource extends Mock
    implements CurrencyRemoteDataSource {}

void main() {
  late MockCurrencyRemoteDataSource dataSource;
  late CurrencyRepositoryImpl repository;

  setUp(() {
    dataSource = MockCurrencyRemoteDataSource();
    repository = CurrencyRepositoryImpl(dataSource);
  });

  group('getAvailableCurrencies', () {
    test('maps CurrencyDto list to domain Currency list', () async {
      when(() => dataSource.getCurrencies()).thenAnswer(
        (_) async => const Right([
          CurrencyDto(code: 'USD', name: 'US Dollar'),
          CurrencyDto(code: 'EUR', name: 'Euro'),
        ]),
      );

      final result = await repository.getAvailableCurrencies();

      expect(
        result.getOrElse((_) => []),
        equals([
          Currency(code: 'USD', name: 'US Dollar'),
          Currency(code: 'EUR', name: 'Euro'),
        ]),
      );
    });

    test('passes a Failure through unchanged', () async {
      when(
        () => dataSource.getCurrencies(),
      ).thenAnswer((_) async => const Left(Failure.network()));

      final result = await repository.getAvailableCurrencies();

      expect(result, const Left<Failure, List<Currency>>(Failure.network()));
    });
  });

  group('getLatestRates', () {
    test(
      'synthesizes a rate: 1.0 self-entry for baseCode == quoteCode',
      () async {
        when(() => dataSource.getRates(base: 'USD')).thenAnswer(
          (_) async => const Right(
            RatesResponseDto(
              amount: 1.0,
              base: 'USD',
              date: '2026-07-30',
              rates: {'EUR': 0.92},
            ),
          ),
        );

        final result = await repository.getLatestRates(baseCode: 'USD');

        final rates = result.getOrElse((_) => []);
        expect(
          rates,
          containsAll([
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
          ]),
        );
      },
    );

    test('passes a Failure through unchanged', () async {
      when(
        () => dataSource.getRates(base: 'USD'),
      ).thenAnswer((_) async => const Left(Failure.server(500)));

      final result = await repository.getLatestRates(baseCode: 'USD');

      expect(
        result,
        const Left<Failure, List<ExchangeRate>>(Failure.server(500)),
      );
    });
  });
}
