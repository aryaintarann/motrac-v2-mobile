import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';
import '../repositories/account_repository.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/debt_repository.dart';
import '../repositories/template_repository.dart';
import '../repositories/budget_repository.dart';
import '../repositories/ai_insight_repository.dart';
import '../repositories/reconciliation_repository.dart';
import '../repositories/notification_repository.dart';
import '../models/account_model.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';
import '../models/debt_model.dart';
import '../models/template_model.dart';
import '../models/budget_model.dart';
import '../models/ai_insight_model.dart';
import '../models/reconciliation_model.dart';
import '../models/notification_model.dart';
import '../services/ai_service.dart';

// ─── Services ─────────────────────────────────────────────────────────────────
final aiServiceProvider = Provider<AiService>((ref) {
  return AiService(ref.watch(supabaseClientProvider));
});

// ─── Supabase Client ──────────────────────────────────────────────────────────
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// ─── Repositories ──────────────────────────────────────────────────────────────
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseClientProvider));
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository(ref.watch(supabaseClientProvider));
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(ref.watch(supabaseClientProvider));
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(ref.watch(supabaseClientProvider));
});

final debtRepositoryProvider = Provider<DebtRepository>((ref) {
  return DebtRepository(ref.watch(supabaseClientProvider));
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository(ref.watch(supabaseClientProvider));
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(ref.watch(supabaseClientProvider));
});

final aiInsightRepositoryProvider = Provider<AiInsightRepository>((ref) {
  return AiInsightRepository(ref.watch(supabaseClientProvider));
});

final reconciliationRepositoryProvider = Provider<ReconciliationRepository>((ref) {
  return ReconciliationRepository(ref.watch(supabaseClientProvider));
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(supabaseClientProvider));
});

// ─── Auth State ────────────────────────────────────────────────────────────────
final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authRepositoryProvider).onAuthStateChange;
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authRepositoryProvider).currentUser;
});

// ─── Data Providers ────────────────────────────────────────────────────────────
final accountsProvider = FutureProvider<List<AccountModel>>((ref) async {
  return ref.watch(accountRepositoryProvider).getAccounts();
});

final totalBalanceProvider = FutureProvider<double>((ref) async {
  final accounts = await ref.watch(accountsProvider.future);
  return accounts.fold<double>(0.0, (sum, a) => sum + a.balance);
});

final recentTransactionsProvider = FutureProvider<List<TransactionModel>>((ref) async {
  return ref.watch(transactionRepositoryProvider).getRecentTransactions(limit: 10);
});

final allTransactionsProvider = FutureProvider.family<List<TransactionModel>, Map<String, dynamic>?>(
  (ref, filters) async {
    return ref.watch(transactionRepositoryProvider).getTransactions(
      accountId: filters?['accountId'],
      type: filters?['type'],
      startDate: filters?['startDate'],
      endDate: filters?['endDate'],
    );
  },
);

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return ref.watch(categoryRepositoryProvider).getCategories();
});

final expenseCategoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return ref.watch(categoryRepositoryProvider).getCategories(type: 'expense');
});

final incomeCategoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  return ref.watch(categoryRepositoryProvider).getCategories(type: 'income');
});

final debtsProvider = FutureProvider<List<DebtModel>>((ref) async {
  return ref.watch(debtRepositoryProvider).getDebts();
});

final templatesProvider = FutureProvider<List<TemplateModel>>((ref) async {
  return ref.watch(templateRepositoryProvider).getTemplates();
});

final currentBudgetProvider = FutureProvider<BudgetModel?>((ref) async {
  final now = DateTime.now();
  final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
  return ref.watch(budgetRepositoryProvider).getBudgetByMonth(month);
});

final latestInsightProvider = FutureProvider<AiInsightModel?>((ref) async {
  return ref.watch(aiInsightRepositoryProvider).getLatestInsight();
});

final reconciliationsProvider = FutureProvider.family<List<ReconciliationModel>, String?>(
  (ref, accountId) async {
    return ref.watch(reconciliationRepositoryProvider).getReconciliations(accountId: accountId);
  },
);

final notificationsProvider = FutureProvider<List<NotificationModel>>((ref) async {
  return ref.watch(notificationRepositoryProvider).getNotifications();
});

final unreadNotificationsCountProvider = FutureProvider<int>((ref) async {
  final notes = await ref.watch(notificationsProvider.future);
  return notes.where((n) => !n.isRead).length;
});

// ─── Weekly Spending for AI Pacing ─────────────────────────────────────────────
final weeklySpendingProvider = FutureProvider<Map<String, double>>((ref) async {
  final repo = ref.watch(transactionRepositoryProvider);
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  final income = await repo.getTotalByType('income',
      startDate: DateTime(now.year, now.month, 1),
      endDate: DateTime(now.year, now.month + 1, 0));
  final weekExpense = await repo.getTotalByType('expense',
      startDate: startOfWeek, endDate: endOfWeek);
  final monthExpense = await repo.getTotalByType('expense',
      startDate: DateTime(now.year, now.month, 1), endDate: now);

  final weeklyBudget = income / 4;
  final remaining = weeklyBudget - weekExpense;

  return {
    'weeklyBudget': weeklyBudget,
    'weekExpense': weekExpense,
    'monthExpense': monthExpense,
    'monthIncome': income,
    'remaining': remaining,
    'percentage': weeklyBudget > 0 ? (weekExpense / weeklyBudget) : 0.0,
  };
});
