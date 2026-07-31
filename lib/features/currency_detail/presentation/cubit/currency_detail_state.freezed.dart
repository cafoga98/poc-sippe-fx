// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyDetailState()';
}


}

/// @nodoc
class $CurrencyDetailStateCopyWith<$Res>  {
$CurrencyDetailStateCopyWith(CurrencyDetailState _, $Res Function(CurrencyDetailState) __);
}


/// Adds pattern-matching-related methods to [CurrencyDetailState].
extension CurrencyDetailStatePatterns on CurrencyDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CurrencyDetailLoading value)?  loading,TResult Function( CurrencyDetailLoaded value)?  loaded,TResult Function( CurrencyDetailError value)?  error,TResult Function( CurrencyDetailStaleData value)?  staleData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CurrencyDetailLoading() when loading != null:
return loading(_that);case CurrencyDetailLoaded() when loaded != null:
return loaded(_that);case CurrencyDetailError() when error != null:
return error(_that);case CurrencyDetailStaleData() when staleData != null:
return staleData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CurrencyDetailLoading value)  loading,required TResult Function( CurrencyDetailLoaded value)  loaded,required TResult Function( CurrencyDetailError value)  error,required TResult Function( CurrencyDetailStaleData value)  staleData,}){
final _that = this;
switch (_that) {
case CurrencyDetailLoading():
return loading(_that);case CurrencyDetailLoaded():
return loaded(_that);case CurrencyDetailError():
return error(_that);case CurrencyDetailStaleData():
return staleData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CurrencyDetailLoading value)?  loading,TResult? Function( CurrencyDetailLoaded value)?  loaded,TResult? Function( CurrencyDetailError value)?  error,TResult? Function( CurrencyDetailStaleData value)?  staleData,}){
final _that = this;
switch (_that) {
case CurrencyDetailLoading() when loading != null:
return loading(_that);case CurrencyDetailLoaded() when loaded != null:
return loaded(_that);case CurrencyDetailError() when error != null:
return error(_that);case CurrencyDetailStaleData() when staleData != null:
return staleData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( HistoricalRateSeries series)?  loaded,TResult Function( Failure failure)?  error,TResult Function( HistoricalRateSeries series,  Failure lastFailure)?  staleData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CurrencyDetailLoading() when loading != null:
return loading();case CurrencyDetailLoaded() when loaded != null:
return loaded(_that.series);case CurrencyDetailError() when error != null:
return error(_that.failure);case CurrencyDetailStaleData() when staleData != null:
return staleData(_that.series,_that.lastFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( HistoricalRateSeries series)  loaded,required TResult Function( Failure failure)  error,required TResult Function( HistoricalRateSeries series,  Failure lastFailure)  staleData,}) {final _that = this;
switch (_that) {
case CurrencyDetailLoading():
return loading();case CurrencyDetailLoaded():
return loaded(_that.series);case CurrencyDetailError():
return error(_that.failure);case CurrencyDetailStaleData():
return staleData(_that.series,_that.lastFailure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( HistoricalRateSeries series)?  loaded,TResult? Function( Failure failure)?  error,TResult? Function( HistoricalRateSeries series,  Failure lastFailure)?  staleData,}) {final _that = this;
switch (_that) {
case CurrencyDetailLoading() when loading != null:
return loading();case CurrencyDetailLoaded() when loaded != null:
return loaded(_that.series);case CurrencyDetailError() when error != null:
return error(_that.failure);case CurrencyDetailStaleData() when staleData != null:
return staleData(_that.series,_that.lastFailure);case _:
  return null;

}
}

}

/// @nodoc


class CurrencyDetailLoading implements CurrencyDetailState {
  const CurrencyDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyDetailState.loading()';
}


}




/// @nodoc


class CurrencyDetailLoaded implements CurrencyDetailState {
  const CurrencyDetailLoaded({required this.series});
  

 final  HistoricalRateSeries series;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyDetailLoadedCopyWith<CurrencyDetailLoaded> get copyWith => _$CurrencyDetailLoadedCopyWithImpl<CurrencyDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailLoaded&&(identical(other.series, series) || other.series == series));
}


