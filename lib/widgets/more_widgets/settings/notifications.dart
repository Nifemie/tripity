import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notification Data Model
class NotificationItem {
  final String title;
  final String subtitle;
  final bool isEnabled;

  const NotificationItem({
    required this.title,
    required this.subtitle,
    required this.isEnabled,
  });

  NotificationItem copyWith({
    String? title,
    String? subtitle,
    bool? isEnabled,
  }) {
    return NotificationItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

// Push Notifications provider
final pushNotificationsProvider = StateProvider<bool>((ref) => true);

// Email Notifications provider
final emailNotificationsProvider = StateProvider<bool>((ref) => true);

// Trip Reminders provider
final tripRemindersProvider = StateProvider<bool>((ref) => true);

// Notification items provider
final notificationItemsProvider = Provider<List<NotificationItem>>((ref) {
  final pushEnabled = ref.watch(pushNotificationsProvider);
  final emailEnabled = ref.watch(emailNotificationsProvider);
  final tripRemindersEnabled = ref.watch(tripRemindersProvider);

  return [
    NotificationItem(
      title: 'Push Notifications',
      subtitle: 'Get alerts on your device',
      isEnabled: pushEnabled,
    ),
    NotificationItem(
      title: 'Email Notifications',
      subtitle: 'Receive notifications via email',
      isEnabled: emailEnabled,
    ),
    NotificationItem(
      title: 'Trip Reminders',
      subtitle: 'Get notified about upcoming trips',
      isEnabled: tripRemindersEnabled,
    ),
  ];
});

// Notification Widget
class NotificationWidget extends ConsumerWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationItems = ref.watch(notificationItemsProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14172554),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          notificationItems.length,
              (index) {
            final item = notificationItems[index];
            final isLast = index == notificationItems.length - 1;

            return Column(
              children: [
                _NotificationListTile(
                  item: item,
                  onChanged: (value) {
                    // Update the corresponding provider
                    if (index == 0) {
                      ref.read(pushNotificationsProvider.notifier).state = value;
                    } else if (index == 1) {
                      ref.read(emailNotificationsProvider.notifier).state = value;
                    } else if (index == 2) {
                      ref.read(tripRemindersProvider.notifier).state = value;
                    }
                  },
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF3F4F6),
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Notification List Tile
class _NotificationListTile extends StatelessWidget {
  final NotificationItem item;
  final ValueChanged<bool> onChanged;

  const _NotificationListTile({
    required this.item,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Toggle Switch
          Switch(
            value: item.isEnabled,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF3B82F6),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE5E7EB),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

// Example Usage
class NotificationWidgetExample extends ConsumerWidget {
  const NotificationWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const NotificationWidget(),
            const SizedBox(height: 16),
            // Display current states
            Consumer(
              builder: (context, ref, child) {
                final push = ref.watch(pushNotificationsProvider);
                final email = ref.watch(emailNotificationsProvider);
                final reminders = ref.watch(tripRemindersProvider);

                return Text(
                  'Push: $push | Email: $email | Reminders: $reminders',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}