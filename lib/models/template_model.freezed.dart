// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get name; String? get icon;@JsonKey(name: 'category_id') String? get categoryId;@JsonKey(name: 'account_id') String? get accountId;@JsonKey(name: 'default_amount') double? get defaultAmount;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of TemplateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateModelCopyWith<TemplateModel> get copyWith => _$TemplateModelCopyWithImpl<TemplateModel>(this as TemplateModel, _$identity);

  /// Serializes this TemplateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.defaultAmount, defaultAmount) || other.defaultAmount == defaultAmount)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,icon,categoryId,accountId,defaultAmount,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'TemplateModel(id: $id, userId: $userId, name: $name, icon: $icon, categoryId: $categoryId, accountId: $accountId, defaultAmount: $defaultAmount, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TemplateModelCopyWith<$Res>  {
  factory $TemplateModelCopyWith(TemplateModel value, $Res Function(TemplateModel) _then) = _$TemplateModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name, String? icon,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'account_id') String? accountId,@JsonKey(name: 'default_amount') double? defaultAmount,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$TemplateModelCopyWithImpl<$Res>
    implements $TemplateModelCopyWith<$Res> {
  _$TemplateModelCopyWithImpl(this._self, this._then);

  final TemplateModel _self;
  final $Res Function(TemplateModel) _then;

/// Create a copy of TemplateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? icon = freezed,Object? categoryId = freezed,Object? accountId = freezed,Object? defaultAmount = freezed,Object? sortOrder = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,defaultAmount: freezed == defaultAmount ? _self.defaultAmount : defaultAmount // ignore: cast_nullable_to_non_nullable
as double?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateModel].
extension TemplateModelPatterns on TemplateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateModel value)  $default,){
final _that = this;
switch (_that) {
case _TemplateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateModel value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? icon, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'default_amount')  double? defaultAmount, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.categoryId,_that.accountId,_that.defaultAmount,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? icon, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'default_amount')  double? defaultAmount, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TemplateModel():
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.categoryId,_that.accountId,_that.defaultAmount,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String name,  String? icon, @JsonKey(name: 'category_id')  String? categoryId, @JsonKey(name: 'account_id')  String? accountId, @JsonKey(name: 'default_amount')  double? defaultAmount, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TemplateModel() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.icon,_that.categoryId,_that.accountId,_that.defaultAmount,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateModel implements TemplateModel {
  const _TemplateModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.name, this.icon, @JsonKey(name: 'category_id') this.categoryId, @JsonKey(name: 'account_id') this.accountId, @JsonKey(name: 'default_amount') this.defaultAmount, @JsonKey(name: 'sort_order') this.sortOrder = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _TemplateModel.fromJson(Map<String, dynamic> json) => _$TemplateModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String name;
@override final  String? icon;
@override@JsonKey(name: 'category_id') final  String? categoryId;
@override@JsonKey(name: 'account_id') final  String? accountId;
@override@JsonKey(name: 'default_amount') final  double? defaultAmount;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of TemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateModelCopyWith<_TemplateModel> get copyWith => __$TemplateModelCopyWithImpl<_TemplateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.defaultAmount, defaultAmount) || other.defaultAmount == defaultAmount)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,icon,categoryId,accountId,defaultAmount,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'TemplateModel(id: $id, userId: $userId, name: $name, icon: $icon, categoryId: $categoryId, accountId: $accountId, defaultAmount: $defaultAmount, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TemplateModelCopyWith<$Res> implements $TemplateModelCopyWith<$Res> {
  factory _$TemplateModelCopyWith(_TemplateModel value, $Res Function(_TemplateModel) _then) = __$TemplateModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String name, String? icon,@JsonKey(name: 'category_id') String? categoryId,@JsonKey(name: 'account_id') String? accountId,@JsonKey(name: 'default_amount') double? defaultAmount,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$TemplateModelCopyWithImpl<$Res>
    implements _$TemplateModelCopyWith<$Res> {
  __$TemplateModelCopyWithImpl(this._self, this._then);

  final _TemplateModel _self;
  final $Res Function(_TemplateModel) _then;

/// Create a copy of TemplateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? icon = freezed,Object? categoryId = freezed,Object? accountId = freezed,Object? defaultAmount = freezed,Object? sortOrder = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_TemplateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,defaultAmount: freezed == defaultAmount ? _self.defaultAmount : defaultAmount // ignore: cast_nullable_to_non_nullable
as double?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
