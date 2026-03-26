// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BudgetModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get month;@JsonKey(name: 'needs_amount') double get needsAmount;@JsonKey(name: 'wants_amount') double get wantsAmount;@JsonKey(name: 'savings_amount') double get savingsAmount;@JsonKey(name: 'debt_amount') double get debtAmount;@JsonKey(name: 'income_ref') String? get incomeRef;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetModelCopyWith<BudgetModel> get copyWith => _$BudgetModelCopyWithImpl<BudgetModel>(this as BudgetModel, _$identity);

  /// Serializes this BudgetModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.month, month) || other.month == month)&&(identical(other.needsAmount, needsAmount) || other.needsAmount == needsAmount)&&(identical(other.wantsAmount, wantsAmount) || other.wantsAmount == wantsAmount)&&(identical(other.savingsAmount, savingsAmount) || other.savingsAmount == savingsAmount)&&(identical(other.debtAmount, debtAmount) || other.debtAmount == debtAmount)&&(identical(other.incomeRef, incomeRef) || other.incomeRef == incomeRef)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,month,needsAmount,wantsAmount,savingsAmount,debtAmount,incomeRef,createdAt,updatedAt);

@override
String toString() {
  return 'BudgetModel(id: $id, userId: $userId, month: $month, needsAmount: $needsAmount, wantsAmount: $wantsAmount, savingsAmount: $savingsAmount, debtAmount: $debtAmount, incomeRef: $incomeRef, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $BudgetModelCopyWith<$Res>  {
  factory $BudgetModelCopyWith(BudgetModel value, $Res Function(BudgetModel) _then) = _$BudgetModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String month,@JsonKey(name: 'needs_amount') double needsAmount,@JsonKey(name: 'wants_amount') double wantsAmount,@JsonKey(name: 'savings_amount') double savingsAmount,@JsonKey(name: 'debt_amount') double debtAmount,@JsonKey(name: 'income_ref') String? incomeRef,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$BudgetModelCopyWithImpl<$Res>
    implements $BudgetModelCopyWith<$Res> {
  _$BudgetModelCopyWithImpl(this._self, this._then);

  final BudgetModel _self;
  final $Res Function(BudgetModel) _then;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? month = null,Object? needsAmount = null,Object? wantsAmount = null,Object? savingsAmount = null,Object? debtAmount = null,Object? incomeRef = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,needsAmount: null == needsAmount ? _self.needsAmount : needsAmount // ignore: cast_nullable_to_non_nullable
as double,wantsAmount: null == wantsAmount ? _self.wantsAmount : wantsAmount // ignore: cast_nullable_to_non_nullable
as double,savingsAmount: null == savingsAmount ? _self.savingsAmount : savingsAmount // ignore: cast_nullable_to_non_nullable
as double,debtAmount: null == debtAmount ? _self.debtAmount : debtAmount // ignore: cast_nullable_to_non_nullable
as double,incomeRef: freezed == incomeRef ? _self.incomeRef : incomeRef // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetModel].
extension BudgetModelPatterns on BudgetModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetModel value)  $default,){
final _that = this;
switch (_that) {
case _BudgetModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetModel value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String month, @JsonKey(name: 'needs_amount')  double needsAmount, @JsonKey(name: 'wants_amount')  double wantsAmount, @JsonKey(name: 'savings_amount')  double savingsAmount, @JsonKey(name: 'debt_amount')  double debtAmount, @JsonKey(name: 'income_ref')  String? incomeRef, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
return $default(_that.id,_that.userId,_that.month,_that.needsAmount,_that.wantsAmount,_that.savingsAmount,_that.debtAmount,_that.incomeRef,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String month, @JsonKey(name: 'needs_amount')  double needsAmount, @JsonKey(name: 'wants_amount')  double wantsAmount, @JsonKey(name: 'savings_amount')  double savingsAmount, @JsonKey(name: 'debt_amount')  double debtAmount, @JsonKey(name: 'income_ref')  String? incomeRef, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _BudgetModel():
return $default(_that.id,_that.userId,_that.month,_that.needsAmount,_that.wantsAmount,_that.savingsAmount,_that.debtAmount,_that.incomeRef,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String month, @JsonKey(name: 'needs_amount')  double needsAmount, @JsonKey(name: 'wants_amount')  double wantsAmount, @JsonKey(name: 'savings_amount')  double savingsAmount, @JsonKey(name: 'debt_amount')  double debtAmount, @JsonKey(name: 'income_ref')  String? incomeRef, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _BudgetModel() when $default != null:
return $default(_that.id,_that.userId,_that.month,_that.needsAmount,_that.wantsAmount,_that.savingsAmount,_that.debtAmount,_that.incomeRef,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BudgetModel implements BudgetModel {
  const _BudgetModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.month, @JsonKey(name: 'needs_amount') required this.needsAmount, @JsonKey(name: 'wants_amount') required this.wantsAmount, @JsonKey(name: 'savings_amount') required this.savingsAmount, @JsonKey(name: 'debt_amount') this.debtAmount = 0, @JsonKey(name: 'income_ref') this.incomeRef, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _BudgetModel.fromJson(Map<String, dynamic> json) => _$BudgetModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String month;
@override@JsonKey(name: 'needs_amount') final  double needsAmount;
@override@JsonKey(name: 'wants_amount') final  double wantsAmount;
@override@JsonKey(name: 'savings_amount') final  double savingsAmount;
@override@JsonKey(name: 'debt_amount') final  double debtAmount;
@override@JsonKey(name: 'income_ref') final  String? incomeRef;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetModelCopyWith<_BudgetModel> get copyWith => __$BudgetModelCopyWithImpl<_BudgetModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BudgetModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.month, month) || other.month == month)&&(identical(other.needsAmount, needsAmount) || other.needsAmount == needsAmount)&&(identical(other.wantsAmount, wantsAmount) || other.wantsAmount == wantsAmount)&&(identical(other.savingsAmount, savingsAmount) || other.savingsAmount == savingsAmount)&&(identical(other.debtAmount, debtAmount) || other.debtAmount == debtAmount)&&(identical(other.incomeRef, incomeRef) || other.incomeRef == incomeRef)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,month,needsAmount,wantsAmount,savingsAmount,debtAmount,incomeRef,createdAt,updatedAt);

@override
String toString() {
  return 'BudgetModel(id: $id, userId: $userId, month: $month, needsAmount: $needsAmount, wantsAmount: $wantsAmount, savingsAmount: $savingsAmount, debtAmount: $debtAmount, incomeRef: $incomeRef, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$BudgetModelCopyWith<$Res> implements $BudgetModelCopyWith<$Res> {
  factory _$BudgetModelCopyWith(_BudgetModel value, $Res Function(_BudgetModel) _then) = __$BudgetModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String month,@JsonKey(name: 'needs_amount') double needsAmount,@JsonKey(name: 'wants_amount') double wantsAmount,@JsonKey(name: 'savings_amount') double savingsAmount,@JsonKey(name: 'debt_amount') double debtAmount,@JsonKey(name: 'income_ref') String? incomeRef,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$BudgetModelCopyWithImpl<$Res>
    implements _$BudgetModelCopyWith<$Res> {
  __$BudgetModelCopyWithImpl(this._self, this._then);

  final _BudgetModel _self;
  final $Res Function(_BudgetModel) _then;

/// Create a copy of BudgetModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? month = null,Object? needsAmount = null,Object? wantsAmount = null,Object? savingsAmount = null,Object? debtAmount = null,Object? incomeRef = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_BudgetModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String,needsAmount: null == needsAmount ? _self.needsAmount : needsAmount // ignore: cast_nullable_to_non_nullable
as double,wantsAmount: null == wantsAmount ? _self.wantsAmount : wantsAmount // ignore: cast_nullable_to_non_nullable
as double,savingsAmount: null == savingsAmount ? _self.savingsAmount : savingsAmount // ignore: cast_nullable_to_non_nullable
as double,debtAmount: null == debtAmount ? _self.debtAmount : debtAmount // ignore: cast_nullable_to_non_nullable
as double,incomeRef: freezed == incomeRef ? _self.incomeRef : incomeRef // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
