import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/providers.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(notificationRepositoryProvider).markAllAsRead();
              ref.invalidate(notificationsProvider);
              ref.invalidate(unreadNotificationsCountProvider);
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(notificationsProvider);
          ref.invalidate(unreadNotificationsCountProvider);
        },
        child: notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return const Center(child: Text('No new notifications'));
            }
            return ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final note = notifications[index];
                return ListTile(
                  tileColor: note.isRead ? null : AppColors.primaryFixed.withValues(alpha: 0.3),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.surfaceContainerHigh,
                    child: Icon(
                      note.type == 'alert' ? Icons.warning_amber_rounded 
                      : note.type == 'success' ? Icons.check_circle_outline
                      : Icons.info_outline,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(note.title, style: TextStyle(fontWeight: note.isRead ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(note.message, style: const TextStyle(fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(DateFormat('MMM dd, hh:mm a').format(note.createdAt), 
                           style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                  onTap: () async {
                    if (!note.isRead) {
                      await ref.read(notificationRepositoryProvider).markAsRead(note.id);
                      ref.invalidate(notificationsProvider);
                      ref.invalidate(unreadNotificationsCountProvider);
                    }
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
