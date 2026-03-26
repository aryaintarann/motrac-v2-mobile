import 'package:freezed_annotation/freezed_annotation.dart';

part 'debt_payment_model.freezed.dart';
part 'debt_payment_model.g.dart';

@freezed
abstract class DebtPaymentModel with _$DebtPaymentModel {
  const factory DebtPaymentModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'debt_id') required String debtId,
    required double amount,
    @JsonKey(name: 'paid_at') required DateTime paidAt,
    @JsonKey(name: 'transaction_id') String? transactionId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _DebtPaymentModel;

  factory DebtPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$DebtPaymentModelFromJson(json);
}
