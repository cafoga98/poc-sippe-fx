// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrencyListState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyListState()';
}


}

/// @nodoc
class $CurrencyListStateCopyWith<$Res>  {
$CurrencyListStateCopyWith(CurrencyListState _, $Res Function(CurrencyListState) __);
}


/// Adds pattern-matching-related methods to [CurrencyListState].
extension CurrencyListStatePatterns on CurrencyListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CurrencyListInitial value)?  initial,TResult Function( CurrencyListLoading value)?  loading,TResult Function( CurrencyListLoaded value)?  loaded,TResult Function( CurrencyListError value)?  error,TResult Function( CurrencyListStaleData value)?  staleData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CurrencyListInitial() when initial != null:
return initial(_that);case CurrencyListLoading() when loading != null:
return loading(_that);case CurrencyListLoaded() when loaded != null:
return loaded(_that);case CurrencyListError() when error != null:
return error(_that);case CurrencyListStaleData() when staleData != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CurrencyListInitial value)  initial,required TResult Function( CurrencyListLoading value)  loading,required TResult Function( CurrencyListLoaded value)  loaded,required TResult Function( CurrencyListError value)  error,required TResult Function( CurrencyListStaleData value)  staleData,}){
final _that = this;
switch (_that) {
case CurrencyListInitial():
return initial(_that);case CurrencyListLoading():
return loading(_that);case CurrencyListLoaded():
return loaded(_that);case CurrencyListError():
return error(_that);case CurrencyListStaleData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CurrencyListInitial value)?  initial,TResult? Function( CurrencyListLoading value)?  loading,TResult? Function( CurrencyListLoaded value)?  loaded,TResult? Function( CurrencyListError value)?  error,TResult? Function( CurrencyListStaleData value)?  staleData,}){
final _that = this;
switch (_that) {
case CurrencyListInitial() when initial != null:
return initial(_that);case CurrencyListLoading() when loading != null:
return loading(_that);case CurrencyListLoaded() when loaded != null:
return loaded(_that);case CurrencyListError() when error != null:
return error(_that);case CurrencyListStaleData() when staleData != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery)?  loaded,TResult Function( Failure failure)?  error,TResult Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery,  Failure lastFailure)?  staleData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CurrencyListInitial() when initial != null:
return initial();case CurrencyListLoading() when loading != null:
return loading();case CurrencyListLoaded() when loaded != null:
return loaded(_that.rows,_that.baseCode,_that.searchQuery);case CurrencyListError() when error != null:
return error(_that.failure);case CurrencyListStaleData() when staleData != null:
return staleData(_that.rows,_that.baseCode,_that.searchQuery,_that.lastFailure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery)  loaded,required TResult Function( Failure failure)  error,required TResult Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery,  Failure lastFailure)  staleData,}) {final _that = this;
switch (_that) {
case CurrencyListInitial():
return initial();case CurrencyListLoading():
return loading();case CurrencyListLoaded():
return loaded(_that.rows,_that.baseCode,_that.searchQuery);case CurrencyListError():
return error(_that.failure);case CurrencyListStaleData():
return staleData(_that.rows,_that.baseCode,_that.searchQuery,_that.lastFailure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery)?  loaded,TResult? Function( Failure failure)?  error,TResult? Function( List<CurrencyRowData> rows,  String baseCode,  String searchQuery,  Failure lastFailure)?  staleData,}) {final _that = this;
switch (_that) {
case CurrencyListInitial() when initial != null:
return initial();case CurrencyListLoading() when loading != null:
return loading();case CurrencyListLoaded() when loaded != null:
return loaded(_that.rows,_that.baseCode,_that.searchQuery);case CurrencyListError() when error != null:
return error(_that.failure);case CurrencyListStaleData() when staleData != null:
return staleData(_that.rows,_that.baseCode,_that.searchQuery,_that.lastFailure);case _:
  return null;

}
}

}

/// @nodoc


class CurrencyListInitial implements CurrencyListState {
  const CurrencyListInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyListState.initial()';
}


}




/// @nodoc


class CurrencyListLoading implements CurrencyListState {
  const CurrencyListLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CurrencyListState.loading()';
}


}




/// @nodoc


class CurrencyListLoaded implements CurrencyListState {
  const CurrencyListLoaded({required final  List<CurrencyRowData> rows, required this.baseCode, required this.searchQuery}): _rows = rows;
  

 final  List<CurrencyRowData> _rows;
 List<CurrencyRowData> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

