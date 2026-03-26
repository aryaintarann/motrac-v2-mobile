import 'package:freezed_annotation/freezed_annotation.dart';

part 'debt_model.freezed.dart';
part 'debt_model.g.dart';

@freezed
abstract class DebtModel with _$DebtModel {
  const factory DebtModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String direction,
    required String counterparty,
    required double principal,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'interest_rate') double? interestRate,
    @JsonKey(name: 'account_id') String? accountId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _DebtModel;

  factory DebtModel.fromJson(Map<String, dynamic> json) =>
      _$DebtModelFromJson(json);
}
