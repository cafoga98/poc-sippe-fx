/// The rate of one currency against the active base currency on the most
/// recent available date — the unit shown in each `CurrencyRow` (FR-003).
class ExchangeRate {
  const ExchangeRate({
    required this.baseCode,
    required this.quoteCode,
    required this.rate,
    required this.asOf,
  });

  /// The base currency active when this rate was fetched.
  final String baseCode;

  /// The currency this rate is *for* (matches a [Currency.code]).
  final String quoteCode;

  /// Units of [quoteCode] per 1 [baseCode]. `1.0` when `quoteCode == baseCode`.
  final double rate;

  /// Date Frankfurter published the rate for (may be a prior business day).
  final DateTime asOf;

  @override
  bool operator ==(Object other) =>
      other is ExchangeRate &&
      other.baseCode == baseCode &&
      other.quoteCode == quoteCode &&
      other.rate == rate &&
      other.asOf == asOf;

  @override
  int get hashCode => Object.hash(baseCode, quoteCode, rate, asOf);

  @override
  String toString() =>
      'ExchangeRate(baseCode: $baseCode, quoteCode: $quoteCode, rate: $rate, asOf: $asOf)';
}
