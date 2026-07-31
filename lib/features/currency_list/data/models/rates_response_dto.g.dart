// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatesResponseDto _$RatesResponseDtoFromJson(Map<String, dynamic> json) =>
    _RatesResponseDto(
      amount: (json['amount'] as num).toDouble(),
      base: json['base'] as String,
      date: json['date'] as String,
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$RatesResponseDtoToJson(_RatesResponseDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'base': instance.base,
      'date': instance.date,
      'rates': instance.rates,
    };
