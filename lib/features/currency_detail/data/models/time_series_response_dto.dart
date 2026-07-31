import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_series_response_dto.freezed.dart';
part 'time_series_response_dto.g.dart';

@freezed
abstract class TimeSeriesResponseDto with _$TimeSeriesResponseDto {
  const factory TimeSeriesResponseDto({
    required double amount,
    required String base,
    @JsonKey(name: 'start_date') required String startDate,
    @JsonKey(name: 'end_date') required String endDate,
    required Map<String, Map<String, double>> rates,
  }) = _TimeSeriesResponseDto;

  factory TimeSeriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TimeSeriesResponseDtoFromJson(json);
}
