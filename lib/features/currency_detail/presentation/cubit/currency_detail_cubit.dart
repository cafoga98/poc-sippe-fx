import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_historical_rate_series.dart';
import 'currency_detail_state.dart';

@injectable
class CurrencyDetailCubit extends Cubit<CurrencyDetailState> {
  CurrencyDetailCubit(this._getHistoricalRateSeries)
    : super(const CurrencyDetailState.loading());

  final GetHistoricalRateSeries _getHistoricalRateSeries;

  String? _baseCode;
  String? _quoteCode;

  /// Initial load — the base+quote pair is fixed at navigation time.
  Future<void> load({
    required String baseCode,
    required String quoteCode,
  }) async {
    _baseCode = baseCode;
    _quoteCode = quoteCode;
    await _fetch();
  }

  /// Re-invokes the same base+quote pair used by [load] — retry action (FR-011).
  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    final baseCode = _baseCode;
    final quoteCode = _quoteCode;
    if (baseCode == null || quoteCode == null) return;

    final previousSeries = state.mapOrNull(
      loaded: (s) => s.series,
      staleData: (s) => s.series,
    );

    emit(const CurrencyDetailState.loading());

    final result = await _getHistoricalRateSeries(
      baseCode: baseCode,
      quoteCode: quoteCode,
    );

    result.match((failure) {
      if (previousSeries != null) {
        emit(
          CurrencyDetailState.staleData(
            series: previousSeries,
            lastFailure: failure,
          ),
        );
      } else {
        emit(CurrencyDetailState.error(failure: failure));
      }
    }, (series) => emit(CurrencyDetailState.loaded(series: series)));
  }
}
