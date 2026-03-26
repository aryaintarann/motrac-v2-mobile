// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get direction; String get counterparty; double get principal;@JsonKey(name: 'due_date') DateTime? get dueDate;@JsonKey(name: 'interest_rate') double? get interestRate;@JsonKey(name: 'account_id') String? get accountId;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtModelCopyWith<DebtModel> get copyWith => _$DebtModelCopyWithImpl<DebtModel>(this as DebtModel, _$identity);

  /// Serializes this DebtModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.counterparty, counterparty) || other.counterparty == counterparty)&&(identical(other.principal, principal) || other.principal == principal)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.interestRate, interestRate) || other.interestRate == interestRate)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,direction,counterparty,principal,dueDate,interestRate,accountId,createdAt,updatedAt);

@override
String toString() {
  return 'DebtModel(id: $id, userId: $userId, direction: $direction, counterparty: $counterparty, principal: $principal, dueDate: $dueDate, interestRate: $interestRate, accountId: $accountId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DebtModelCopyWith<$Res>  {
  factory $DebtModelCopyWith(DebtModel value, $Res Function(DebtModel) _then) = _$DebtModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String direction, String counterparty, double principal,@JsonKey(name: 'due_date') DateTime? dueDate,@JsonKey(name: 'interest_rate') double? interestRate,@JsonKey(name: 'account_id') String? accountId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$DebtModelCopyWithImpl<$Res>
    implements $DebtModelCopyWith<$Res> {
  _$DebtModelCopyWithImpl(this._self, this._then);

  final DebtModel _self;
  final $Res Function(DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? direction = null,Object? counterparty = null,Object? principal = null,Object? dueDate = freezed,Object? interestRate = freezed,Object? accountId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,counterparty: null == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String,principal: null == principal ? _self.principal : principal // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,interestRate: freezed == interestRate ? _self.interestRate : interestRate // ignore: cast_nullable_to_non_nullable
as double?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtModel].
extension DebtModelPatterns on DebtModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtModel value)  $default,){
final _that = this;
switch (_that) {
case _DebtModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtModel value)?  $default,){
final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String direction,  String counterparty,  double principal, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'interest_rate')  double? interestRate, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.direction,_that.counterparty,_that.principal,_that.dueDate,_that.interestRate,_that.accountId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String direction,  String counterparty,  double principal, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'interest_rate')  double? interestRate, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DebtModel():
return $default(_that.id,_that.userId,_that.direction,_that.counterparty,_that.principal,_that.dueDate,_that.interestRate,_that.accountId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String direction,  String counterparty,  double principal, @JsonKey(name: 'due_date')  DateTime? dueDate, @JsonKey(name: 'interest_rate')  double? interestRate, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DebtModel() when $default != null:
return $default(_that.id,_that.userId,_that.direction,_that.counterparty,_that.principal,_that.dueDate,_that.interestRate,_that.accountId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtModel implements DebtModel {
  const _DebtModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.direction, required this.counterparty, required this.principal, @JsonKey(name: 'due_date') this.dueDate, @JsonKey(name: 'interest_rate') this.interestRate, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _DebtModel.fromJson(Map<String, dynamic> json) => _$DebtModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String direction;
@override final  String counterparty;
@override final  double principal;
@override@JsonKey(name: 'due_date') final  DateTime? dueDate;
@override@JsonKey(name: 'interest_rate') final  double? interestRate;
@override@JsonKey(name: 'account_id') final  String? accountId;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtModelCopyWith<_DebtModel> get copyWith => __$DebtModelCopyWithImpl<_DebtModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.counterparty, counterparty) || other.counterparty == counterparty)&&(identical(other.principal, principal) || other.principal == principal)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.interestRate, interestRate) || other.interestRate == interestRate)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,direction,counterparty,principal,dueDate,interestRate,accountId,createdAt,updatedAt);

@override
String toString() {
  return 'DebtModel(id: $id, userId: $userId, direction: $direction, counterparty: $counterparty, principal: $principal, dueDate: $dueDate, interestRate: $interestRate, accountId: $accountId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DebtModelCopyWith<$Res> implements $DebtModelCopyWith<$Res> {
  factory _$DebtModelCopyWith(_DebtModel value, $Res Function(_DebtModel) _then) = __$DebtModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String direction, String counterparty, double principal,@JsonKey(name: 'due_date') DateTime? dueDate,@JsonKey(name: 'interest_rate') double? interestRate,@JsonKey(name: 'account_id') String? accountId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$DebtModelCopyWithImpl<$Res>
    implements _$DebtModelCopyWith<$Res> {
  __$DebtModelCopyWithImpl(this._self, this._then);

  final _DebtModel _self;
  final $Res Function(_DebtModel) _then;

/// Create a copy of DebtModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? direction = null,Object? counterparty = null,Object? principal = null,Object? dueDate = freezed,Object? interestRate = freezed,Object? accountId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DebtModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,counterparty: null == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String,principal: null == principal ? _self.principal : principal // ignore: cast_nullable_to_non_nullable
as double,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,interestRate: freezed == interestRate ? _self.interestRate : interestRate // ignore: cast_nullable_to_non_nullable
as double?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
