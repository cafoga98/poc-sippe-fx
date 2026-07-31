import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_dto.freezed.dart';
part 'currency_dto.g.dart';

/// Maps one entry of GET /v2/currencies's array response
/// (`[{iso_code, iso_numeric, name, symbol, start_date, end_date}, ...]`) —
/// only `code`/`name` are needed; the rest are ignored by fromJson.
@freezed
abstract class CurrencyDto with _$CurrencyDto {
  const factory CurrencyDto({
    @JsonKey(name: 'iso_code') required String code,
    required String name,
  }) = _CurrencyDto;

  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);
}
