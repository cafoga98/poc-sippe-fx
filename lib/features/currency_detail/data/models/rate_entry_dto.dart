import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_entry_dto.freezed.dart';
part 'rate_entry_dto.g.dart';

/// One entry of GET /v2/rates?base={base}&quotes={quote}&from={date}'s array
/// response (`[{date, base, quote, rate}, ...]`) — one entry per date, for
/// the single requested quote currency. Kept as its own copy (not imported
/// from `currency_list`) to keep the two features' data layers independent
/// per plan.md's Structure Decision (only domain entities are shared).
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