 final  String baseCode;
 final  String searchQuery;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyListLoadedCopyWith<CurrencyListLoaded> get copyWith => _$CurrencyListLoadedCopyWithImpl<CurrencyListLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListLoaded&&const DeepCollectionEquality().equals(other._rows, _rows)&&(identical(other.baseCode, baseCode) || other.baseCode == baseCode)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows),baseCode,searchQuery);

@override
String toString() {
  return 'CurrencyListState.loaded(rows: $rows, baseCode: $baseCode, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $CurrencyListLoadedCopyWith<$Res> implements $CurrencyListStateCopyWith<$Res> {
  factory $CurrencyListLoadedCopyWith(CurrencyListLoaded value, $Res Function(CurrencyListLoaded) _then) = _$CurrencyListLoadedCopyWithImpl;
@useResult
$Res call({
 List<CurrencyRowData> rows, String baseCode, String searchQuery
});




}
/// @nodoc
class _$CurrencyListLoadedCopyWithImpl<$Res>
    implements $CurrencyListLoadedCopyWith<$Res> {
  _$CurrencyListLoadedCopyWithImpl(this._self, this._then);

  final CurrencyListLoaded _self;
  final $Res Function(CurrencyListLoaded) _then;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? baseCode = null,Object? searchQuery = null,}) {
  return _then(CurrencyListLoaded(
rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<CurrencyRowData>,baseCode: null == baseCode ? _self.baseCode : baseCode // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CurrencyListError implements CurrencyListState {
  const CurrencyListError({required this.failure});
  

 final  Failure failure;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyListErrorCopyWith<CurrencyListError> get copyWith => _$CurrencyListErrorCopyWithImpl<CurrencyListError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListError&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CurrencyListState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $CurrencyListErrorCopyWith<$Res> implements $CurrencyListStateCopyWith<$Res> {
  factory $CurrencyListErrorCopyWith(CurrencyListError value, $Res Function(CurrencyListError) _then) = _$CurrencyListErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$CurrencyListErrorCopyWithImpl<$Res>
    implements $CurrencyListErrorCopyWith<$Res> {
  _$CurrencyListErrorCopyWithImpl(this._self, this._then);

  final CurrencyListError _self;
  final $Res Function(CurrencyListError) _then;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(CurrencyListError(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class CurrencyListStaleData implements CurrencyListState {
  const CurrencyListStaleData({required final  List<CurrencyRowData> rows, required this.baseCode, required this.searchQuery, required this.lastFailure}): _rows = rows;
  

 final  List<CurrencyRowData> _rows;
 List<CurrencyRowData> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

 final  String baseCode;
 final  String searchQuery;
 final  Failure lastFailure;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrencyListStaleDataCopyWith<CurrencyListStaleData> get copyWith => _$CurrencyListStaleDataCopyWithImpl<CurrencyListStaleData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrencyListStaleData&&const DeepCollectionEquality().equals(other._rows, _rows)&&(identical(other.baseCode, baseCode) || other.baseCode == baseCode)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.lastFailure, lastFailure) || other.lastFailure == lastFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_rows),baseCode,searchQuery,lastFailure);

@override
String toString() {
  return 'CurrencyListState.staleData(rows: $rows, baseCode: $baseCode, searchQuery: $searchQuery, lastFailure: $lastFailure)';
}


}

/// @nodoc
abstract mixin class $CurrencyListStaleDataCopyWith<$Res> implements $CurrencyListStateCopyWith<$Res> {
  factory $CurrencyListStaleDataCopyWith(CurrencyListStaleData value, $Res Function(CurrencyListStaleData) _then) = _$CurrencyListStaleDataCopyWithImpl;
@useResult
$Res call({
 List<CurrencyRowData> rows, String baseCode, String searchQuery, Failure lastFailure
});




}
/// @nodoc
class _$CurrencyListStaleDataCopyWithImpl<$Res>
    implements $CurrencyListStaleDataCopyWith<$Res> {
  _$CurrencyListStaleDataCopyWithImpl(this._self, this._then);

  final CurrencyListStaleData _self;
  final $Res Function(CurrencyListStaleData) _then;

/// Create a copy of CurrencyListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rows = null,Object? baseCode = null,Object? searchQuery = null,Object? lastFailure = null,}) {
  return _then(CurrencyListStaleData(
rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<CurrencyRowData>,baseCode: null == baseCode ? _self.baseCode : baseCode // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,lastFailure: null == lastFailure ? _self.lastFailure : lastFailure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
