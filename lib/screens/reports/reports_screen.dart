import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';


class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined),
            tooltip: 'Calendar View',
            onPressed: () => context.push('/reports/calendar'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(weeklySpendingProvider);
          ref.invalidate(allTransactionsProvider(null));
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // ─── Income vs Expense Summary ────────────────────────
            _SummaryCards(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── Bar Chart ────────────────────────────────────────
            Text(
              'Income vs Expense',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _IncomeExpenseBarChart(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── Category Breakdown ───────────────────────────────
            Text(
              'Category Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _CategoryPieChart(isDark: isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── AI Insights ──────────────────────────────────────
            _AiInsightsCard(isDark: isDark),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ─── Summary Cards ───────────────────────────────────────────────────────────
class _SummaryCards extends ConsumerWidget {
  final bool isDark;
  const _SummaryCards({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklySpendingProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return weeklyData.when(
      data: (data) {
        final income = data['monthIncome'] ?? 0.0;
        final expense = data['monthExpense'] ?? 0.0;

        return Row(
          children: [
            Expanded(
              child: _SmallCard(
                label: 'Income',
                value: formatter.format(income),
                color: AppColors.income,
                icon: Icons.arrow_downward_rounded,
                isDark: isDark,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _SmallCard(
                label: 'Expense',
                value: formatter.format(expense),
                color: AppColors.expense,
                icon: Icons.arrow_upward_rounded,
                isDark: isDark,
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(height: 80, child: Center(child: CircularProgressIndicator())),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final bool isDark;

  const _SmallCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.onSurfaceVariantDark
                        : AppColors.onSurfaceVariantLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bar Chart ───────────────────────────────────────────────────────────────
class _IncomeExpenseBarChart extends ConsumerWidget {
  final bool isDark;
  const _IncomeExpenseBarChart({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyData = ref.watch(weeklySpendingProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SizedBox(
          height: 200,
          child: weeklyData.when(
            data: (data) {
              final income = data['monthIncome'] ?? 0.0;
              final expense = data['monthExpense'] ?? 0.0;

              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceEvenly,
                  maxY: (income > expense ? income : expense) * 1.2,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Income',
                                  style: TextStyle(fontSize: 12));
                            case 1:
                              return const Text('Expense',
                                  style: TextStyle(fontSize: 12));
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: income,
                          color: AppColors.income,
                          width: 32,
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: expense,
                          color: AppColors.expense,
                          width: 32,
                          borderRadius:
                              const BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Center(child: Text('Error')),
          ),
        ),
      ),
    );
  }
}

// ─── Pie Chart ───────────────────────────────────────────────────────────────
class _CategoryPieChart extends ConsumerWidget {
  final bool isDark;
  const _CategoryPieChart({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(allTransactionsProvider(null));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SizedBox(
          height: 200,
          child: transactions.when(
            data: (txList) {
              final expenses =
                  txList.where((t) => t.type == 'expense').toList();
              if (expenses.isEmpty) {
                return Center(
                  child: Text(
                    'No expense data',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                );
              }

              // Group by category
              final categoryTotals = <String, double>{};
              for (final tx in expenses) {
                final key = tx.categoryId ?? 'Uncategorized';
                categoryTotals[key] =
                    (categoryTotals[key] ?? 0) + tx.amount;
              }

              final colors = [
                const Color(0xFF3B82F6),
                const Color(0xFF8B5CF6),
                const Color(0xFFEC4899),
                const Color(0xFFF59E0B),
                const Color(0xFF22C55E),
                const Color(0xFF06B6D4),
                const Color(0xFFEF4444),
                const Color(0xFF6366F1),
              ];

              int colorIndex = 0;
              return PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: categoryTotals.entries.map((entry) {
                    final color = colors[colorIndex % colors.length];
                    colorIndex++;
                    return PieChartSectionData(
                      value: entry.value,
                      color: color,
                      radius: 40,
                      showTitle: false,
                    );
                  }).toList(),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => const Center(child: Text('Error')),
          ),
        ),
      ),
    );
  }
}

// ─── AI Insights Card ────────────────────────────────────────────────────────
class _AiInsightsCard extends ConsumerStatefulWidget {
  final bool isDark;
  const _AiInsightsCard({required this.isDark});

  @override
  ConsumerState<_AiInsightsCard> createState() => _AiInsightsCardState();
}

class _AiInsightsCardState extends ConsumerState<_AiInsightsCard> {
  bool _isLoading = false;

  Future<void> _generateInsight() async {
    setState(() => _isLoading = true);
    try {
      final aiService = ref.read(aiServiceProvider);
      await aiService.generateInsights();
      ref.invalidate(latestInsightProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insight generated & synced with Web!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: \$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final insightAsync = ref.watch(latestInsightProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryLight,
                            const Color(0xFF8B5CF6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.auto_awesome_rounded,
                          color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'AI Financial Advisor',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: _isLoading ? null : _generateInsight,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.refresh, size: 16),
                  label: const Text('Ask AI'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            insightAsync.when(
              data: (insight) {
                if (insight == null) {
                  return Text(
                    'No insights generated yet. Tap "Ask AI" to analyze your current month\'s spending pacing using Gemini 2.5 Flash!',
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.content,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isDark
                            ? AppColors.onSurfaceDark
                            : AppColors.onSurfaceLight,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      "Generated on \${DateFormat('MMM dd, hh:mm a').format(insight.generatedAt.toLocal())}",
                      style: TextStyle(
                        fontSize: 11,
                        color: widget.isDark
                            ? AppColors.onSurfaceVariantDark
                            : AppColors.onSurfaceVariantLight,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text(
                'Could not load insights: \$err',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
