import 'package:flutter_test/flutter_test.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/usecases/filter_currencies.dart';
import 'package:poc_sippe_fx/features/currency_list/domain/usecases/get_currency_rates.dart';

void main() {
  const rows = [
    CurrencyRowData(code: 'USD', name: 'US Dollar', rate: 1.0),
    CurrencyRowData(code: 'EUR', name: 'Euro', rate: 0.92),
    CurrencyRowData(code: 'JPY', name: 'Japanese Yen', rate: 150.2),
  ];

  final filter = FilterCurrencies();

  test('empty query returns the full list', () {
    expect(filter(rows, ''), equals(rows));
  });

  test('whitespace-only query is treated as empty', () {
    expect(filter(rows, '   '), equals(rows));
  });

  test('matches by partial code, case-insensitively', () {
    expect(filter(rows, 'jp'), equals([rows[2]]));
    expect(filter(rows, 'JP'), equals([rows[2]]));
  });

  test('matches by partial name, case-insensitively', () {
    expect(filter(rows, 'yen'), equals([rows[2]]));
    expect(filter(rows, 'YEN'), equals([rows[2]]));
  });

  test('no match returns an empty list', () {
    expect(filter(rows, 'xyz'), isEmpty);
  });
}
