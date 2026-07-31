// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rates_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatesResponseDto {

 double get amount; String get base; String get date; Map<String, double> get rates;
/// Create a copy of RatesResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatesResponseDtoCopyWith<RatesResponseDto> get copyWith => _$RatesResponseDtoCopyWithImpl<RatesResponseDto>(this as RatesResponseDto, _$identity);

  /// Serializes this RatesResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatesResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.rates, rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,date,const DeepCollectionEquality().hash(rates));

@override
String toString() {
  return 'RatesResponseDto(amount: $amount, base: $base, date: $date, rates: $rates)';
}


}

/// @nodoc
abstract mixin class $RatesResponseDtoCopyWith<$Res>  {
  factory $RatesResponseDtoCopyWith(RatesResponseDto value, $Res Function(RatesResponseDto) _then) = _$RatesResponseDtoCopyWithImpl;
@useResult
$Res call({
 double amount, String base, String date, Map<String, double> rates
});




}
/// @nodoc
class _$RatesResponseDtoCopyWithImpl<$Res>
    implements $RatesResponseDtoCopyWith<$Res> {
  _$RatesResponseDtoCopyWithImpl(this._self, this._then);

  final RatesResponseDto _self;
  final $Res Function(RatesResponseDto) _then;

/// Create a copy of RatesResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? base = null,Object? date = null,Object? rates = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [RatesResponseDto].
extension RatesResponseDtoPatterns on RatesResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatesResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatesResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatesResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _RatesResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatesResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _RatesResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String base,  String date,  Map<String, double> rates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatesResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String base,  String date,  Map<String, double> rates)  $default,) {final _that = this;
switch (_that) {
case _RatesResponseDto():
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String base,  String date,  Map<String, double> rates)?  $default,) {final _that = this;
switch (_that) {
case _RatesResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.date,_that.rates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatesResponseDto implements RatesResponseDto {
  const _RatesResponseDto({required this.amount, required this.base, required this.date, required final  Map<String, double> rates}): _rates = rates;
  factory _RatesResponseDto.fromJson(Map<String, dynamic> json) => _$RatesResponseDtoFromJson(json);

@override final  double amount;
@override final  String base;
@override final  String date;
 final  Map<String, double> _rates;
@override Map<String, double> get rates {
  if (_rates is EqualUnmodifiableMapView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rates);
}


/// Create a copy of RatesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatesResponseDtoCopyWith<_RatesResponseDto> get copyWith => __$RatesResponseDtoCopyWithImpl<_RatesResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatesResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatesResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._rates, _rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,date,const DeepCollectionEquality().hash(_rates));

@override
String toString() {
  return 'RatesResponseDto(amount: $amount, base: $base, date: $date, rates: $rates)';
}


}

/// @nodoc
abstract mixin class _$RatesResponseDtoCopyWith<$Res> implements $RatesResponseDtoCopyWith<$Res> {
  factory _$RatesResponseDtoCopyWith(_RatesResponseDto value, $Res Function(_RatesResponseDto) _then) = __$RatesResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 double amount, String base, String date, Map<String, double> rates
});




}
/// @nodoc
class __$RatesResponseDtoCopyWithImpl<$Res>
    implements _$RatesResponseDtoCopyWith<$Res> {
  __$RatesResponseDtoCopyWithImpl(this._self, this._then);

  final _RatesResponseDto _self;
  final $Res Function(_RatesResponseDto) _then;

/// Create a copy of RatesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? base = null,Object? date = null,Object? rates = null,}) {
  return _then(_RatesResponseDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}

// dart format on
