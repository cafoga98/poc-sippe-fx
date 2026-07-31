// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_series_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSeriesResponseDto _$TimeSeriesResponseDtoFromJson(
  Map<String, dynamic> json,
) => _TimeSeriesResponseDto(
  amount: (json['amount'] as num).toDouble(),
  base: json['base'] as String,
  startDate: json['start_date'] as String,
  endDate: json['end_date'] as String,
  rates: (json['rates'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      k,
      (e as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    ),
  ),
);

Map<String, dynamic> _$TimeSeriesResponseDtoToJson(
  _TimeSeriesResponseDto instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'base': instance.base,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
  'rates': instance.rates,
};
