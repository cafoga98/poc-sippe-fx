// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrencyDto _$CurrencyDtoFromJson(Map<String, dynamic> json) => _CurrencyDto(
  code: json['iso_code'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$CurrencyDtoToJson(_CurrencyDto instance) =>
    <String, dynamic>{'iso_code': instance.code, 'name': instance.name};
