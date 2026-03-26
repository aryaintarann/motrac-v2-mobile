import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String type,
    required double amount,
    required DateTime date,
    @JsonKey(name: 'category_id') String? categoryId,
    @JsonKey(name: 'account_id') required String accountId,
    @JsonKey(name: 'to_account_id') String? toAccountId,
    String? note,
    @JsonKey(name: 'debt_id') String? debtId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
