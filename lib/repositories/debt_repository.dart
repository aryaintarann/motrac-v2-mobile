import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/debt_model.dart';
import '../models/debt_payment_model.dart';

class DebtRepository {
  final SupabaseClient _client;

  DebtRepository(this._client);

  Future<List<DebtModel>> getDebts({String? direction}) async {
    var query = _client.from('debts').select();
    if (direction != null) {
      query = query.eq('direction', direction);
    }
    final data = await query.order('created_at', ascending: false);
    return data.map((json) => DebtModel.fromJson(json)).toList();
  }

  Future<void> createDebt(Map<String, dynamic> debt) async {
    await _client.from('debts').insert(debt);
  }

  Future<void> updateDebt(String id, Map<String, dynamic> updates) async {
    await _client.from('debts').update(updates).eq('id', id);
  }

  Future<void> deleteDebt(String id) async {
    await _client.from('debts').delete().eq('id', id);
  }

  Future<List<DebtPaymentModel>> getPayments(String debtId) async {
    final data = await _client
        .from('debt_payments')
        .select()
        .eq('debt_id', debtId)
        .order('paid_at', ascending: false);
    return data.map((json) => DebtPaymentModel.fromJson(json)).toList();
  }

  Future<void> addPayment(Map<String, dynamic> payment) async {
    await _client.from('debt_payments').insert(payment);
  }

  Future<double> getTotalPaid(String debtId) async {
    final payments = await getPayments(debtId);
    return payments.fold<double>(0.0, (sum, p) => sum + p.amount);
  }
}
