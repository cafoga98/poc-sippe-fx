import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_dto.freezed.dart';
part 'currency_dto.g.dart';

@freezed
abstract class CurrencyDto with _$CurrencyDto {
  const factory CurrencyDto({required String code, required String name}) =
      _CurrencyDto;

  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);
}
