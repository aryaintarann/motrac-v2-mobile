// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReconciliationModel _$ReconciliationModelFromJson(Map<String, dynamic> json) =>
    _ReconciliationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      accountId: json['account_id'] as String,
      actualBalance: (json['actual_balance'] as num).toDouble(),
      appBalance: (json['app_balance'] as num).toDouble(),
      adjustment: (json['adjustment'] as num).toDouble(),
      reconciledAt: json['reconciled_at'] == null
          ? null
          : DateTime.parse(json['reconciled_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReconciliationModelToJson(
  _ReconciliationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'account_id': instance.accountId,
  'actual_balance': instance.actualBalance,
  'app_balance': instance.appBalance,
  'adjustment': instance.adjustment,
  'reconciled_at': instance.reconciledAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
