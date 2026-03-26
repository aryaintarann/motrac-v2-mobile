import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class DebtManagerScreen extends ConsumerWidget {
  const DebtManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debts = ref.watch(debtsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Debts & Receivables'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'I Owe'),
              Tab(text: 'Owed to Me'),
            ],
            labelColor: AppColors.primaryLight,
            unselectedLabelColor: isDark
                ? AppColors.onSurfaceVariantDark
                : AppColors.onSurfaceVariantLight,
            indicatorColor: AppColors.primaryLight,
          ),
        ),
        body: debts.when(
          data: (debtList) {
            final iOwe =
                debtList.where((d) => d.direction == 'i_owe').toList();
            final owedToMe =
                debtList.where((d) => d.direction == 'owed_to_me').toList();

            return TabBarView(
              children: [
                _DebtList(debts: iOwe, formatter: formatter, isDark: isDark),
                _DebtList(debts: owedToMe, formatter: formatter, isDark: isDark),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class _DebtList extends StatelessWidget {
  final List<dynamic> debts;
  final NumberFormat formatter;
  final bool isDark;

  const _DebtList({
    required this.debts,
    required this.formatter,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    if (debts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.handshake_outlined,
              size: 64,
              color: isDark
                  ? AppColors.onSurfaceVariantDark
                  : AppColors.onSurfaceVariantLight,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No debts',
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

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: debts.length,
      itemBuilder: (context, index) {
        final debt = debts[index];
        final dateFormat = DateFormat('dd MMM yyyy');

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            debt.counterparty,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          if (debt.dueDate != null)
                            Text(
                              'Due: ${dateFormat.format(debt.dueDate!)}',
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
                    Text(
                      formatter.format(debt.principal),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (debt.interestRate != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Interest: ${debt.interestRate}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.onSurfaceVariantDark
                          : AppColors.onSurfaceVariantLight,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
