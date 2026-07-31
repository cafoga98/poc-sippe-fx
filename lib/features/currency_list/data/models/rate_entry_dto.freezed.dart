// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rate_entry_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RateEntryDto {

 String get date; String get base; String get quote; double get rate;
/// Create a copy of RateEntryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateEntryDtoCopyWith<RateEntryDto> get copyWith => _$RateEntryDtoCopyWithImpl<RateEntryDto>(this as RateEntryDto, _$identity);

  /// Serializes this RateEntryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateEntryDto&&(identical(other.date, date) || other.date == date)&&(identical(other.base, base) || other.base == base)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,base,quote,rate);

@override
String toString() {
  return 'RateEntryDto(date: $date, base: $base, quote: $quote, rate: $rate)';
}


}

/// @nodoc
abstract mixin class $RateEntryDtoCopyWith<$Res>  {
  factory $RateEntryDtoCopyWith(RateEntryDto value, $Res Function(RateEntryDto) _then) = _$RateEntryDtoCopyWithImpl;
@useResult
$Res call({
 String date, String base, String quote, double rate
});




}
/// @nodoc
class _$RateEntryDtoCopyWithImpl<$Res>
    implements $RateEntryDtoCopyWith<$Res> {
  _$RateEntryDtoCopyWithImpl(this._self, this._then);

  final RateEntryDto _self;
  final $Res Function(RateEntryDto) _then;

/// Create a copy of RateEntryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? base = null,Object? quote = null,Object? rate = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RateEntryDto].
extension RateEntryDtoPatterns on RateEntryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateEntryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateEntryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateEntryDto value)  $default,){
final _that = this;
switch (_that) {
case _RateEntryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateEntryDto value)?  $default,){
final _that = this;
switch (_that) {
case _RateEntryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String base,  String quote,  double rate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateEntryDto() when $default != null:
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String base,  String quote,  double rate)  $default,) {final _that = this;
switch (_that) {
case _RateEntryDto():
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String base,  String quote,  double rate)?  $default,) {final _that = this;
switch (_that) {
case _RateEntryDto() when $default != null:
return $default(_that.date,_that.base,_that.quote,_that.rate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateEntryDto implements RateEntryDto {
  const _RateEntryDto({required this.date, required this.base, required this.quote, required this.rate});
  factory _RateEntryDto.fromJson(Map<String, dynamic> json) => _$RateEntryDtoFromJson(json);

@override final  String date;
@override final  String base;
@override final  String quote;
@override final  double rate;

/// Create a copy of RateEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateEntryDtoCopyWith<_RateEntryDto> get copyWith => __$RateEntryDtoCopyWithImpl<_RateEntryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateEntryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateEntryDto&&(identical(other.date, date) || other.date == date)&&(identical(other.base, base) || other.base == base)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.rate, rate) || other.rate == rate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,base,quote,rate);

@override
String toString() {
  return 'RateEntryDto(date: $date, base: $base, quote: $quote, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$RateEntryDtoCopyWith<$Res> implements $RateEntryDtoCopyWith<$Res> {
  factory _$RateEntryDtoCopyWith(_RateEntryDto value, $Res Function(_RateEntryDto) _then) = __$RateEntryDtoCopyWithImpl;
@override @useResult
$Res call({
 String date, String base, String quote, double rate
});




}
/// @nodoc
class __$RateEntryDtoCopyWithImpl<$Res>
    implements _$RateEntryDtoCopyWith<$Res> {
  __$RateEntryDtoCopyWithImpl(this._self, this._then);

  final _RateEntryDto _self;
  final $Res Function(_RateEntryDto) _then;

/// Create a copy of RateEntryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? base = null,Object? quote = null,Object? rate = null,}) {
  return _then(_RateEntryDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as String,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
