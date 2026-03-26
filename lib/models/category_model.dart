import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? icon,
    required String type,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'budget_type') String? budgetType,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
