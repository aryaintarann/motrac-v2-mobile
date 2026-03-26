import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});

  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  String _type = 'Bank';
  final String _currency = 'IDR';
  bool _isLoading = false;

  final List<String> _types = ['Bank', 'E-Wallet', 'Cash', 'Credit'];

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final balance = double.parse(_balanceController.text.replaceAll(',', ''));
      final userId = ref.read(currentUserProvider)?.id;

      final account = {
        'user_id': userId,
        'name': _nameController.text.trim(),
        'type': _type.toLowerCase(),
        'balance': balance,
        'currency': _currency,
        'color': '#0052CC', // Default to primaryContainer color
      };

      await ref.read(accountRepositoryProvider).createAccount(account);

      ref.invalidate(accountsProvider);
      ref.invalidate(totalBalanceProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account added successfully!')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Account Name',
                hintText: 'e.g., BCA Everyday, GoPay',
              ),
              validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(labelText: 'Account Type'),
              items: _types.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _type = v);
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _balanceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Initial Balance',
                prefixText: 'Rp ',
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Balance is required';
                if (double.tryParse(v.replaceAll(',', '')) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            GradientButton(
              onPressed: _isLoading ? null : _submit,
              isLoading: _isLoading,
              child: const Text('Save Account'),
            ),
          ],
        ),
      ),
    );
  }
}
