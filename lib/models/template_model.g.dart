// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateModel _$TemplateModelFromJson(Map<String, dynamic> json) =>
    _TemplateModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      categoryId: json['category_id'] as String?,
      accountId: json['account_id'] as String?,
      defaultAmount: (json['default_amount'] as num?)?.toDouble(),
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TemplateModelToJson(_TemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'icon': instance.icon,
      'category_id': instance.categoryId,
      'account_id': instance.accountId,
      'default_amount': instance.defaultAmount,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
