import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Communication Data Model
class CommunicationItem {
  final String title;
  final String subtitle;
  final String iconPath;
  final int? newCount;
  final VoidCallback? onTap;

  const CommunicationItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.newCount,
    this.onTap,
  });
}

// New chats count provider
final newChatsCountProvider = StateProvider<int>((ref) => 4);

// New notifications count provider
final newNotificationsCountProvider = StateProvider<int>((ref) => 2);

// Communication items provider
final communicationItemsProvider = Provider<List<CommunicationItem>>((ref) {
  final chatsCount = ref.watch(newChatsCountProvider);
  final notificationsCount = ref.watch(newNotificationsCountProvider);

  return [
    CommunicationItem(
      title: 'Chats',
      subtitle: 'Messages with trip planners',
      iconPath: 'assets/images/more/Chat_Dots.svg',
      newCount: chatsCount,
      onTap: () => print('Chats tapped'),
    ),
    CommunicationItem(
      title: 'Notifications',
      subtitle: 'Trip updates and alerts',
      iconPath: 'assets/images/more/notification.svg',
      newCount: notificationsCount,
      onTap: () => print('Notifications tapped'),
    ),
  ];
});

// Communication Widget
class CommunicationWidget extends ConsumerWidget {
  const CommunicationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communicationItems = ref.watch(communicationItemsProvider);

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
          communicationItems.length,
              (index) {
            final item = communicationItems[index];
            final isLast = index == communicationItems.length - 1;

            return Column(
              children: [
                _CommunicationListTile(item: item),
                if (!isLast)
                  const Padding(
                    padding: EdgeInsets.only(left: 68),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFF3F4F6),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Communication List Tile
class _CommunicationListTile extends StatelessWidget {
  final CommunicationItem item;

  const _CommunicationListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item.iconPath,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF111827),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

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

              // New Count Badge
              if (item.newCount != null && item.newCount! > 0)
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Center(
                    child: Text(
                      '${item.newCount} New',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 8),

              // Chevron Arrow
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example Usage
class CommunicationWidgetExample extends ConsumerWidget {
  const CommunicationWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Communication'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CommunicationWidget(),
            const SizedBox(height: 16),
            // Example: Update counts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(newChatsCountProvider.notifier).state++;
                  },
                  child: const Text('New Chat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(newNotificationsCountProvider.notifier).state++;
                  },
                  child: const Text('New Notification'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}