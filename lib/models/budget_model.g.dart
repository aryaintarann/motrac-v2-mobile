// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => _BudgetModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  month: json['month'] as String,
  needsAmount: (json['needs_amount'] as num).toDouble(),
  wantsAmount: (json['wants_amount'] as num).toDouble(),
  savingsAmount: (json['savings_amount'] as num).toDouble(),
  debtAmount: (json['debt_amount'] as num?)?.toDouble() ?? 0,
  incomeRef: json['income_ref'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$BudgetModelToJson(_BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'month': instance.month,
      'needs_amount': instance.needsAmount,
      'wants_amount': instance.wantsAmount,
      'savings_amount': instance.savingsAmount,
      'debt_amount': instance.debtAmount,
      'income_ref': instance.incomeRef,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
