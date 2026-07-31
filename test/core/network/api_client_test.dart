import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poc_sippe_fx/core/network/api_client.dart';
import 'package:poc_sippe_fx/core/network/failure.dart';

class MockDio extends Mock implements Dio {}

Response<dynamic> _responseWith(
  dynamic data, {
  int statusCode = 200,
  String path = 'x',
}) {
  return Response<dynamic>(
    data: data,
    statusCode: statusCode,
    requestOptions: RequestOptions(path: path),
  );
}

void main() {
  late MockDio dio;
  late ApiClient client;

  setUp(() {
    dio = MockDio();
    client = ApiClient(dio);
  });

  group('getCurrencies', () {
    test('maps a 2xx response to Right with the decoded body', () async {
      final payload = {'USD': 'US Dollar', 'EUR': 'Euro'};
      when(
        () => dio.get<dynamic>(
          'currencies',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _responseWith(payload));

      final result = await client.getCurrencies();

      expect(result, Right<Failure, Map<String, dynamic>>(payload));
    });

    test('maps a non-2xx response to Failure.server', () async {
      when(
        () => dio.get<dynamic>(
          'currencies',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'currencies'),
          type: DioExceptionType.badResponse,
          response: _responseWith(null, statusCode: 500),
        ),
      );

      final result = await client.getCurrencies();

      expect(
        result,
        const Left<Failure, Map<String, dynamic>>(Failure.server(500)),
      );
    });

    test('maps a connection timeout to Failure.network', () async {
      when(
        () => dio.get<dynamic>(
          'currencies',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'currencies'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await client.getCurrencies();

      expect(
        result,
        const Left<Failure, Map<String, dynamic>>(Failure.network()),
      );
    });

    test('maps a malformed (non-map) JSON body to Failure.parsing', () async {
      when(
        () => dio.get<dynamic>(
          'currencies',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _responseWith(['not', 'a', 'map']));

      final result = await client.getCurrencies();

      expect(
        result,
        const Left<Failure, Map<String, dynamic>>(Failure.parsing()),
      );
    });
  });

  group('getRates', () {
    test(
      'passes base as a query parameter and maps a 2xx response to Right',
      () async {
        final payload = {
          'amount': 1.0,
          'base': 'USD',
          'date': '2026-07-30',
          'rates': {'EUR': 0.92},
        };
        when(
          () => dio.get<dynamic>('rates', queryParameters: {'base': 'USD'}),
        ).thenAnswer((_) async => _responseWith(payload));

        final result = await client.getRates(base: 'USD');

        expect(result, Right<Failure, Map<String, dynamic>>(payload));
        verify(
          () => dio.get<dynamic>('rates', queryParameters: {'base': 'USD'}),
        ).called(1);
      },
    );

    test('maps a receive timeout to Failure.network', () async {
      when(
        () => dio.get<dynamic>(
          'rates',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'rates'),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      final result = await client.getRates(base: 'USD');

      expect(
        result,
        const Left<Failure, Map<String, dynamic>>(Failure.network()),
      );
    });
  });

  group('getTimeSeries', () {
    test(
      'passes base/quotes/from as query parameters and maps a 2xx response to Right',
      () async {
        final payload = {
          'amount': 1.0,
          'base': 'USD',
          'start_date': '2026-07-01',
          'end_date': '2026-07-30',
          'rates': {
            '2026-07-01': {'PEN': 3.71},
          },
        };
        when(
          () => dio.get<dynamic>(
            'rates',
            queryParameters: {
              'base': 'USD',
              'quotes': 'PEN',
              'from': '2026-07-01',
            },
          ),
        ).thenAnswer((_) async => _responseWith(payload));

        final result = await client.getTimeSeries(
          base: 'USD',
          quotes: 'PEN',
          from: '2026-07-01',
        );

        expect(result, Right<Failure, Map<String, dynamic>>(payload));
      },
    );

    test(
      'maps a non-2xx response to Failure.server with the status code',
      () async {
        when(
          () => dio.get<dynamic>(
            'rates',
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'rates'),
            type: DioExceptionType.badResponse,
            response: _responseWith(null, statusCode: 404),
          ),
        );

        final result = await client.getTimeSeries(
          base: 'USD',
          quotes: 'PEN',
          from: '2026-07-01',
        );

        expect(
          result,
          const Left<Failure, Map<String, dynamic>>(Failure.server(404)),
        );
      },
    );
  });
}
