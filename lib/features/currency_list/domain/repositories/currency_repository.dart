import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entities/currency.dart';
import '../entities/exchange_rate.dart';

abstract class CurrencyRepository {
  /// All available fiat currencies (code + name). Backed by GET /v2/currencies.
  Future<Either<Failure, List<Currency>>> getAvailableCurrencies();

  /// Today's rate of every available currency against [baseCode].
  /// Synthesizes a 1.0 self-rate entry for [baseCode] itself.
  Future<Either<Failure, List<ExchangeRate>>> getLatestRates({
    required String baseCode,
  });
}
