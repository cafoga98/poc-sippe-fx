import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entities/historical_rate_series.dart';

abstract class HistoryRepository {
  /// 30-day daily series for [quoteCode] against [baseCode].
  /// [asOfDate] is injectable (defaults to `DateTime.now()`) so tests can pin "today".
  Future<Either<Failure, HistoricalRateSeries>> getThirtyDayHistory({
    required String baseCode,
    required String quoteCode,
    DateTime? asOfDate,
  });
}
