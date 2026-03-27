import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
                    // Main categories: have no parent (top-level roots)
                    final mainNeeds   = cats.where((c) => c.parentId == null && c.budgetType == 'needs').toList();
                    final mainWants   = cats.where((c) => c.parentId == null && c.budgetType == 'wants').toList();
                    final mainSavings = cats.where((c) => c.parentId == null && c.budgetType == 'savings').toList();
                    final mainIncome  = cats.where((c) => c.parentId == null && c.budgetType == 'income').toList();

                    // Sub-categories: have a parent_id pointing to a main category
                    final allSubs = cats.where((c) => c.parentId != null).toList();

                    // Build bucket for each main category, showing its specific sub-categories
                    List<Widget> buckets = [];
                    for (final main in mainNeeds) {
                      buckets.add(_buildBucketGroup(
                        context: context,
                        title: main.name,
                        percentage: '(50%)',
                        icon: Icons.check_circle_rounded,
                        iconColor: const Color(0xFF3B82F6),
                        iconBgColor: const Color(0xFFEFF6FF),
                        parentCategory: main,
                        subItems: allSubs.where((s) => s.parentId == main.id).toList(),
                        txns: txns,
                        isDark: isDark,
                        cardColor: cardColor,
                      ));
                      buckets.add(const SizedBox(height: AppSpacing.xl));
                    }
                    for (final main in mainWants) {
                      buckets.add(_buildBucketGroup(
                        context: context,
                        title: main.name,
                        percentage: '(30%)',
                        icon: Icons.favorite_rounded,
                        iconColor: const Color(0xFF14B8A6),
                        iconBgColor: const Color(0xFFF0FDFA),
                        parentCategory: main,
                        subItems: allSubs.where((s) => s.parentId == main.id).toList(),
                        txns: txns,
                        isDark: isDark,
                        cardColor: cardColor,
                      ));
                      buckets.add(const SizedBox(height: AppSpacing.xl));
                    }
                    for (final main in mainSavings) {
                      buckets.add(_buildBucketGroup(
                        context: context,
                        title: main.name,
                        percentage: '(20%)',
                        icon: Icons.savings_rounded,
                        iconColor: const Color(0xFF6366F1),
                        iconBgColor: const Color(0xFFEEF2FF),
                        parentCategory: main,
                        subItems: allSubs.where((s) => s.parentId == main.id).toList(),
                        txns: txns,
                        isDark: isDark,
                        cardColor: cardColor,
                      ));
                      buckets.add(const SizedBox(height: AppSpacing.xl));
                    }
                    for (final main in mainIncome) {
                      buckets.add(_buildBucketGroup(
                        context: context,
                        title: main.name,
                        percentage: '(Income)',
                        icon: Icons.trending_up_rounded,
                        iconColor: const Color(0xFF22C55E),
                        iconBgColor: const Color(0xFFF0FDF4),
                        parentCategory: main,
                        subItems: allSubs.where((s) => s.parentId == main.id).toList(),
                        txns: txns,
                        isDark: isDark,
                        cardColor: cardColor,
                      ));
                      buckets.add(const SizedBox(height: AppSpacing.xl));
                    }

                    return Column(children: buckets);
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
    required CategoryModel parentCategory,  // The main (protected) root category
    required List<CategoryModel> subItems,  // Only sub-categories under this parent
    required List<dynamic> txns,
    required bool isDark,
    required Color cardColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Group Header (Main Category — read-only, no edit/delete) ──────────
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
            // Add Sub-category passes the parentCategory.id as parent_id
            TextButton.icon(
              onPressed: () => _showAddSubcategoryDialog(parentCategory),
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

        // ── Sub-Category Items (editable & deletable) ─────────────────────────
        if (subItems.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 60, bottom: AppSpacing.sm),
            child: Text(
              'No sub-categories yet. Tap + to add one.',
              style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[400]),
            ),
          )
        else
          ...subItems.map((cat) {
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
                          '$count TRANSACTION${count == 1 ? '' : 'S'}',
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
                  // Sub-categories CAN be edited and deleted
                  IconButton(
                    onPressed: () => _showEditSubcategoryDialog(cat),
                    icon: const Icon(Icons.edit, size: 18),
                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                  ),
                  IconButton(
                    onPressed: () => _showDeleteConfirm(cat),
                    icon: const Icon(Icons.delete, size: 18),
                    color: AppColors.error.withValues(alpha: 0.8),
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
    return Consumer(
      builder: (context, ref, _) {
        final categoriesAsync = ref.watch(categoriesProvider);
        final transactionsAsync = ref.watch(allTransactionsProvider(null));
        final insightAsync = ref.watch(latestInsightProvider);

        // ── Compute real monthly spending ────────────────────────────────
        String topCategoryName = 'Spending';
        double topCategoryAmount = 0;
        double totalThisMonth = 0;

        final now = DateTime.now();
        final startOfMonth = DateTime(now.year, now.month, 1);

        if (transactionsAsync.hasValue && categoriesAsync.hasValue) {
          final txns = transactionsAsync.value!;
          final cats = categoriesAsync.value!;

          // Filter only expense transactions in this month
          final monthlyExpenses = txns.where((t) =>
              t.type == 'expense' &&
              t.date.isAfter(startOfMonth.subtract(const Duration(seconds: 1)))).toList();

          // Sum total spending this month
          totalThisMonth = monthlyExpenses.fold(0.0, (sum, t) => sum + t.amount);

          // Group by category to find top spender
          final Map<String, double> catTotals = {};
          for (final t in monthlyExpenses) {
            if (t.categoryId != null) {
              catTotals[t.categoryId!] = (catTotals[t.categoryId!] ?? 0) + t.amount;
            }
          }

          if (catTotals.isNotEmpty) {
            final topId = catTotals.entries.reduce((a, b) => a.value > b.value ? a : b).key;
            topCategoryAmount = catTotals[topId] ?? 0;
            final topCat = cats.where((c) => c.id == topId).firstOrNull;
            if (topCat != null) topCategoryName = topCat.name;
          }
        }

        // Format as Indonesian Rupiah
        String formatRupiah(double val) {
          if (val >= 1000000) return 'Rp ${(val / 1000000).toStringAsFixed(1)}M';
          if (val >= 1000) return 'Rp ${(val / 1000).toStringAsFixed(0)}K';
          return 'Rp ${val.toStringAsFixed(0)}';
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
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
                  // ── Badge ────────────────────────────────────────────────
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

                  // ── Title: Top Spending Category name ────────────────────
                  Text(
                    'Top: $topCategoryName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // ── AI Insight Text ──────────────────────────────────────
                  insightAsync.when(
                    data: (insight) {
                      final text = insight?.content ??
                          'Belum ada insight bulan ini. Tekan refresh untuk menganalisis pengeluaran Anda! 🧠';
                      return Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      );
                    },
                    loading: () => const SizedBox(
                      height: 40,
                      child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                    ),
                    error: (err, stack) => const Text(
                      'Failed to load insight.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // ── Top category spend + total + refresh button ──────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatRupiah(topCategoryAmount),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            'of ${formatRupiah(totalThisMonth)} total this month',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // ── AI Refresh button ────────────────────────────────
                      _AiRefreshButton(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
                onPressed: () => context.go('/accounts'),
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
              '${(percentage * 100).toInt()}%',
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

  // ── Add Sub-category (stores parent_id of the main category) ──────────────────
  Future<void> _showAddSubcategoryDialog(CategoryModel parentCategory) async {
    final nameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('New Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parent: ${parentCategory.name}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g. Groceries, Netflix, Gas',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                final userId = Supabase.instance.client.auth.currentUser?.id;
                if (userId == null) return;
                try {
                  await ref.read(categoryRepositoryProvider).createCategory({
                    'user_id': userId,
                    'name': name,
                    'parent_id': parentCategory.id,         // ← key: link to parent
                    'budget_type': parentCategory.budgetType, // inherit from parent
                    'type': parentCategory.type,
                  });
                  if (!dialogCtx.mounted) return;
                  Navigator.pop(dialogCtx);
                  ref.invalidate(categoriesProvider);
                } catch (e) {
                  if (!dialogCtx.mounted) return;
                  ScaffoldMessenger.of(dialogCtx).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Category'),
            ),
          ],
        );
      },
    );
  }

  // ── Edit Sub-category (rename only, preserves parent_id) ──────────────────────
  Future<void> _showEditSubcategoryDialog(CategoryModel category) async {
    final nameController = TextEditingController(text: category.name);

    await showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Edit Category'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                try {
                  await ref.read(categoryRepositoryProvider).updateCategory(category.id, {'name': name});
                  if (!dialogCtx.mounted) return;
                  Navigator.pop(dialogCtx);
                  ref.invalidate(categoriesProvider);
                } catch (e) {
                  if (!dialogCtx.mounted) return;
                  ScaffoldMessenger.of(dialogCtx).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirm(CategoryModel category) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Category?'),
        content: Text('Are you sure you want to delete "${category.name}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error, 
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      )
    );

    if (confirm == true) {
      try {
        await ref.read(categoryRepositoryProvider).deleteCategory(category.id);
        ref.invalidate(categoriesProvider);
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

// ─── AI Refresh Button ─────────────────────────────────────────────────────────
class _AiRefreshButton extends ConsumerStatefulWidget {
  const _AiRefreshButton();

  @override
  ConsumerState<_AiRefreshButton> createState() => _AiRefreshButtonState();
}

class _AiRefreshButtonState extends ConsumerState<_AiRefreshButton> {
  bool _loading = false;

  Future<void> _refresh() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      await ref.read(aiServiceProvider).generateInsights();
      ref.invalidate(latestInsightProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ AI Insight updated successfully!'),
            backgroundColor: Color(0xFF22C55E),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _refresh,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _loading
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : const Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
      ),
    );
  }
}
