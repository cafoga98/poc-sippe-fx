import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'base_currency_store.dart';

const String appSettingsBoxName = 'app_settings';
const String selectedBaseCurrencyKey = 'selected_base_currency';
const String defaultBaseCurrencyCode = 'USD';

/// Hive-backed [BaseCurrencyStore] (Principle V). The `app_settings` box is
/// opened and registered with `get_it` during app bootstrap (see `main.dart`),
/// before `configureDependencies()` resolves this lazy singleton.
@LazySingleton(as: BaseCurrencyStore)
class HiveBaseCurrencyStore implements BaseCurrencyStore {
  HiveBaseCurrencyStore(this._box);

  final Box<String> _box;

  @override
  String read() =>
      _box.get(selectedBaseCurrencyKey, defaultValue: defaultBaseCurrencyCode)!;

  @override
  Future<void> save(String code) => _box.put(selectedBaseCurrencyKey, code);
}
