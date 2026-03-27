import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AiService {
  final SupabaseClient _supabase;

  AiService(this._supabase);

  String? get _apiKey => dotenv.env['GEMINI_API_KEY'];

  Future<void> generateSmartAllocation(double income) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('GEMINI_API_KEY is missing from environment variables.');
    }

    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // 1. Fetch active debts
    final debtsStr = await _supabase
        .from('debts')
        .select()
        .eq('user_id', user.id)
        .eq('direction', 'i_owe');

    double totalDebt = 0;
    for (var d in debtsStr) {
      totalDebt += double.tryParse(d['principal'].toString()) ?? 0.0;
    }

    // 2. Setup Gemini
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey!,
    );

    final prompt = '''
You are an expert financial advisor. The user has a monthly income of $income IDR.
They currently have an outstanding total debt of $totalDebt IDR.

Your task is to recommend a tailored monthly budget allocation (Needs, Wants, Savings, Debt_Repayment).
- If the 50/30/20 rule (50% Needs, 30% Wants, 20% Savings) is realistic and healthy given their debt, use it.
- If they have significant debt, consider carving out a "Debt_Repayment" portion by reducing Wants or Savings.
- The sum of needs, wants, savings, and debt_repayment MUST EXACTLY equal $income.

Respond ONLY with a valid JSON object matching this exact schema:
{
  "needs": number,
  "wants": number,
  "savings": number,
  "debt": number,
  "reason": "A 1-to-2 sentence encouraging explanation of why you chose this allocation."
}
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final text = response.text;
    if (text == null) throw Exception('Empty AI response');

    final rawJson = text.replaceAll('```json', '').replaceAll('```', '').trim();
    final allocation = jsonDecode(rawJson);

    // 3. Rollover Logic
    final today = DateTime.now();
    final prevMonthDate = DateTime(today.year, today.month - 1, 1);
    final prevMonthStr = '${prevMonthDate.year}-${prevMonthDate.month.toString().padLeft(2, '0')}-01';

    final prevBudgetList = await _supabase.from('budgets').select().eq('month', prevMonthStr);
    final prevBudget = prevBudgetList.isNotEmpty ? prevBudgetList.first : null;

    final startPrevMonth = '${prevMonthDate.year}-${prevMonthDate.month.toString().padLeft(2, '0')}-01T00:00:00Z';
    final startCurrentMonth = '${today.year}-${today.month.toString().padLeft(2, '0')}-01T00:00:00Z';

    final prevTxns = await _supabase
        .from('transactions')
        .select('amount, type, category_id')
        .gte('date', startPrevMonth)
        .lt('date', startCurrentMonth);

    // Since we don't have budget_type mapped easily natively unless we fetch categories, 
    // we bypass hybrid complex logic or map categories quickly:
    final cats = await _supabase.from('categories').select('id, budget_type').eq('user_id', user.id);
    final catMap = {for (var c in cats) c['id'] as String: c['budget_type'] as String?};

    double spentNeeds = 0;
    double spentWants = 0;

    if (prevBudget != null) {
      for (var t in prevTxns) {
        if (t['type'] == 'expense' && t['category_id'] != null) {
          final bType = catMap[t['category_id']];
          if (bType == 'needs') spentNeeds += double.tryParse(t['amount'].toString()) ?? 0;
          if (bType == 'wants') spentWants += double.tryParse(t['amount'].toString()) ?? 0;
        }
      }

      double prevNeedsAmount = double.tryParse(prevBudget['needs_amount'].toString()) ?? 0;
      double prevWantsAmount = double.tryParse(prevBudget['wants_amount'].toString()) ?? 0;

      double rolloverNeeds = (prevNeedsAmount - spentNeeds) > 0 ? (prevNeedsAmount - spentNeeds) : 0;
      double rolloverWants = (prevWantsAmount - spentWants) > 0 ? (prevWantsAmount - spentWants) : 0;

      allocation['savings'] = (allocation['savings'] as num).toDouble() + rolloverNeeds;
      allocation['wants'] = (allocation['wants'] as num).toDouble() + rolloverWants;
    }

    final currentMonthStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-01';

    await _supabase.from('budgets').upsert({
      'user_id': user.id,
      'month': currentMonthStr,
      'needs_amount': allocation['needs'],
      'wants_amount': allocation['wants'],
      'savings_amount': allocation['savings'],
      'debt_amount': allocation['debt'],
    });
  }

  Future<void> generateInsights() async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('GEMINI_API_KEY is missing from environment variables.');
    }

    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    final today = DateTime.now();
    final currentMonthStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-01';
    
    final budgetList = await _supabase.from('budgets').select().eq('user_id', user.id).eq('month', currentMonthStr);
    if (budgetList.isEmpty) {
      throw Exception('Please set up your budget for this month first before generating insights.');
    }
    final budget = budgetList.first;

    final cats = await _supabase.from('categories').select('id, parent_id, budget_type').eq('user_id', user.id);
    String findBudgetType(String catId) {
      final c = cats.firstWhere((x) => x['id'] == catId, orElse: () => {});
      if (c.isEmpty) return 'other';
      if (c['budget_type'] != null) return c['budget_type'];
      if (c['parent_id'] != null) {
        final p = cats.firstWhere((x) => x['id'] == c['parent_id'], orElse: () => {});
        if (p.isNotEmpty && p['budget_type'] != null) return p['budget_type'];
      }
      return 'other';
    }

    final startCurrentMonth = '${today.year}-${today.month.toString().padLeft(2, '0')}-01T00:00:00Z';
    final txns = await _supabase
        .from('transactions')
        .select('amount, type, category_id')
        .eq('user_id', user.id)
        .gte('date', startCurrentMonth);

    double needsSpent = 0;
    double wantsSpent = 0;
    double savingsSpent = 0;

    for (var t in txns) {
      if (t['type'] == 'expense' && t['category_id'] != null) {
        final bType = findBudgetType(t['category_id']);
        if (bType == 'needs') needsSpent += double.tryParse(t['amount'].toString()) ?? 0;
        if (bType == 'wants') wantsSpent += double.tryParse(t['amount'].toString()) ?? 0;
        if (bType == 'savings') savingsSpent += double.tryParse(t['amount'].toString()) ?? 0;
      }
    }

    String frm(num val) => 'Rp ${(val / 1000).toStringAsFixed(0)}k';

    final prompt = '''
