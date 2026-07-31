import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_entry_dto.freezed.dart';
part 'rate_entry_dto.g.dart';

/// One entry of GET /v2/rates?base={base}'s array response
/// (`[{date, base, quote, rate}, ...]`) — one entry per quote currency,
/// including the base-against-itself entry (`quote == base`, `rate: 1.0`).
@freezed
abstract class RateEntryDto with _$RateEntryDto {
  const factory RateEntryDto({
    required String date,
    required String base,
    required String quote,
    required double rate,
  }) = _RateEntryDto;

  factory RateEntryDto.fromJson(Map<String, dynamic> json) =>
      _$RateEntryDtoFromJson(json);
}
