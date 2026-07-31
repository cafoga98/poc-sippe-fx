import 'package:freezed_annotation/freezed_annotation.dart';

part 'rates_response_dto.freezed.dart';
part 'rates_response_dto.g.dart';

@freezed
abstract class RatesResponseDto with _$RatesResponseDto {
  const factory RatesResponseDto({
    required double amount,
    required String base,
    required String date,
    required Map<String, double> rates,
  }) = _RatesResponseDto;

  factory RatesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RatesResponseDtoFromJson(json);
}
