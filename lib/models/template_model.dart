import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_model.freezed.dart';
part 'template_model.g.dart';

@freezed
abstract class TemplateModel with _$TemplateModel {
  const factory TemplateModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    String? icon,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'account_id') String? accountId,
    @JsonKey(name: 'default_amount') double? defaultAmount,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TemplateModel;

  factory TemplateModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateModelFromJson(json);
}
