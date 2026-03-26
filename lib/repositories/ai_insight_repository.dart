import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ai_insight_model.dart';

class AiInsightRepository {
  final SupabaseClient _client;

  AiInsightRepository(this._client);

  Future<List<AiInsightModel>> getInsights({String? period}) async {
    var query = _client.from('ai_insights').select();
    if (period != null) {
      query = query.eq('period', period);
    }
    final data = await query.order('generated_at', ascending: false);
    return data.map((json) => AiInsightModel.fromJson(json)).toList();
  }

  Future<AiInsightModel?> getLatestInsight() async {
    final data = await _client
        .from('ai_insights')
        .select()
        .order('generated_at', ascending: false)
        .limit(1)
        .maybeSingle();
    if (data == null) return null;
    return AiInsightModel.fromJson(data);
  }

  Future<void> rateInsight(String id, {bool? thumbsUp, bool? thumbsDown}) async {
    await _client.from('ai_insights').update({
      'thumbs_up': thumbsUp,
      'thumbs_down': thumbsDown,
    }).eq('id', id);
  }
}
