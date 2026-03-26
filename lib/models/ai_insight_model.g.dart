// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_insight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiInsightModel _$AiInsightModelFromJson(Map<String, dynamic> json) =>
    _AiInsightModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      period: json['period'] as String,
      thumbsUp: json['thumbs_up'] as bool?,
      thumbsDown: json['thumbs_down'] as bool?,
      generatedAt: json['generated_at'] == null
          ? null
          : DateTime.parse(json['generated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AiInsightModelToJson(_AiInsightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'type': instance.type,
      'content': instance.content,
      'period': instance.period,
      'thumbs_up': instance.thumbsUp,
      'thumbs_down': instance.thumbsDown,
      'generated_at': instance.generatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
