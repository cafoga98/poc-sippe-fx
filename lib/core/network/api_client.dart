import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import 'failure.dart';

/// Thin, centralized Dio wrapper (Principle III) — every Frankfurter call
/// funnels through here and every response/error maps to `Either<Failure, T>`.
/// Callers get raw decoded JSON; DTOs (`data/models/`) own shape parsing.
@lazySingleton
class ApiClient {
  ApiClient(this._dio);

  final Dio _dio;

  Future<Either<Failure, Map<String, dynamic>>> getCurrencies() {
    return _get('currencies');
  }

  Future<Either<Failure, Map<String, dynamic>>> getRates({
    required String base,
  }) {
    return _get('rates', queryParameters: {'base': base});
  }

  Future<Either<Failure, Map<String, dynamic>>> getTimeSeries({
    required String base,
    required String quotes,
    required String from,
  }) {
    return _get(
      'rates',
      queryParameters: {'base': base, 'quotes': quotes, 'from': from},
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return Right(data);
      }
      return const Left(Failure.parsing());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Left(Failure.server(e.response?.statusCode ?? 0));
      }
      if (e.error is FormatException) {
        return const Left(Failure.parsing());
      }
      return const Left(Failure.network());
    } on FormatException {
      return const Left(Failure.parsing());
    }
  }
}
