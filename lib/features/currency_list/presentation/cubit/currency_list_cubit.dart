import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/settings/base_currency_store.dart';
import '../../domain/usecases/get_currency_rates.dart';
import 'currency_list_state.dart';

@injectable
class CurrencyListCubit extends Cubit<CurrencyListState> {
  CurrencyListCubit(this._getCurrencyRates, this._baseCurrencyStore)
    : super(const CurrencyListState.initial());

  final GetCurrencyRates _getCurrencyRates;
  final BaseCurrencyStore _baseCurrencyStore;

  /// Initial load — reads the persisted base currency then fetches rates.
  Future<void> load() => _fetch(baseCode: _baseCurrencyStore.read());

  /// Re-invokes the same call that populated (or failed to populate) the
  /// current state — used by the error state's retry action (FR-011).
  Future<void> refresh() {
    final lastBaseCode = state.mapOrNull(
      loaded: (s) => s.baseCode,
      staleData: (s) => s.baseCode,
    );
    return _fetch(baseCode: lastBaseCode ?? _baseCurrencyStore.read());
  }

  Future<void> _fetch({required String baseCode}) async {
    final previousRows = state.mapOrNull(
      loaded: (s) => s.rows,
      staleData: (s) => s.rows,
    );
    final previousQuery =
        state.mapOrNull(
          loaded: (s) => s.searchQuery,
          staleData: (s) => s.searchQuery,
        ) ??
        '';

    emit(const CurrencyListState.loading());

    final result = await _getCurrencyRates(baseCode: baseCode);

    result.match(
      (failure) {
        if (previousRows != null) {
          emit(
            CurrencyListState.staleData(
              rows: previousRows,
              baseCode: baseCode,
              searchQuery: previousQuery,
              lastFailure: failure,
            ),
          );
        } else {
          emit(CurrencyListState.error(failure: failure));
        }
      },
      (rows) => emit(
        CurrencyListState.loaded(
          rows: rows,
          baseCode: baseCode,
          searchQuery: '',
        ),
      ),
    );
  }
}
