import 'package:injectable/injectable.dart';

import 'get_currency_rates.dart';

/// Pure, client-side, case-insensitive filter over the already-fetched rows
/// by code or name (FR-012–FR-014) — no network call per keystroke
/// (research.md §11).
@injectable
class FilterCurrencies {
  const FilterCurrencies();

  List<CurrencyRowData> call(List<CurrencyRowData> rows, String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return rows;
    return rows
        .where(
          (row) =>
              row.code.toLowerCase().contains(normalizedQuery) ||
              row.name.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }
}
