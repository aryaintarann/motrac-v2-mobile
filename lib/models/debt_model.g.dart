// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtModel _$DebtModelFromJson(Map<String, dynamic> json) => _DebtModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  direction: json['direction'] as String,
  counterparty: json['counterparty'] as String,
  principal: (json['principal'] as num).toDouble(),
  dueDate: json['due_date'] == null
      ? null
      : DateTime.parse(json['due_date'] as String),
  interestRate: (json['interest_rate'] as num?)?.toDouble(),
  accountId: json['account_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DebtModelToJson(_DebtModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'direction': instance.direction,
      'counterparty': instance.counterparty,
      'principal': instance.principal,
      'due_date': instance.dueDate?.toIso8601String(),
      'interest_rate': instance.interestRate,
      'account_id': instance.accountId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
