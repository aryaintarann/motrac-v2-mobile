// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_insight_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiInsightModel {

 String get id;@JsonKey(name: 'user_id') String get userId; String get type; String get content; String get period;@JsonKey(name: 'thumbs_up') bool? get thumbsUp;@JsonKey(name: 'thumbs_down') bool? get thumbsDown;@JsonKey(name: 'generated_at') DateTime? get generatedAt;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of AiInsightModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiInsightModelCopyWith<AiInsightModel> get copyWith => _$AiInsightModelCopyWithImpl<AiInsightModel>(this as AiInsightModel, _$identity);

  /// Serializes this AiInsightModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiInsightModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.period, period) || other.period == period)&&(identical(other.thumbsUp, thumbsUp) || other.thumbsUp == thumbsUp)&&(identical(other.thumbsDown, thumbsDown) || other.thumbsDown == thumbsDown)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,content,period,thumbsUp,thumbsDown,generatedAt,createdAt,updatedAt);

@override
String toString() {
  return 'AiInsightModel(id: $id, userId: $userId, type: $type, content: $content, period: $period, thumbsUp: $thumbsUp, thumbsDown: $thumbsDown, generatedAt: $generatedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AiInsightModelCopyWith<$Res>  {
  factory $AiInsightModelCopyWith(AiInsightModel value, $Res Function(AiInsightModel) _then) = _$AiInsightModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String type, String content, String period,@JsonKey(name: 'thumbs_up') bool? thumbsUp,@JsonKey(name: 'thumbs_down') bool? thumbsDown,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$AiInsightModelCopyWithImpl<$Res>
    implements $AiInsightModelCopyWith<$Res> {
  _$AiInsightModelCopyWithImpl(this._self, this._then);

  final AiInsightModel _self;
  final $Res Function(AiInsightModel) _then;

/// Create a copy of AiInsightModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? content = null,Object? period = null,Object? thumbsUp = freezed,Object? thumbsDown = freezed,Object? generatedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,thumbsUp: freezed == thumbsUp ? _self.thumbsUp : thumbsUp // ignore: cast_nullable_to_non_nullable
as bool?,thumbsDown: freezed == thumbsDown ? _self.thumbsDown : thumbsDown // ignore: cast_nullable_to_non_nullable
as bool?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiInsightModel].
extension AiInsightModelPatterns on AiInsightModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiInsightModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiInsightModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiInsightModel value)  $default,){
final _that = this;
switch (_that) {
case _AiInsightModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiInsightModel value)?  $default,){
final _that = this;
switch (_that) {
case _AiInsightModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String type,  String content,  String period, @JsonKey(name: 'thumbs_up')  bool? thumbsUp, @JsonKey(name: 'thumbs_down')  bool? thumbsDown, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiInsightModel() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.content,_that.period,_that.thumbsUp,_that.thumbsDown,_that.generatedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId,  String type,  String content,  String period, @JsonKey(name: 'thumbs_up')  bool? thumbsUp, @JsonKey(name: 'thumbs_down')  bool? thumbsDown, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AiInsightModel():
return $default(_that.id,_that.userId,_that.type,_that.content,_that.period,_that.thumbsUp,_that.thumbsDown,_that.generatedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId,  String type,  String content,  String period, @JsonKey(name: 'thumbs_up')  bool? thumbsUp, @JsonKey(name: 'thumbs_down')  bool? thumbsDown, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AiInsightModel() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.content,_that.period,_that.thumbsUp,_that.thumbsDown,_that.generatedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiInsightModel implements AiInsightModel {
  const _AiInsightModel({required this.id, @JsonKey(name: 'user_id') required this.userId, required this.type, required this.content, required this.period, @JsonKey(name: 'thumbs_up') this.thumbsUp, @JsonKey(name: 'thumbs_down') this.thumbsDown, @JsonKey(name: 'generated_at') this.generatedAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _AiInsightModel.fromJson(Map<String, dynamic> json) => _$AiInsightModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  String type;
@override final  String content;
@override final  String period;
@override@JsonKey(name: 'thumbs_up') final  bool? thumbsUp;
@override@JsonKey(name: 'thumbs_down') final  bool? thumbsDown;
@override@JsonKey(name: 'generated_at') final  DateTime? generatedAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of AiInsightModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiInsightModelCopyWith<_AiInsightModel> get copyWith => __$AiInsightModelCopyWithImpl<_AiInsightModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiInsightModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiInsightModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.period, period) || other.period == period)&&(identical(other.thumbsUp, thumbsUp) || other.thumbsUp == thumbsUp)&&(identical(other.thumbsDown, thumbsDown) || other.thumbsDown == thumbsDown)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,content,period,thumbsUp,thumbsDown,generatedAt,createdAt,updatedAt);

@override
String toString() {
  return 'AiInsightModel(id: $id, userId: $userId, type: $type, content: $content, period: $period, thumbsUp: $thumbsUp, thumbsDown: $thumbsDown, generatedAt: $generatedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AiInsightModelCopyWith<$Res> implements $AiInsightModelCopyWith<$Res> {
  factory _$AiInsightModelCopyWith(_AiInsightModel value, $Res Function(_AiInsightModel) _then) = __$AiInsightModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId, String type, String content, String period,@JsonKey(name: 'thumbs_up') bool? thumbsUp,@JsonKey(name: 'thumbs_down') bool? thumbsDown,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$AiInsightModelCopyWithImpl<$Res>
    implements _$AiInsightModelCopyWith<$Res> {
  __$AiInsightModelCopyWithImpl(this._self, this._then);

  final _AiInsightModel _self;
  final $Res Function(_AiInsightModel) _then;

/// Create a copy of AiInsightModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? content = null,Object? period = null,Object? thumbsUp = freezed,Object? thumbsDown = freezed,Object? generatedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AiInsightModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,thumbsUp: freezed == thumbsUp ? _self.thumbsUp : thumbsUp // ignore: cast_nullable_to_non_nullable
as bool?,thumbsDown: freezed == thumbsDown ? _self.thumbsDown : thumbsDown // ignore: cast_nullable_to_non_nullable
as bool?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
