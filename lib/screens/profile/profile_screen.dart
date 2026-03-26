import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // ─── Profile Header ────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(
                      (user?.email?.substring(0, 1) ?? 'U').toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.userMetadata?['full_name'] ??
                              user?.email?.split('@').first ??
                              'User',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.onSurfaceVariantDark
                                : AppColors.onSurfaceVariantLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ─── My Profile Section ─────────────────────────────────
          _SectionHeader('My Profile', isDark),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Name, nickname, avatar',
                  onTap: () {},
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.currency_exchange_rounded,
                  title: 'Base Currency',
                  subtitle: 'IDR',
                  onTap: () {},
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Date Format',
                  subtitle: 'DD/MM/YYYY',
                  onTap: () {},
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.smart_toy_outlined,
                  title: 'AI Tone',
                  subtitle: 'Professional',
                  onTap: () {},
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'System',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ─── Security Section ───────────────────────────────────
          _SectionHeader('Security', isDark),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  onTap: () => _showChangePasswordDialog(context, ref),
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.security_rounded,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Protect your account',
                  onTap: () {},
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.devices_rounded,
                  title: 'Active Sessions',
                  onTap: () => _showSessionsDialog(context, ref),
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.download_rounded,
                  title: 'Export Data (CSV)',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ─── Danger Zone ────────────────────────────────────────
          _SectionHeader('Danger Zone', isDark),
          Card(
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.logout_rounded,
                  title: 'Sign Out',
                  textColor: AppColors.warning,
                  onTap: () async {
                    await ref.read(authRepositoryProvider).signOut();
                    if (context.mounted) context.go('/login');
                  },
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.logout_rounded,
                  title: 'Sign Out Everywhere',
                  textColor: AppColors.warning,
                  onTap: () async {
                    await ref.read(authRepositoryProvider).signOutEverywhere();
                    if (context.mounted) context.go('/login');
                  },
                ),
                const Divider(),
                _SettingsTile(
                  icon: Icons.delete_forever_rounded,
                  title: 'Delete Account',
                  textColor: AppColors.error,
                  onTap: () => _showDeleteAccountDialog(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Password'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'New Password'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await ref
                    .read(authRepositoryProvider)
                    .updateUser(password: controller.text);
                if (ctx.mounted) Navigator.pop(ctx);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password updated!')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showSessionsDialog(BuildContext context, WidgetRef ref) async {
    try {
      final sessions = await ref.read(authRepositoryProvider).getActiveSessions();
      if (!context.mounted) return;

      showModalBottomSheet(
        context: context,
        builder: (ctx) => Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Sessions (${sessions.length})',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppSpacing.md),
              ...sessions.map((s) => ListTile(
                    leading: const Icon(Icons.devices_rounded),
                    title: Text(s['user_agent'] ?? 'Unknown device'),
                    subtitle:
                        Text('IP: ${s['ip'] ?? 'N/A'}'),
                  )),
            ],
          ),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action is PERMANENT and cannot be undone. All your data will be deleted. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              try {
                await ref.read(authRepositoryProvider).deleteAccount();
                if (ctx.mounted) Navigator.pop(ctx);
                if (context.mounted) context.go('/login');
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionHeader(this.title, this.isDark);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppSpacing.xs, bottom: AppSpacing.sm),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: isDark
              ? AppColors.onSurfaceVariantDark
              : AppColors.onSurfaceVariantLight,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? textColor;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.primaryLight, size: 22),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: onTap,
    );
  }
}
