// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_series_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeSeriesResponseDto {

 double get amount; String get base;@JsonKey(name: 'start_date') String get startDate;@JsonKey(name: 'end_date') String get endDate; Map<String, Map<String, double>> get rates;
/// Create a copy of TimeSeriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSeriesResponseDtoCopyWith<TimeSeriesResponseDto> get copyWith => _$TimeSeriesResponseDtoCopyWithImpl<TimeSeriesResponseDto>(this as TimeSeriesResponseDto, _$identity);

  /// Serializes this TimeSeriesResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSeriesResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.rates, rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,startDate,endDate,const DeepCollectionEquality().hash(rates));

@override
String toString() {
  return 'TimeSeriesResponseDto(amount: $amount, base: $base, startDate: $startDate, endDate: $endDate, rates: $rates)';
}


}

/// @nodoc
abstract mixin class $TimeSeriesResponseDtoCopyWith<$Res>  {
  factory $TimeSeriesResponseDtoCopyWith(TimeSeriesResponseDto value, $Res Function(TimeSeriesResponseDto) _then) = _$TimeSeriesResponseDtoCopyWithImpl;
@useResult
$Res call({
 double amount, String base,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String endDate, Map<String, Map<String, double>> rates
});




}
/// @nodoc
class _$TimeSeriesResponseDtoCopyWithImpl<$Res>
    implements $TimeSeriesResponseDtoCopyWith<$Res> {
  _$TimeSeriesResponseDtoCopyWithImpl(this._self, this._then);

  final TimeSeriesResponseDto _self;
  final $Res Function(TimeSeriesResponseDto) _then;

/// Create a copy of TimeSeriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? base = null,Object? startDate = null,Object? endDate = null,Object? rates = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self.rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double>>,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeSeriesResponseDto].
extension TimeSeriesResponseDtoPatterns on TimeSeriesResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeSeriesResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeSeriesResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeSeriesResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _TimeSeriesResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeSeriesResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _TimeSeriesResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String base, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String endDate,  Map<String, Map<String, double>> rates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeSeriesResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.startDate,_that.endDate,_that.rates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String base, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String endDate,  Map<String, Map<String, double>> rates)  $default,) {final _that = this;
switch (_that) {
case _TimeSeriesResponseDto():
return $default(_that.amount,_that.base,_that.startDate,_that.endDate,_that.rates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String base, @JsonKey(name: 'start_date')  String startDate, @JsonKey(name: 'end_date')  String endDate,  Map<String, Map<String, double>> rates)?  $default,) {final _that = this;
switch (_that) {
case _TimeSeriesResponseDto() when $default != null:
return $default(_that.amount,_that.base,_that.startDate,_that.endDate,_that.rates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeSeriesResponseDto implements TimeSeriesResponseDto {
  const _TimeSeriesResponseDto({required this.amount, required this.base, @JsonKey(name: 'start_date') required this.startDate, @JsonKey(name: 'end_date') required this.endDate, required final  Map<String, Map<String, double>> rates}): _rates = rates;
  factory _TimeSeriesResponseDto.fromJson(Map<String, dynamic> json) => _$TimeSeriesResponseDtoFromJson(json);

@override final  double amount;
@override final  String base;
@override@JsonKey(name: 'start_date') final  String startDate;
@override@JsonKey(name: 'end_date') final  String endDate;
 final  Map<String, Map<String, double>> _rates;
@override Map<String, Map<String, double>> get rates {
  if (_rates is EqualUnmodifiableMapView) return _rates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rates);
}


/// Create a copy of TimeSeriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeSeriesResponseDtoCopyWith<_TimeSeriesResponseDto> get copyWith => __$TimeSeriesResponseDtoCopyWithImpl<_TimeSeriesResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeSeriesResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeSeriesResponseDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.base, base) || other.base == base)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._rates, _rates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,base,startDate,endDate,const DeepCollectionEquality().hash(_rates));

@override
String toString() {
  return 'TimeSeriesResponseDto(amount: $amount, base: $base, startDate: $startDate, endDate: $endDate, rates: $rates)';
}


}

/// @nodoc
abstract mixin class _$TimeSeriesResponseDtoCopyWith<$Res> implements $TimeSeriesResponseDtoCopyWith<$Res> {
  factory _$TimeSeriesResponseDtoCopyWith(_TimeSeriesResponseDto value, $Res Function(_TimeSeriesResponseDto) _then) = __$TimeSeriesResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 double amount, String base,@JsonKey(name: 'start_date') String startDate,@JsonKey(name: 'end_date') String endDate, Map<String, Map<String, double>> rates
});




}
/// @nodoc
class __$TimeSeriesResponseDtoCopyWithImpl<$Res>
    implements _$TimeSeriesResponseDtoCopyWith<$Res> {
  __$TimeSeriesResponseDtoCopyWithImpl(this._self, this._then);

  final _TimeSeriesResponseDto _self;
  final $Res Function(_TimeSeriesResponseDto) _then;

/// Create a copy of TimeSeriesResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? base = null,Object? startDate = null,Object? endDate = null,Object? rates = null,}) {
  return _then(_TimeSeriesResponseDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,base: null == base ? _self.base : base // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,rates: null == rates ? _self._rates : rates // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, double>>,
  ));
}


}

// dart format on
