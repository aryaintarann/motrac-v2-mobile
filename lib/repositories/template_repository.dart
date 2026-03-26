import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/template_model.dart';

class TemplateRepository {
  final SupabaseClient _client;

  TemplateRepository(this._client);

  Future<List<TemplateModel>> getTemplates() async {
    final data = await _client
        .from('templates')
        .select()
        .order('sort_order', ascending: true);
    return data.map((json) => TemplateModel.fromJson(json)).toList();
  }

  Future<void> createTemplate(Map<String, dynamic> template) async {
    await _client.from('templates').insert(template);
  }

  Future<void> deleteTemplate(String id) async {
    await _client.from('templates').delete().eq('id', id);
  }
}
