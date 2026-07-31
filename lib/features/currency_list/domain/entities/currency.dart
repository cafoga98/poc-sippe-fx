/// Identified by ISO code; represents one fiat currency the app can display
/// or use as a base.
class Currency {
  factory Currency({required String code, required String name}) {
    if (!_isValidCode(code)) {
      throw ArgumentError.value(
        code,
        'code',
        'Currency code must be 3 uppercase letters',
      );
    }
    return Currency._(code: code, name: name);
  }

  const Currency._({required this.code, required this.name});

  /// ISO 4217, e.g. `"USD"`. Always 3 uppercase letters.
  final String code;

  /// Full display name, e.g. `"US Dollar"`.
  final String name;

  static bool _isValidCode(String code) =>
      code.length == 3 && code == code.toUpperCase();

  @override
  bool operator ==(Object other) =>
      other is Currency && other.code == code && other.name == name;

  @override
  int get hashCode => Object.hash(code, name);

  @override
  String toString() => 'Currency(code: $code, name: $name)';
}
