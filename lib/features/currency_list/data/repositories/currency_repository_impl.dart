import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../../domain/entities/currency.dart';
import '../../domain/entities/exchange_rate.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_remote_data_source.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._remoteDataSource);

  final CurrencyRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Currency>>> getAvailableCurrencies() async {
    final result = await _remoteDataSource.getCurrencies();
    return result.map(
      (dtos) =>
          dtos.map((dto) => Currency(code: dto.code, name: dto.name)).toList(),
    );
  }

  @override
  Future<Either<Failure, List<ExchangeRate>>> getLatestRates({
    required String baseCode,
  }) async {
    final result = await _remoteDataSource.getRates(base: baseCode);
    return result.map((dto) {
      final asOf = DateTime.parse(dto.date);
      final rates = dto.rates.entries
          .map(
            (entry) => ExchangeRate(
              baseCode: baseCode,
              quoteCode: entry.key,
              rate: entry.value,
              asOf: asOf,
            ),
          )
          .toList();
      rates.add(
        ExchangeRate(
          baseCode: baseCode,
          quoteCode: baseCode,
          rate: 1.0,
          asOf: asOf,
        ),
      );
      return rates;
    });
  }
}
