abstract class BaseCurrencyStore {
  /// Currently selected base currency code, `"USD"` if never set.
  String read();

  /// Persists [code] as the new base currency selection (Hive write, FR-002).
  Future<void> save(String code);
}
