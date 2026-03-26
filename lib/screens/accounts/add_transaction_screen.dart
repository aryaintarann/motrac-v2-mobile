import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _type = 'expense';
  String? _selectedAccountId;
  String? _selectedToAccountId;
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an account')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text.replaceAll(',', ''));
      final userId = ref.read(currentUserProvider)?.id;

      final transaction = {
        'user_id': userId,
        'type': _type,
        'amount': amount,
        'date': _selectedDate.toIso8601String(),
        'account_id': _selectedAccountId,
        'note': _noteController.text.isEmpty ? null : _noteController.text,
        if (_selectedCategoryId != null) 'category_id': _selectedCategoryId,
        if (_type == 'transfer' && _selectedToAccountId != null)
          'to_account_id': _selectedToAccountId,
      };

      await ref.read(transactionRepositoryProvider).createTransaction(transaction);

      // Invalidate relevant providers
      ref.invalidate(recentTransactionsProvider);
      ref.invalidate(accountsProvider);
      ref.invalidate(totalBalanceProvider);
      ref.invalidate(weeklySpendingProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction added!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accounts = ref.watch(accountsProvider);
    final categories = _type == 'income'
        ? ref.watch(incomeCategoriesProvider)
        : ref.watch(expenseCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // ─── Type Selector ────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: Row(
                  children: [
                    _typeChip('expense', Icons.arrow_upward_rounded,
                        AppColors.expense, isDark),
                    _typeChip('income', Icons.arrow_downward_rounded,
                        AppColors.income, isDark),
                    _typeChip('transfer', Icons.swap_horiz_rounded,
                        AppColors.transfer, isDark),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // ─── Amount ────────────────────────────────────────────
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: 'Rp ',
                prefixStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Amount is required';
                if (double.tryParse(v.replaceAll(',', '')) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // ─── Account ──────────────────────────────────────────
            accounts.when(
              data: (accountList) => DropdownButtonFormField<String>(
                initialValue: _selectedAccountId,
                decoration: InputDecoration(
                  labelText: _type == 'transfer' ? 'From Account' : 'Account',
                  prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                ),
                items: accountList.map((a) {
                  return DropdownMenuItem(value: a.id, child: Text(a.name));
                }).toList(),
                onChanged: (v) => setState(() => _selectedAccountId = v),
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => const Text('Error loading accounts'),
            ),
            const SizedBox(height: AppSpacing.md),

            // ─── To Account (for transfer) ────────────────────────
            if (_type == 'transfer') ...[
              accounts.when(
                data: (accountList) => DropdownButtonFormField<String>(
                  initialValue: _selectedToAccountId,
                  decoration: const InputDecoration(
                    labelText: 'To Account',
                    prefixIcon: Icon(Icons.account_balance_outlined),
                  ),
                  items: accountList
                      .where((a) => a.id != _selectedAccountId)
                      .map((a) {
                    return DropdownMenuItem(value: a.id, child: Text(a.name));
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedToAccountId = v),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, _) => const Text('Error loading accounts'),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // ─── Category (for income/expense) ────────────────────
            if (_type != 'transfer')
              categories.when(
                data: (catList) => DropdownButtonFormField<String>(
                  initialValue: _selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: catList.map((c) {
                    return DropdownMenuItem(
                      value: c.id,
                      child: Text('${c.icon ?? ''} ${c.name}'),
                    );
                  }).toList(),
                  onChanged: (v) => setState(() => _selectedCategoryId = v),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, _) => const Text('Error loading categories'),
              ),
            const SizedBox(height: AppSpacing.md),

            // ─── Date ──────────────────────────────────────────────
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today_outlined),
              title: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
            ),
            const SizedBox(height: AppSpacing.md),

            // ─── Note ──────────────────────────────────────────────
            TextFormField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                prefixIcon: Icon(Icons.notes_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // ─── Submit ────────────────────────────────────────────
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            strokeWidth: 2.5, color: Colors.white),
                      )
                    : Text('Add ${_type[0].toUpperCase()}${_type.substring(1)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeChip(
      String type, IconData icon, Color color, bool isDark) {
    final isSelected = _type == type;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Material(
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() => _type = type),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Column(
                children: [
                  Icon(icon, color: isSelected ? color : Colors.grey, size: 22),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    type[0].toUpperCase() + type.substring(1),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? color : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
