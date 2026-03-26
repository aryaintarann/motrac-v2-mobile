// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtPaymentModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'debt_id') String get debtId; double get amount;@JsonKey(name: 'paid_at') DateTime get paidAt;@JsonKey(name: 'transaction_id') String? get transactionId;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of DebtPaymentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtPaymentModelCopyWith<DebtPaymentModel> get copyWith => _$DebtPaymentModelCopyWithImpl<DebtPaymentModel>(this as DebtPaymentModel, _$identity);

  /// Serializes this DebtPaymentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtPaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,debtId,amount,paidAt,transactionId,createdAt,updatedAt);

@override
String toString() {
  return 'DebtPaymentModel(id: $id, userId: $userId, debtId: $debtId, amount: $amount, paidAt: $paidAt, transactionId: $transactionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DebtPaymentModelCopyWith<$Res>  {
  factory $DebtPaymentModelCopyWith(DebtPaymentModel value, $Res Function(DebtPaymentModel) _then) = _$DebtPaymentModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'debt_id') String debtId, double amount,@JsonKey(name: 'paid_at') DateTime paidAt,@JsonKey(name: 'transaction_id') String? transactionId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$DebtPaymentModelCopyWithImpl<$Res>
    implements $DebtPaymentModelCopyWith<$Res> {
  _$DebtPaymentModelCopyWithImpl(this._self, this._then);

  final DebtPaymentModel _self;
  final $Res Function(DebtPaymentModel) _then;

/// Create a copy of DebtPaymentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? debtId = null,Object? amount = null,Object? paidAt = null,Object? transactionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,debtId: null == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtPaymentModel].
extension DebtPaymentModelPatterns on DebtPaymentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtPaymentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtPaymentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtPaymentModel value)  $default,){
final _that = this;
switch (_that) {
case _DebtPaymentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtPaymentModel value)?  $default,){
final _that = this;
switch (_that) {
case _DebtPaymentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'debt_id')  String debtId,  double amount, @JsonKey(name: 'paid_at')  DateTime paidAt, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtPaymentModel() when $default != null:
return $default(_that.id,_that.userId,_that.debtId,_that.amount,_that.paidAt,_that.transactionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'debt_id')  String debtId,  double amount, @JsonKey(name: 'paid_at')  DateTime paidAt, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DebtPaymentModel():
return $default(_that.id,_that.userId,_that.debtId,_that.amount,_that.paidAt,_that.transactionId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'debt_id')  String debtId,  double amount, @JsonKey(name: 'paid_at')  DateTime paidAt, @JsonKey(name: 'transaction_id')  String? transactionId, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DebtPaymentModel() when $default != null:
return $default(_that.id,_that.userId,_that.debtId,_that.amount,_that.paidAt,_that.transactionId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtPaymentModel implements DebtPaymentModel {
  const _DebtPaymentModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'debt_id') required this.debtId, required this.amount, @JsonKey(name: 'paid_at') required this.paidAt, @JsonKey(name: 'transaction_id') this.transactionId, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _DebtPaymentModel.fromJson(Map<String, dynamic> json) => _$DebtPaymentModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'debt_id') final  String debtId;
@override final  double amount;
@override@JsonKey(name: 'paid_at') final  DateTime paidAt;
@override@JsonKey(name: 'transaction_id') final  String? transactionId;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of DebtPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtPaymentModelCopyWith<_DebtPaymentModel> get copyWith => __$DebtPaymentModelCopyWithImpl<_DebtPaymentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtPaymentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtPaymentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.debtId, debtId) || other.debtId == debtId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,debtId,amount,paidAt,transactionId,createdAt,updatedAt);

@override
String toString() {
  return 'DebtPaymentModel(id: $id, userId: $userId, debtId: $debtId, amount: $amount, paidAt: $paidAt, transactionId: $transactionId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DebtPaymentModelCopyWith<$Res> implements $DebtPaymentModelCopyWith<$Res> {
  factory _$DebtPaymentModelCopyWith(_DebtPaymentModel value, $Res Function(_DebtPaymentModel) _then) = __$DebtPaymentModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'debt_id') String debtId, double amount,@JsonKey(name: 'paid_at') DateTime paidAt,@JsonKey(name: 'transaction_id') String? transactionId,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$DebtPaymentModelCopyWithImpl<$Res>
    implements _$DebtPaymentModelCopyWith<$Res> {
  __$DebtPaymentModelCopyWithImpl(this._self, this._then);

  final _DebtPaymentModel _self;
  final $Res Function(_DebtPaymentModel) _then;

/// Create a copy of DebtPaymentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? debtId = null,Object? amount = null,Object? paidAt = null,Object? transactionId = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DebtPaymentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,debtId: null == debtId ? _self.debtId : debtId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
