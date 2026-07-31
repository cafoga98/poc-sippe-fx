import 'package:flutter_test/flutter_test.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/entities/currency.dart';

void main() {
  group('Currency', () {
    test('accepts a valid 3-letter uppercase code', () {
      final currency = Currency(code: 'USD', name: 'US Dollar');

      expect(currency.code, 'USD');
      expect(currency.name, 'US Dollar');
    });

    test('rejects a lowercase code', () {
      expect(
        () => Currency(code: 'usd', name: 'US Dollar'),
        throwsArgumentError,
      );
    });

    test('rejects a code shorter than 3 letters', () {
      expect(
        () => Currency(code: 'US', name: 'US Dollar'),
        throwsArgumentError,
      );
    });

    test('rejects a code longer than 3 letters', () {
      expect(
        () => Currency(code: 'USDD', name: 'US Dollar'),
        throwsArgumentError,
      );
    });

    test('two currencies with the same code and name are equal', () {
      final a = Currency(code: 'USD', name: 'US Dollar');
      final b = Currency(code: 'USD', name: 'US Dollar');

      expect(a, b);
    });
  });
}
