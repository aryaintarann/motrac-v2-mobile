import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';
import '../../models/transaction_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Motrac'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(totalBalanceProvider);
          ref.invalidate(weeklySpendingProvider);
          ref.invalidate(recentTransactionsProvider);
          ref.invalidate(templatesProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // ─── Net Worth Header ────────────────────────────────────
            _NetWorthCard(isDark: isDark),
            const SizedBox(height: AppSpacing.md),

            // ─── AI Pacing Widget ────────────────────────────────────
            _AiPacingWidget(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── Quick Templates ─────────────────────────────────────
            _QuickTemplatesRow(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── Recent Activity ─────────────────────────────────────
            _RecentActivity(isDark: isDark),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ─── Net Worth Card ──────────────────────────────────────────────────────────
class _NetWorthCard extends ConsumerWidget {
  final bool isDark;
  const _NetWorthCard({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalBalance = ref.watch(totalBalanceProvider);
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight,
            AppColors.primaryLight.withValues(alpha: 0.8),
            const Color(0xFF6366F1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Net Worth',
                  style: TextStyle(
                      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          totalBalance.when(
            data: (balance) => Text(
              formatter.format(balance),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            loading: () => const SizedBox(
              height: 40,
              child: CircularProgressIndicator(color: Colors.white),
            ),
            error: (_, _) => const Text(
              'Error loading',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Total across all accounts',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── AI Pacing Widget ────────────────────────────────────────────────────────
class _AiPacingWidget extends ConsumerWidget {
  final bool isDark;
  const _AiPacingWidget({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklySpendingProvider);

    return weeklyData.when(
      data: (data) {
        final percentage = (data['percentage'] ?? 0.0);
        final remaining = (data['remaining'] ?? 0.0);
        final formatter =
            NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

        Color statusColor;
        String statusText;
        IconData statusIcon;

        if (percentage < 0.6) {
          statusColor = AppColors.pacingGreen;
          statusText = 'On Track';
          statusIcon = Icons.trending_up_rounded;
        } else if (percentage < 0.85) {
          statusColor = AppColors.pacingYellow;
          statusText = 'Watch Out';
          statusIcon = Icons.trending_flat_rounded;
        } else {
          statusColor = AppColors.pacingRed;
          statusText = 'Over Budget';
          statusIcon = Icons.trending_down_rounded;
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(statusIcon, color: statusColor, size: 20),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Pacing',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatter.format(remaining),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: percentage.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: statusColor.withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation(statusColor),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${(percentage * 100).toStringAsFixed(0)}% of weekly budget used',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

// ─── Quick Templates ─────────────────────────────────────────────────────────
class _QuickTemplatesRow extends ConsumerWidget {
  final bool isDark;
  const _QuickTemplatesRow({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 80,
          child: templates.when(
            data: (items) {
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'No templates yet',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Material(
                    color: isDark
                        ? AppColors.surfaceVariantDark
                        : AppColors.surfaceVariantLight,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // TODO: Open pre-filled transaction modal
                      },
                      child: Container(
                        width: 80,
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.icon ?? '💰',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              item.name,
                              style: const TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

// ─── Recent Activity ─────────────────────────────────────────────────────────
class _RecentActivity extends ConsumerWidget {
  final bool isDark;
  const _RecentActivity({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTx = ref.watch(recentTransactionsProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormat = DateFormat('dd MMM');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        recentTx.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 48,
                          color: isDark
                              ? AppColors.onSurfaceVariantDark
                              : AppColors.onSurfaceVariantLight,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'No transactions yet',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.onSurfaceVariantDark
                                : AppColors.onSurfaceVariantLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Tap + to add your first transaction',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.onSurfaceVariantDark
                                : AppColors.onSurfaceVariantLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Card(
              child: Column(
                children: transactions.map((tx) {
                  return _TransactionTile(
                    transaction: tx,
                    formatter: formatter,
                    dateFormat: dateFormat,
                    isDark: isDark,
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
          error: (_, _) => const Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text('Error loading transactions'),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final NumberFormat formatter;
  final DateFormat dateFormat;
  final bool isDark;

  const _TransactionTile({
    required this.transaction,
    required this.formatter,
    required this.dateFormat,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final isExpense = transaction.type == 'expense';
    final isTransfer = transaction.type == 'transfer';
    final color = isExpense
        ? AppColors.expense
        : isTransfer
            ? AppColors.transfer
            : AppColors.income;
    final prefix = isExpense ? '-' : isTransfer ? '' : '+';

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          isExpense
              ? Icons.arrow_upward_rounded
              : isTransfer
                  ? Icons.swap_horiz_rounded
                  : Icons.arrow_downward_rounded,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        transaction.note ?? transaction.type.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        dateFormat.format(transaction.date),
        style: TextStyle(
          fontSize: 12,
          color: isDark
              ? AppColors.onSurfaceVariantDark
              : AppColors.onSurfaceVariantLight,
        ),
      ),
      trailing: Text(
        '$prefix${formatter.format(transaction.amount)}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
          fontSize: 14,
        ),
      ),
    );
  }
}
