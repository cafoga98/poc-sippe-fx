import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/failure.dart';
import '../models/currency_dto.dart';
import '../models/rates_response_dto.dart';

@lazySingleton
class CurrencyRemoteDataSource {
  CurrencyRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<Either<Failure, List<CurrencyDto>>> getCurrencies() async {
    final result = await _apiClient.getCurrencies();
    return result.flatMap((json) {
      try {
        final dtos = json.entries
            .map(
              (entry) =>
                  CurrencyDto(code: entry.key, name: entry.value as String),
            )
            .toList();
        return Right(dtos);
      } catch (_) {
        return const Left(Failure.parsing());
      }
    });
  }

  Future<Either<Failure, RatesResponseDto>> getRates({
    required String base,
  }) async {
    final result = await _apiClient.getRates(base: base);
    return result.flatMap((json) {
      try {
        return Right(RatesResponseDto.fromJson(json));
      } catch (_) {
        return const Left(Failure.parsing());
      }
    });
  }
}
