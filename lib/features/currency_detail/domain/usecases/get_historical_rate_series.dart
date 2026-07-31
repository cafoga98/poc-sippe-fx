import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/failure.dart';
import '../entities/historical_rate_series.dart';
import '../repositories/history_repository.dart';

@injectable
class GetHistoricalRateSeries {
  GetHistoricalRateSeries(this._repository);

  final HistoryRepository _repository;

  Future<Either<Failure, HistoricalRateSeries>> call({
    required String baseCode,
    required String quoteCode,
    DateTime? asOfDate,
  }) async {
    final result = await _repository.getThirtyDayHistory(
      baseCode: baseCode,
      quoteCode: quoteCode,
      asOfDate: asOfDate,
    );

    return result.flatMap((series) {
      if (series.points.isEmpty) {
        return const Left(Failure.noData());
      }
      return Right(series);
    });
  }
}
