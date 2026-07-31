// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateEntryDto _$RateEntryDtoFromJson(Map<String, dynamic> json) =>
    _RateEntryDto(
      date: json['date'] as String,
      base: json['base'] as String,
      quote: json['quote'] as String,
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$RateEntryDtoToJson(_RateEntryDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'base': instance.base,
      'quote': instance.quote,
      'rate': instance.rate,
    };
