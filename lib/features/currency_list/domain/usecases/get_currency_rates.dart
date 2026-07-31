import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../entities/currency.dart';
import '../entities/exchange_rate.dart';
import '../repositories/currency_repository.dart';

/// A row the currency list renders: code + name (from `getAvailableCurrencies`)
/// joined with the currency's rate against the active base (from `getLatestRates`).
class CurrencyRowData {
  const CurrencyRowData({
    required this.code,
    required this.name,
    required this.rate,
  });

  final String code;
  final String name;
  final double rate;

  @override
  bool operator ==(Object other) =>
      other is CurrencyRowData &&
      other.code == code &&
      other.name == name &&
      other.rate == rate;

  @override
  int get hashCode => Object.hash(code, name, rate);

  @override
  String toString() => 'CurrencyRowData(code: $code, name: $name, rate: $rate)';
}

@injectable
class GetCurrencyRates {
  GetCurrencyRates(this._repository);

  final CurrencyRepository _repository;

  Future<Either<Failure, List<CurrencyRowData>>> call({
    required String baseCode,
  }) async {
    final currenciesResult = await _repository.getAvailableCurrencies();
    if (currenciesResult case Left(value: final failure)) {
      return Left(failure);
    }
    final currencies =
        (currenciesResult as Right<Failure, List<Currency>>).value;

    final ratesResult = await _repository.getLatestRates(baseCode: baseCode);
    if (ratesResult case Left(value: final failure)) {
      return Left(failure);
    }
    final rates = (ratesResult as Right<Failure, List<ExchangeRate>>).value;

    final rateByCode = {for (final rate in rates) rate.quoteCode: rate.rate};
    final rows = currencies
        .where((currency) => rateByCode.containsKey(currency.code))
        .map(
          (currency) => CurrencyRowData(
            code: currency.code,
            name: currency.name,
            rate: rateByCode[currency.code]!,
          ),
        )
        .toList();

    return Right(rows);
  }
}
