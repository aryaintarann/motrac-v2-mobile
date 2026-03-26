import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class ReconciliationScreen extends ConsumerStatefulWidget {
  const ReconciliationScreen({super.key});

  @override
  ConsumerState<ReconciliationScreen> createState() =>
      _ReconciliationScreenState();
}

class _ReconciliationScreenState extends ConsumerState<ReconciliationScreen> {
  final _balanceController = TextEditingController();
  String? _selectedAccountId;
  bool _isLoading = false;

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _reconcile() async {
    if (_selectedAccountId == null || _balanceController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final actualBalance =
          double.parse(_balanceController.text.replaceAll(',', ''));
      final account =
          await ref.read(accountRepositoryProvider).getAccount(_selectedAccountId!);
      final adjustment = actualBalance - account.balance;

      final userId = ref.read(currentUserProvider)?.id;

      // Create reconciliation record
      await ref.read(supabaseClientProvider).from('account_reconciliations').insert({
        'user_id': userId,
        'account_id': _selectedAccountId,
        'actual_balance': actualBalance,
        'app_balance': account.balance,
        'adjustment': adjustment,
      });

      // Create adjustment transaction if difference exists
      if (adjustment != 0) {
        await ref.read(transactionRepositoryProvider).createTransaction({
          'user_id': userId,
          'type': adjustment > 0 ? 'income' : 'expense',
          'amount': adjustment.abs(),
          'account_id': _selectedAccountId,
          'note': 'Reconciliation adjustment',
          'date': DateTime.now().toIso8601String(),
        });
      }

      // Update account balance
      await ref
          .read(accountRepositoryProvider)
          .updateAccount(_selectedAccountId!, {'balance': actualBalance});

      ref.invalidate(accountsProvider);
      ref.invalidate(totalBalanceProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(adjustment == 0
                ? 'Balance verified ✓'
                : 'Adjusted by ${NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0).format(adjustment)}'),
          ),
        );
        context.pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accounts = ref.watch(accountsProvider);
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Reconcile')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.compare_arrows_rounded,
                      size: 32, color: AppColors.primaryLight),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Balance Reconciliation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Compare your actual bank/wallet balance with the app\'s tracked balance.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          accounts.when(
            data: (accountList) => DropdownButtonFormField<String>(
              value: _selectedAccountId,
              decoration: const InputDecoration(
                labelText: 'Select Account',
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              items: accountList.map((a) {
                return DropdownMenuItem(
                  value: a.id,
                  child: Text('${a.name} (${formatter.format(a.balance)})'),
                );
              }).toList(),
              onChanged: (v) => setState(() => _selectedAccountId = v),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Error'),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _balanceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            decoration: const InputDecoration(
              labelText: 'Actual Balance',
              prefixText: 'Rp ',
              prefixStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _reconcile,
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2.5, color: Colors.white),
                    )
                  : const Text('Reconcile'),
            ),
          ),
        ],
      ),
    );
  }
}