You are Motrac's expert AI Financial Advisor. The user is using the 50/30/20 budgeting rule.
Here is the user's data for this month ($currentMonthStr):
- Needs: Budget ${frm(double.tryParse(budget['needs_amount'].toString()) ?? 0)} | Spent ${frm(needsSpent)}
- Wants: Budget ${frm(double.tryParse(budget['wants_amount'].toString()) ?? 0)} | Spent ${frm(wantsSpent)}
- Savings: Goal ${frm(double.tryParse(budget['savings_amount'].toString()) ?? 0)} | Saved/Allocated ${frm(savingsSpent)}

Analyze their pacing. Warn immediately if they are overspending in Needs or Wants. Praise them if they are perfectly on track or saving well.
Provide a concise, highly actionable 2 to 3 sentence insight. 
Tone: Friendly, professional, encouraging. 
Format: Raw text (you can use 1 or 2 relevant emojis, avoid heavy markdown headers).
IMPORTANT: Always respond in English, regardless of any locale or language settings.
''';

    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey!,
    );

    final response = await model.generateContent([Content.text(prompt)]);
    final insightText = response.text ?? "I'm sorry, I couldn't generate an insight right now.";

    await _supabase.from('ai_insights').insert({
      'user_id': user.id,
      'type': 'monthly_pacing',
      'content': insightText,
      'period': currentMonthStr,
    });

    await _supabase.from('notifications').insert({
      'user_id': user.id,
      'type': 'success',
      'title': '🧠 AI Insight Ready!',
      'message': 'Your personalized Gemini analysis for this month is ready to read.',
      'link': '/reports',
    });
  }
}
