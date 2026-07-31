import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/failure.dart';
import '../models/time_series_response_dto.dart';

@lazySingleton
class HistoryRemoteDataSource {
  HistoryRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<Either<Failure, TimeSeriesResponseDto>> getThirtyDayHistory({
    required String base,
    required String quote,
    DateTime? asOfDate,
  }) async {
    final referenceDate = asOfDate ?? DateTime.now();
    final from = referenceDate.subtract(const Duration(days: 30));

    final result = await _apiClient.getTimeSeries(
      base: base,
      quotes: quote,
      from: _formatDate(from),
    );

    return result.flatMap((json) {
      try {
        return Right(TimeSeriesResponseDto.fromJson(json));
      } catch (_) {
        return const Left(Failure.parsing());
      }
    });
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
