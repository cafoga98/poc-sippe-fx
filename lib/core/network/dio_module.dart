import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

const String frankfurterBaseUrl = 'https://api.frankfurter.dev/v2/';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: frankfurterBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
}
