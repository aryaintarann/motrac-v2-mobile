import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/account_model.dart';

class AccountRepository {
  final SupabaseClient _client;

  AccountRepository(this._client);

  Future<List<AccountModel>> getAccounts() async {
    final data = await _client
        .from('accounts')
        .select()
        .eq('is_archived', false)
        .order('created_at', ascending: true);
    return data.map((json) => AccountModel.fromJson(json)).toList();
  }

  Future<AccountModel> getAccount(String id) async {
    final data = await _client
        .from('accounts')
        .select()
        .eq('id', id)
        .single();
    return AccountModel.fromJson(data);
  }

  Future<void> createAccount(Map<String, dynamic> account) async {
    await _client.from('accounts').insert(account);
  }

  Future<void> updateAccount(String id, Map<String, dynamic> updates) async {
    await _client.from('accounts').update(updates).eq('id', id);
  }

  Future<void> archiveAccount(String id) async {
    await _client
        .from('accounts')
        .update({'is_archived': true})
        .eq('id', id);
  }

  Future<double> getTotalBalance() async {
    final accounts = await getAccounts();
    return accounts.fold<double>(0.0, (sum, account) => sum + account.balance);
  }
}
