import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/budget_model.dart';

class BudgetRepository {
  final SupabaseClient _client;

  BudgetRepository(this._client);

  Future<List<BudgetModel>> getBudgets() async {
    final data = await _client
        .from('budgets')
        .select()
        .order('month', ascending: false);
    return data.map((json) => BudgetModel.fromJson(json)).toList();
  }

  Future<BudgetModel?> getBudgetByMonth(String month) async {
    final data = await _client
        .from('budgets')
        .select()
        .eq('month', month)
        .maybeSingle();
    if (data == null) return null;
    return BudgetModel.fromJson(data);
  }

  Future<void> upsertBudget(Map<String, dynamic> budget) async {
    await _client.from('budgets').upsert(budget, onConflict: 'user_id,month');
  }

  Future<void> deleteBudget(String id) async {
    await _client.from('budgets').delete().eq('id', id);
  }
}
