import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';

class CategoryRepository {
  final SupabaseClient _client;

  CategoryRepository(this._client);

  Future<List<CategoryModel>> getCategories({String? type}) async {
    var query = _client.from('categories').select();
    if (type != null) {
      query = query.eq('type', type);
    }
    final data = await query.order('name', ascending: true);
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<void> createCategory(Map<String, dynamic> category) async {
    await _client.from('categories').insert(category);
  }

  Future<void> updateCategory(String id, Map<String, dynamic> updates) async {
    await _client.from('categories').update(updates).eq('id', id);
  }

  Future<void> deleteCategory(String id) async {
    await _client.from('categories').delete().eq('id', id);
  }
}
