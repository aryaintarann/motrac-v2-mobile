import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/reconciliation_model.dart';

class ReconciliationRepository {
  final SupabaseClient _client;

  ReconciliationRepository(this._client);

  Future<List<ReconciliationModel>> getReconciliations({String? accountId}) async {
    var query = _client.from('account_reconciliations').select();
    if (accountId != null) {
      query = query.eq('account_id', accountId);
    }
    final data = await query.order('reconciled_at', ascending: false);
    return data.map((json) => ReconciliationModel.fromJson(json)).toList();
  }

  Future<void> createReconciliation(Map<String, dynamic> reconciliation) async {
    await _client.from('account_reconciliations').insert(reconciliation);
  }
}
