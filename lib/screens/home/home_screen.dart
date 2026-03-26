import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(totalBalanceProvider);
            ref.invalidate(weeklySpendingProvider);
            ref.invalidate(recentTransactionsProvider);
            ref.invalidate(accountsProvider);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ─── Header ───────────────────────────────────────────
              _DashboardHeader(),
              const SizedBox(height: AppSpacing.md),

              // ─── Total Balance Hero Card ──────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _BalanceHeroCard(),
              ),
              const SizedBox(height: AppSpacing.md),

              // ─── Income / Expense Row ─────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _IncomeExpenseRow(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── Quick Actions ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _QuickActions(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── My Accounts ──────────────────────────────────────
              _MyAccountsSection(),
              const SizedBox(height: AppSpacing.lg),

              // ─── Monthly Budget ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _BudgetSection(title: 'Monthly Budget'),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── Weekly Budget ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _BudgetSection(title: 'Weekly Budget'),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── Recent Transactions ──────────────────────────────
              _RecentTransactionsSection(),
              const SizedBox(height: 100), // bottom nav padding
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Dashboard Header ────────────────────────────────────────────────────────
class _DashboardHeader extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final initials =
        (user?.email?.substring(0, 1) ?? 'M').toUpperCase();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
      child: Row(
        children: [
          // Profile avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryFixed,
            child: Text(
              initials,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryContainer,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'MOTRAC',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.onSurface,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 20),
              onPressed: () {},
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Balance Hero Card ───────────────────────────────────────────────────────
class _BalanceHeroCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalBalance = ref.watch(totalBalanceProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.heroCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusXxl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -4,
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
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  'TOTAL BALANCE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          totalBalance.when(
            data: (balance) => Text(
              formatter.format(balance),
              style: GoogleFonts.manrope(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            loading: () => SizedBox(
              height: 44,
              width: 44,
              child: CircularProgressIndicator(
                color: Colors.white.withValues(alpha: 0.7),
                strokeWidth: 2.5,
              ),
            ),
            error: (_, _) => Text(
              'Error',
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 18),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '+12.5% this month',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Income / Expense Row ────────────────────────────────────────────────────
class _IncomeExpenseRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklySpendingProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Column(
      children: [
        // Income
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Icon(
                  Icons.arrow_downward_rounded,
                  size: 18,
                  color: AppColors.tertiary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'INCOME',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              weeklyData.when(
                data: (data) {
                  final income = data['income'] ?? 0.0;
                  return Text(
                    formatter.format(income),
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  );
                },
                loading: () =>
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                error: (_, _) => const Text('--'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Expense
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  size: 18,
                  color: AppColors.expense,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'EXPENSE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              weeklyData.when(
                data: (data) {
                  final spent = data['spent'] ?? 0.0;
                  return Text(
                    formatter.format(spent),
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  );
                },
                loading: () =>
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                error: (_, _) => const Text('--'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Quick Actions ───────────────────────────────────────────────────────────
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transfer'},
      {'icon': Icons.receipt_long_outlined, 'label': 'Bill'},
      {'icon': Icons.savings_outlined, 'label': 'Savings'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: actions.map((a) {
        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: GestureDetector(
            onTap: () => context.push('/accounts/add-transaction'),
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    boxShadow: AppShadows.card,
                  ),
                  child: Icon(
                    a['icon'] as IconData,
                    size: 22,
                    color: AppColors.primaryContainer,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  a['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── My Accounts Section ─────────────────────────────────────────────────────
class _MyAccountsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Accounts',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              GestureDetector(
                onTap: () => context.go('/accounts'),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 100,
          child: accounts.when(
            data: (list) {
              if (list.isEmpty) {
                return Center(
                  child: Text(
                    'No accounts yet',
                    style: GoogleFonts.inter(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                itemCount: list.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final account = list[index];
                  final color = account.color != null
                      ? Color(int.parse(
                          account.color!.replaceFirst('#', '0xFF')))
                      : AppColors.primaryContainer;

                  return Container(
                    width: 160,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusXl),
                      boxShadow: AppShadows.card,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(
                                    AppTheme.radiusMd),
                              ),
                              child: Icon(
                                _getIcon(account.type),
                                size: 14,
                                color: color,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Text(
                                account.name,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatter.format(account.balance),
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
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

  IconData _getIcon(String type) {
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

// ─── Budget Section ──────────────────────────────────────────────────────────
class _BudgetSection extends ConsumerWidget {
  final String title;
  const _BudgetSection({required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklySpendingProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          weeklyData.when(
            data: (data) {
              final percentage = (data['percentage'] ?? 0.0);
              return Column(
                children: [
                  _BudgetBar(
                    label: 'Needs',
                    value: (percentage * 0.5).clamp(0.0, 1.0),
                    percentage: '${(percentage * 50).toStringAsFixed(0)}%',
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BudgetBar(
                    label: 'Wants',
                    value: (percentage * 0.3).clamp(0.0, 1.0),
                    percentage: '${(percentage * 30).toStringAsFixed(0)}%',
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BudgetBar(
                    label: 'Savings Progress',
                    value: (1 - percentage).clamp(0.0, 1.0),
                    percentage:
                        '${((1 - percentage) * 100).toStringAsFixed(0)}%',
                    color: AppColors.tertiary,
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) =>
                const Text('Unable to load budget data'),
          ),
        ],
      ),
    );
  }
}

class _BudgetBar extends StatelessWidget {
  final String label;
  final double value;
  final String percentage;
  final Color color;

  const _BudgetBar({
    required this.label,
    required this.value,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            Text(
              percentage,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

// ─── Recent Transactions Section ─────────────────────────────────────────────
class _RecentTransactionsSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTx = ref.watch(recentTransactionsProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFormat = DateFormat('MMM dd');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              GestureDetector(
                onTap: () => context.go('/reports'),
                child: Text(
                  'See More',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: recentTx.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 40, color: AppColors.onSurfaceVariant),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'No transactions yet',
                          style: GoogleFonts.inter(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Tap + to add your first one',
                          style: GoogleFonts.inter(
                            color: AppColors.outline,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                ),
                child: Column(
                  children: transactions.map((tx) {
                    final isExpense = tx.type == 'expense';
                    final isTransfer = tx.type == 'transfer';
                    final color = isExpense
                        ? AppColors.expense
                        : isTransfer
                            ? AppColors.transfer
                            : AppColors.income;
                    final prefix = isExpense ? '-' : isTransfer ? '' : '+';
                    final iconBgColor = isExpense
                        ? AppColors.errorContainer.withValues(alpha: 0.4)
                        : isTransfer
                            ? AppColors.secondaryContainer.withValues(alpha: 0.4)
                            : AppColors.tertiaryFixedDim.withValues(alpha: 0.12);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: iconBgColor,
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusLg),
                            ),
                            child: Icon(
                              isExpense
                                  ? Icons.arrow_upward_rounded
                                  : isTransfer
                                      ? Icons.swap_horiz_rounded
                                      : Icons.arrow_downward_rounded,
                              color: color,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx.note ?? tx.type.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${tx.type[0].toUpperCase()}${tx.type.substring(1)} • ${dateFormat.format(tx.date)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '$prefix${formatter.format(tx.amount)}',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
