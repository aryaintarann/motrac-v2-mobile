// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reconciliation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReconciliationModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'account_id') String get accountId;@JsonKey(name: 'actual_balance') double get actualBalance;@JsonKey(name: 'app_balance') double get appBalance; double get adjustment;@JsonKey(name: 'reconciled_at') DateTime? get reconciledAt;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ReconciliationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReconciliationModelCopyWith<ReconciliationModel> get copyWith => _$ReconciliationModelCopyWithImpl<ReconciliationModel>(this as ReconciliationModel, _$identity);

  /// Serializes this ReconciliationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReconciliationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.actualBalance, actualBalance) || other.actualBalance == actualBalance)&&(identical(other.appBalance, appBalance) || other.appBalance == appBalance)&&(identical(other.adjustment, adjustment) || other.adjustment == adjustment)&&(identical(other.reconciledAt, reconciledAt) || other.reconciledAt == reconciledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,actualBalance,appBalance,adjustment,reconciledAt,createdAt,updatedAt);

@override
String toString() {
  return 'ReconciliationModel(id: $id, userId: $userId, accountId: $accountId, actualBalance: $actualBalance, appBalance: $appBalance, adjustment: $adjustment, reconciledAt: $reconciledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReconciliationModelCopyWith<$Res>  {
  factory $ReconciliationModelCopyWith(ReconciliationModel value, $Res Function(ReconciliationModel) _then) = _$ReconciliationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'actual_balance') double actualBalance,@JsonKey(name: 'app_balance') double appBalance, double adjustment,@JsonKey(name: 'reconciled_at') DateTime? reconciledAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ReconciliationModelCopyWithImpl<$Res>
    implements $ReconciliationModelCopyWith<$Res> {
  _$ReconciliationModelCopyWithImpl(this._self, this._then);

  final ReconciliationModel _self;
  final $Res Function(ReconciliationModel) _then;

/// Create a copy of ReconciliationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accountId = null,Object? actualBalance = null,Object? appBalance = null,Object? adjustment = null,Object? reconciledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,actualBalance: null == actualBalance ? _self.actualBalance : actualBalance // ignore: cast_nullable_to_non_nullable
as double,appBalance: null == appBalance ? _self.appBalance : appBalance // ignore: cast_nullable_to_non_nullable
as double,adjustment: null == adjustment ? _self.adjustment : adjustment // ignore: cast_nullable_to_non_nullable
as double,reconciledAt: freezed == reconciledAt ? _self.reconciledAt : reconciledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReconciliationModel].
extension ReconciliationModelPatterns on ReconciliationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReconciliationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReconciliationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReconciliationModel value)  $default,){
final _that = this;
switch (_that) {
case _ReconciliationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReconciliationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReconciliationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'actual_balance')  double actualBalance, @JsonKey(name: 'app_balance')  double appBalance,  double adjustment, @JsonKey(name: 'reconciled_at')  DateTime? reconciledAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReconciliationModel() when $default != null:
return $default(_that.id,_that.userId,_that.accountId,_that.actualBalance,_that.appBalance,_that.adjustment,_that.reconciledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'actual_balance')  double actualBalance, @JsonKey(name: 'app_balance')  double appBalance,  double adjustment, @JsonKey(name: 'reconciled_at')  DateTime? reconciledAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReconciliationModel():
return $default(_that.id,_that.userId,_that.accountId,_that.actualBalance,_that.appBalance,_that.adjustment,_that.reconciledAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'account_id')  String accountId, @JsonKey(name: 'actual_balance')  double actualBalance, @JsonKey(name: 'app_balance')  double appBalance,  double adjustment, @JsonKey(name: 'reconciled_at')  DateTime? reconciledAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReconciliationModel() when $default != null:
return $default(_that.id,_that.userId,_that.accountId,_that.actualBalance,_that.appBalance,_that.adjustment,_that.reconciledAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReconciliationModel implements ReconciliationModel {
  const _ReconciliationModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'account_id') required this.accountId, @JsonKey(name: 'actual_balance') required this.actualBalance, @JsonKey(name: 'app_balance') required this.appBalance, required this.adjustment, @JsonKey(name: 'reconciled_at') this.reconciledAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _ReconciliationModel.fromJson(Map<String, dynamic> json) => _$ReconciliationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'account_id') final  String accountId;
@override@JsonKey(name: 'actual_balance') final  double actualBalance;
@override@JsonKey(name: 'app_balance') final  double appBalance;
@override final  double adjustment;
@override@JsonKey(name: 'reconciled_at') final  DateTime? reconciledAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ReconciliationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReconciliationModelCopyWith<_ReconciliationModel> get copyWith => __$ReconciliationModelCopyWithImpl<_ReconciliationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReconciliationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReconciliationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.actualBalance, actualBalance) || other.actualBalance == actualBalance)&&(identical(other.appBalance, appBalance) || other.appBalance == appBalance)&&(identical(other.adjustment, adjustment) || other.adjustment == adjustment)&&(identical(other.reconciledAt, reconciledAt) || other.reconciledAt == reconciledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,actualBalance,appBalance,adjustment,reconciledAt,createdAt,updatedAt);

@override
String toString() {
  return 'ReconciliationModel(id: $id, userId: $userId, accountId: $accountId, actualBalance: $actualBalance, appBalance: $appBalance, adjustment: $adjustment, reconciledAt: $reconciledAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReconciliationModelCopyWith<$Res> implements $ReconciliationModelCopyWith<$Res> {
  factory _$ReconciliationModelCopyWith(_ReconciliationModel value, $Res Function(_ReconciliationModel) _then) = __$ReconciliationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'account_id') String accountId,@JsonKey(name: 'actual_balance') double actualBalance,@JsonKey(name: 'app_balance') double appBalance, double adjustment,@JsonKey(name: 'reconciled_at') DateTime? reconciledAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ReconciliationModelCopyWithImpl<$Res>
    implements _$ReconciliationModelCopyWith<$Res> {
  __$ReconciliationModelCopyWithImpl(this._self, this._then);

  final _ReconciliationModel _self;
  final $Res Function(_ReconciliationModel) _then;

/// Create a copy of ReconciliationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountId = null,Object? actualBalance = null,Object? appBalance = null,Object? adjustment = null,Object? reconciledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ReconciliationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,actualBalance: null == actualBalance ? _self.actualBalance : actualBalance // ignore: cast_nullable_to_non_nullable
as double,appBalance: null == appBalance ? _self.appBalance : appBalance // ignore: cast_nullable_to_non_nullable
as double,adjustment: null == adjustment ? _self.adjustment : adjustment // ignore: cast_nullable_to_non_nullable
as double,reconciledAt: freezed == reconciledAt ? _self.reconciledAt : reconciledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
