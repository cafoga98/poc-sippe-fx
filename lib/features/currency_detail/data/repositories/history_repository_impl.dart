import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../../domain/entities/historical_rate_series.dart';
import '../../domain/entities/rate_point.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_remote_data_source.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._remoteDataSource);

  final HistoryRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, HistoricalRateSeries>> getThirtyDayHistory({
    required String baseCode,
    required String quoteCode,
    DateTime? asOfDate,
  }) async {
    final result = await _remoteDataSource.getThirtyDayHistory(
      base: baseCode,
      quote: quoteCode,
      asOfDate: asOfDate,
    );

    return result.map((entries) {
      final points =
          entries
              .map(
                (entry) => RatePoint(
                  date: DateTime.parse(entry.date),
                  rate: entry.rate,
                ),
              )
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

      return HistoricalRateSeries(
        baseCode: baseCode,
        quoteCode: quoteCode,
        points: points,
      );
    });
  }
}
