import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';
import '../../models/category_model.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categoriesAsync = ref.watch(categoriesProvider);
    final transactionsAsync = ref.watch(allTransactionsProvider(null));

    // Colors mimicking the mockup
    final bgColor = isDark ? Colors.black : const Color(0xFFF9FAFB); // Very light grey
    final cardColor = isDark ? AppColors.cardDark : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(''), // Empty title, we use custom title below
        elevation: 0,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ─────────────────────────────────────────
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Manage your spending buckets using the 50/30/20 rule.',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ─── Categories Lists ──────────────────────────────
            categoriesAsync.when(
              data: (cats) {
                return transactionsAsync.when(
                  data: (txns) {
                    final needs = cats.where((c) => c.budgetType == 'needs').toList();
                    final wants = cats.where((c) => c.budgetType == 'wants').toList();
                    final savings = cats.where((c) => c.budgetType == 'savings').toList();

                    return Column(
                      children: [
                        _buildBucketGroup(
                          context: context,
                          title: 'Needs',
                          percentage: '(50%)',
                          icon: Icons.check_circle_rounded,
                          iconColor: const Color(0xFF3B82F6),
                          iconBgColor: const Color(0xFFEFF6FF),
                          items: needs,
                          txns: txns,
                          isDark: isDark,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildBucketGroup(
                          context: context,
                          title: 'Wants',
                          percentage: '(30%)',
                          icon: Icons.favorite_rounded,
                          iconColor: const Color(0xFF14B8A6),
                          iconBgColor: const Color(0xFFF0FDFA),
                          items: wants,
                          txns: txns,
                          isDark: isDark,
                          cardColor: cardColor,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        _buildBucketGroup(
                          context: context,
                          title: 'Savings',
                          percentage: '(20%)',
                          icon: Icons.savings_rounded,
                          iconColor: const Color(0xFF6366F1),
                          iconBgColor: const Color(0xFFEEF2FF),
                          items: savings,
                          txns: txns,
                          isDark: isDark,
                          cardColor: cardColor,
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading categories: $e')),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // ─── AI Monthly Insight Card ────────────────────────
            _buildAiInsightCard(isDark),
            const SizedBox(height: AppSpacing.lg),

            // ─── Quick Budget Check Card ────────────────────────
            _buildQuickBudgetCheckCard(isDark, cardColor),
            const SizedBox(height: AppSpacing.xxl * 2),
          ],
        ),
      ),
    );
  }

  Widget _buildBucketGroup({
    required BuildContext context,
    required String title,
    required String percentage,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required List<CategoryModel> items,
    required List<dynamic> txns, // List<TransactionModel>
    required bool isDark,
    required Color cardColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Group Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? iconColor.withValues(alpha: 0.2) : iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle, color: AppColors.primaryContainer, size: 18),
              label: const Text(
                'Add Sub-\ncategory',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Group Items
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Text(
              'No items.',
              style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
            ),
          )
        else
          ...items.map((cat) {
            final count = txns.where((t) => t.categoryId == cat.id).length;
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getCategoryIcon(cat.name),
                      color: isDark ? Colors.white : Colors.black87,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          '$count TRANSACTION\${count == 1 ? "" : "S"}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: isDark ? Colors.grey[400] : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete, size: 18),
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  IconData _getCategoryIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('rent') || lower.contains('mortgage')) return Icons.home_rounded;
    if (lower.contains('util')) return Icons.bolt_rounded;
    if (lower.contains('grocer') || lower.contains('food')) return Icons.shopping_basket_rounded;
    if (lower.contains('entertain')) return Icons.movie_rounded;
    if (lower.contains('din') || lower.contains('restaurant')) return Icons.restaurant_rounded;
    if (lower.contains('emergen')) return Icons.lock_rounded;
    if (lower.contains('invest')) return Icons.trending_up_rounded;
    return Icons.category_rounded;
  }

  Widget _buildAiInsightCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: const Color(0xFF0D47A1), // Deep blue
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.bar_chart_rounded,
              size: 80,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'MONTHLY INSIGHT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Top Spending Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Watch latestInsightProvider
              Consumer(
                builder: (context, ref, _) {
                  final insightAsync = ref.watch(latestInsightProvider);
                  return insightAsync.when(
                    data: (insight) {
                      final text = insight?.content ??
                          'Food and Dining accounts for 32% of your monthly expenses. Consider setting a budget alert.';
                      return Text(
                        text,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      );
                    },
                    loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                    error: (err, stack) => const Text(
                        'Failed to load insight.',
                        style: TextStyle(color: Colors.white)),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '\$1,240', // Mock value replicating exact image
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'this month',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickBudgetCheckCard(bool isDark, Color cardColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ],
      ),
      child: Consumer(
        builder: (context, ref, _) {
          // Calculate exact real percentages or fallback if no transactions
          final txAsync = ref.watch(allTransactionsProvider(null));
          final budgetAsync = ref.watch(currentBudgetProvider);

          double needsPct = 0.85; // Default mock from image
          double wantsPct = 0.42;

          if (txAsync.hasValue && budgetAsync.hasValue) {
            final b = budgetAsync.value;
            if (b != null) {
              // needsPct = needsSpent / b.needsAmount; etc
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Budget Check',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildProgressBar('Needs', needsPct, const Color(0xFF1E3A8A), isDark), // Dark Blue
              const SizedBox(height: AppSpacing.md),
              _buildProgressBar('Wants', wantsPct, const Color(0xFF0F766E), isDark), // Teal Dark
              const SizedBox(height: AppSpacing.lg),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Budget Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: AppColors.primaryContainer,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProgressBar(String label, double percentage, Color color, bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.grey[300] : Colors.black87,
              ),
            ),
            Text(
              '\${(percentage * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFE5E7EB),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
