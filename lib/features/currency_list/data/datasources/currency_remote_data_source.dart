import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/failure.dart';
import '../models/currency_dto.dart';
import '../models/rate_entry_dto.dart';

@lazySingleton
class CurrencyRemoteDataSource {
  CurrencyRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<Either<Failure, List<CurrencyDto>>> getCurrencies() async {
    final result = await _apiClient.getCurrencies();
    return result.flatMap((list) {
      try {
        final dtos = list
            .map((item) => CurrencyDto.fromJson(item as Map<String, dynamic>))
            .toList();
        return Right(dtos);
      } catch (_) {
        return const Left(Failure.parsing());
      }
    });
  }

  Future<Either<Failure, List<RateEntryDto>>> getRates({
    required String base,
  }) async {
    final result = await _apiClient.getRates(base: base);
    return result.flatMap((list) {
      try {
        final dtos = list
            .map((item) => RateEntryDto.fromJson(item as Map<String, dynamic>))
            .toList();
        return Right(dtos);
      } catch (_) {
        return const Left(Failure.parsing());
      }
    });
  }
}