@override
int get hashCode => Object.hash(runtimeType,series);

@override
String toString() {
  return 'CurrencyDetailState.loaded(series: $series)';
}


}

/// @nodoc
abstract mixin class $CurrencyDetailLoadedCopyWith<$Res> implements $CurrencyDetailStateCopyWith<$Res> {
  factory $CurrencyDetailLoadedCopyWith(CurrencyDetailLoaded value, $Res Function(CurrencyDetailLoaded) _then) = _$CurrencyDetailLoadedCopyWithImpl;
@useResult
$Res call({
 HistoricalRateSeries series
});




}
/// @nodoc
class _$CurrencyDetailLoadedCopyWithImpl<$Res>
    implements $CurrencyDetailLoadedCopyWith<$Res> {
  _$CurrencyDetailLoadedCopyWithImpl(this._self, this._then);

  final CurrencyDetailLoaded _self;
  final $Res Function(CurrencyDetailLoaded) _then;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? series = null,}) {
  return _then(CurrencyDetailLoaded(
series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as HistoricalRateSeries,
  ));
}


}

/// @nodoc


class CurrencyDetailError implements CurrencyDetailState {
  const CurrencyDetailError({required this.failure});
  

 final  Failure failure;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyDetailErrorCopyWith<CurrencyDetailError> get copyWith => _$CurrencyDetailErrorCopyWithImpl<CurrencyDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CurrencyDetailState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CurrencyDetailErrorCopyWith<$Res> implements $CurrencyDetailStateCopyWith<$Res> {
  factory $CurrencyDetailErrorCopyWith(CurrencyDetailError value, $Res Function(CurrencyDetailError) _then) = _$CurrencyDetailErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$CurrencyDetailErrorCopyWithImpl<$Res>
    implements $CurrencyDetailErrorCopyWith<$Res> {
  _$CurrencyDetailErrorCopyWithImpl(this._self, this._then);

  final CurrencyDetailError _self;
  final $Res Function(CurrencyDetailError) _then;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CurrencyDetailError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class CurrencyDetailStaleData implements CurrencyDetailState {
  const CurrencyDetailStaleData({required this.series, required this.lastFailure});
  

 final  HistoricalRateSeries series;
 final  Failure lastFailure;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyDetailStaleDataCopyWith<CurrencyDetailStaleData> get copyWith => _$CurrencyDetailStaleDataCopyWithImpl<CurrencyDetailStaleData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyDetailStaleData&&(identical(other.series, series) || other.series == series)&&(identical(other.lastFailure, lastFailure) || other.lastFailure == lastFailure));
}


@override
int get hashCode => Object.hash(runtimeType,series,lastFailure);

@override
String toString() {
  return 'CurrencyDetailState.staleData(series: $series, lastFailure: $lastFailure)';
}


}

/// @nodoc
abstract mixin class $CurrencyDetailStaleDataCopyWith<$Res> implements $CurrencyDetailStateCopyWith<$Res> {
  factory $CurrencyDetailStaleDataCopyWith(CurrencyDetailStaleData value, $Res Function(CurrencyDetailStaleData) _then) = _$CurrencyDetailStaleDataCopyWithImpl;
@useResult
$Res call({
 HistoricalRateSeries series, Failure lastFailure
});




}
/// @nodoc
class _$CurrencyDetailStaleDataCopyWithImpl<$Res>
    implements $CurrencyDetailStaleDataCopyWith<$Res> {
  _$CurrencyDetailStaleDataCopyWithImpl(this._self, this._then);

  final CurrencyDetailStaleData _self;
  final $Res Function(CurrencyDetailStaleData) _then;

/// Create a copy of CurrencyDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? series = null,Object? lastFailure = null,}) {
  return _then(CurrencyDetailStaleData(
series: null == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as HistoricalRateSeries,lastFailure: null == lastFailure ? _self.lastFailure : lastFailure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
