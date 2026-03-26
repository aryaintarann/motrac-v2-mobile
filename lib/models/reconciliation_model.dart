import 'package:freezed_annotation/freezed_annotation.dart';

part 'reconciliation_model.freezed.dart';
part 'reconciliation_model.g.dart';

@freezed
abstract class ReconciliationModel with _$ReconciliationModel {
  const factory ReconciliationModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'account_id') required String accountId,
    @JsonKey(name: 'actual_balance') required double actualBalance,
    @JsonKey(name: 'app_balance') required double appBalance,
    required double adjustment,
    @JsonKey(name: 'reconciled_at') DateTime? reconciledAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ReconciliationModel;

  factory ReconciliationModel.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationModelFromJson(json);
}
