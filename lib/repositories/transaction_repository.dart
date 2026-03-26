import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final SupabaseClient _client;

  TransactionRepository(this._client);

  Future<List<TransactionModel>> getTransactions({
    int limit = 50,
    int offset = 0,
    String? accountId,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = _client.from('transactions').select();

    if (accountId != null) {
      query = query.eq('account_id', accountId);
    }
    if (type != null) {
      query = query.eq('type', type);
    }
    if (startDate != null) {
      query = query.gte('date', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('date', endDate.toIso8601String());
    }

    final data = await query
        .order('date', ascending: false)
        .range(offset, offset + limit - 1);
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<List<TransactionModel>> getRecentTransactions({int limit = 10}) async {
    final data = await _client
        .from('transactions')
        .select()
        .order('date', ascending: false)
        .limit(limit);
    return data.map((json) => TransactionModel.fromJson(json)).toList();
  }

  Future<void> createTransaction(Map<String, dynamic> transaction) async {
    await _client.from('transactions').insert(transaction);
  }

  Future<void> updateTransaction(String id, Map<String, dynamic> updates) async {
    await _client.from('transactions').update(updates).eq('id', id);
  }

  Future<void> deleteTransaction(String id) async {
    await _client.from('transactions').delete().eq('id', id);
  }

  Future<double> getTotalByType(String type, {DateTime? startDate, DateTime? endDate}) async {
    var query = _client.from('transactions').select('amount').eq('type', type);
    if (startDate != null) {
      query = query.gte('date', startDate.toIso8601String());
    }
    if (endDate != null) {
      query = query.lte('date', endDate.toIso8601String());
    }
    final data = await query;
    return data.fold<double>(0.0, (sum, row) => sum + (row['amount'] as num).toDouble());
  }
}
