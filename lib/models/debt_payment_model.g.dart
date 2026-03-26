// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DebtPaymentModel _$DebtPaymentModelFromJson(Map<String, dynamic> json) =>
    _DebtPaymentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      debtId: json['debt_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      paidAt: DateTime.parse(json['paid_at'] as String),
      transactionId: json['transaction_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DebtPaymentModelToJson(_DebtPaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'debt_id': instance.debtId,
      'amount': instance.amount,
      'paid_at': instance.paidAt.toIso8601String(),
      'transaction_id': instance.transactionId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
