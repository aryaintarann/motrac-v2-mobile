import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_insight_model.freezed.dart';
part 'ai_insight_model.g.dart';

@freezed
abstract class AiInsightModel with _$AiInsightModel {
  const factory AiInsightModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type,
    required String content,
    required String period,
    @JsonKey(name: 'thumbs_up') bool? thumbsUp,
    @JsonKey(name: 'thumbs_down') bool? thumbsDown,
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _AiInsightModel;

  factory AiInsightModel.fromJson(Map<String, dynamic> json) =>
      _$AiInsightModelFromJson(json);
}
