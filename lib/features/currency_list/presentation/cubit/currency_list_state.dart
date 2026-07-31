import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/failure.dart';
import '../../domain/usecases/get_currency_rates.dart';

part 'currency_list_state.freezed.dart';

@freezed
sealed class CurrencyListState with _$CurrencyListState {
  const factory CurrencyListState.initial() = CurrencyListInitial;

  const factory CurrencyListState.loading() = CurrencyListLoading;

  const factory CurrencyListState.loaded({
    required List<CurrencyRowData> rows,
    required String baseCode,
    required String searchQuery,
  }) = CurrencyListLoaded;

  const factory CurrencyListState.error({required Failure failure}) =
      CurrencyListError;

  const factory CurrencyListState.staleData({
    required List<CurrencyRowData> rows,
    required String baseCode,
    required String searchQuery,
    required Failure lastFailure,
  }) = CurrencyListStaleData;
}
