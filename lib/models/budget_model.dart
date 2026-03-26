import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
abstract class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String month,
    @JsonKey(name: 'needs_amount') required double needsAmount,
    @JsonKey(name: 'wants_amount') required double wantsAmount,
    @JsonKey(name: 'savings_amount') required double savingsAmount,
    @JsonKey(name: 'debt_amount') @Default(0) double debtAmount,
    @JsonKey(name: 'income_ref') String? incomeRef,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);
}
