import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/accounts/debts'),
            icon: const Icon(Icons.receipt_long_outlined, size: 18),
            label: const Text('Debts'),
          ),
          IconButton(
            icon: const Icon(Icons.compare_arrows_rounded),
            tooltip: 'Reconcile',
            onPressed: () => context.push('/accounts/reconcile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(accountsProvider);
        },
        child: accounts.when(
          data: (accountList) {
            if (accountList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 64,
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'No accounts yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isDark
                                ? AppColors.onSurfaceVariantDark
                                : AppColors.onSurfaceVariantLight,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Add your first account to start tracking',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Group accounts by type
            final grouped = <String, List<dynamic>>{};
            for (final account in accountList) {
              grouped.putIfAbsent(account.type, () => []).add(account);
            }

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: grouped.entries.map((entry) {
                final typeTotal = entry.value.fold<double>(
                    0.0, (sum, a) => sum + a.balance);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm,
                        horizontal: AppSpacing.xs,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: isDark
                                  ? AppColors.onSurfaceVariantDark
                                  : AppColors.onSurfaceVariantLight,
                            ),
                          ),
                          Text(
                            formatter.format(typeTotal),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.onSurfaceVariantDark
                                  : AppColors.onSurfaceVariantLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: entry.value.map<Widget>((account) {
                          final color = account.color != null
                              ? Color(int.parse(
                                  account.color!.replaceFirst('#', '0xFF')))
                              : AppColors.primaryLight;

                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _getAccountIcon(account.type),
                                color: color,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              account.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              account.currency,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.onSurfaceVariantDark
                                    : AppColors.onSurfaceVariantLight,
                              ),
                            ),
                            trailing: Text(
                              formatter.format(account.balance),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: account.balance >= 0
                                    ? AppColors.income
                                    : AppColors.expense,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  IconData _getAccountIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cash':
        return Icons.payments_outlined;
      case 'bank':
        return Icons.account_balance_outlined;
      case 'e-wallet':
      case 'ewallet':
        return Icons.phone_android_outlined;
      case 'credit':
        return Icons.credit_card_outlined;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }
}
