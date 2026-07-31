import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/failure.dart';
import '../../domain/entities/historical_rate_series.dart';

part 'currency_detail_state.freezed.dart';

@freezed
sealed class CurrencyDetailState with _$CurrencyDetailState {
  const factory CurrencyDetailState.loading() = CurrencyDetailLoading;

  const factory CurrencyDetailState.loaded({
    required HistoricalRateSeries series,
  }) = CurrencyDetailLoaded;

  const factory CurrencyDetailState.error({required Failure failure}) =
      CurrencyDetailError;

  const factory CurrencyDetailState.staleData({
    required HistoricalRateSeries series,
    required Failure lastFailure,
  }) = CurrencyDetailStaleData;
}
