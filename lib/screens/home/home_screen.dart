import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
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



              // ─── Monthly Budget ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _BudgetSection(title: 'Monthly Budget', isWeekly: false),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ─── Weekly Budget ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: _BudgetSection(title: 'Weekly Budget', isWeekly: true),
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
class _DashboardHeader extends ConsumerStatefulWidget {
  const _DashboardHeader();

  @override
  ConsumerState<_DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends ConsumerState<_DashboardHeader> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildInitialsAvatar(String initials) {
    return CircleAvatar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final user = ref.watch(currentUserProvider);
    final initials = (user?.email?.substring(0, 1) ?? 'M').toUpperCase();
    final avatarUrl = user?.userMetadata?['avatar_url'] as String?;
    final unreadCountAsync = ref.watch(unreadNotificationsCountProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
      child: Row(
        children: [
          // Profile avatar
          ClipOval(
            child: avatarUrl != null
                ? CachedNetworkImage(
                    imageUrl: avatarUrl,
                    cacheKey: avatarUrl.split('?').first,
                    memCacheWidth: 150, // Optimize memory decode
                    memCacheHeight: 150,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration.zero, // Disable fade-in to prevent flashing
                    fadeOutDuration: Duration.zero,
                    placeholder: (context, url) => _buildInitialsAvatar(initials),
                    errorWidget: (context, url, error) => _buildInitialsAvatar(initials),
                  )
                : _buildInitialsAvatar(initials),
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, size: 20),
                  onPressed: () => context.push('/notifications'),
                  color: AppColors.onSurfaceVariant,
                ),
                unreadCountAsync.when(
                  data: (count) {
                    if (count > 0) {
                      return Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count > 9 ? '9+' : count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
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
                  final income = data['monthIncome'] ?? 0.0;
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
                  final spent = data['monthExpense'] ?? 0.0;
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
      {'icon': Icons.add_card_rounded, 'label': 'Transaction', 'route': '/accounts/add-transaction', 'isGo': false},
      {'icon': Icons.category_outlined, 'label': 'Category', 'route': '/accounts/categories', 'isGo': false},
      {'icon': Icons.money_off_rounded, 'label': 'Debt', 'route': '/accounts/debts', 'isGo': false},
      {'icon': Icons.smart_toy_outlined, 'label': 'AI Advisor', 'route': '/reports', 'isGo': true},
      {'icon': Icons.account_balance_rounded, 'label': 'Account', 'route': '/accounts', 'isGo': true},
    ];

    return SizedBox(
      height: 85,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: actions.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          final a = actions[index];
          return GestureDetector(
            onTap: () {
              if (a['isGo'] == true) {
                context.go(a['route'] as String);
              } else {
                context.push(a['route'] as String);
              }
            },
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
          );
        },
      ),
    );
  }
}


// ─── Budget Section ──────────────────────────────────────────────────────────
class _BudgetSection extends ConsumerWidget {
  final String title;
  final bool isWeekly;
  const _BudgetSection({required this.title, required this.isWeekly});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetAsync = ref.watch(currentBudgetProvider);
    final formatter = NumberFormat.compactCurrency(locale: 'id_ID', symbol: 'Rp');

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
          budgetAsync.when(
            data: (budget) {
              if (budget == null) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Text('AI Budget pending structure.', style: TextStyle(color: Colors.grey)),
                );
              }

              final divisor = isWeekly ? 4.0 : 1.0;
              final needs = budget.needsAmount / divisor;
              final wants = budget.wantsAmount / divisor;
              final savings = budget.savingsAmount / divisor;
              final total = needs + wants + savings;

              if (total <= 0) {
                return const Text('AI Budget is empty.', style: TextStyle(color: Colors.grey));
              }

              return Column(
                children: [
                  _BudgetBar(
                    label: 'Needs Priority',
                    value: needs / total,
                    percentage: formatter.format(needs),
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BudgetBar(
                    label: 'Wants & Lifestyle',
                    value: wants / total,
                    percentage: formatter.format(wants),
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BudgetBar(
                    label: 'Savings Target',
                    value: savings / total,
                    percentage: formatter.format(savings),
                    color: AppColors.tertiary,
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Text('Unable to load budget data'),
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
