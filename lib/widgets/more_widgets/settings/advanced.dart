import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Advanced Data Model
class AdvancedItem {
  final String title;
  final String subtitle;
  final bool isDanger;
  final VoidCallback? onTap;

  const AdvancedItem({
    required this.title,
    required this.subtitle,
    this.isDanger = false,
    this.onTap,
  });
}

// Advanced items provider
final advancedItemsProvider = Provider<List<AdvancedItem>>((ref) {
  return [
    AdvancedItem(
      title: 'Clear Cache',
      subtitle: 'Free up storage space',
      isDanger: false,
      onTap: () => print('Clear Cache tapped'),
    ),
    AdvancedItem(
      title: 'Reset Settings',
      subtitle: 'Reset all settings to defaults',
      isDanger: true,
      onTap: () => print('Reset Settings tapped'),
    ),
  ];
});

// Advanced Widget
class AdvancedWidget extends ConsumerWidget {
  const AdvancedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advancedItems = ref.watch(advancedItemsProvider);

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
          advancedItems.length,
              (index) {
            final item = advancedItems[index];
            final isLast = index == advancedItems.length - 1;

            return Column(
              children: [
                _AdvancedListTile(item: item),
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

// Advanced List Tile
class _AdvancedListTile extends StatelessWidget {
  final AdvancedItem item;

  const _AdvancedListTile({required this.item});

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
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: item.isDanger
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF111827),
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
class AdvancedWidgetExample extends ConsumerWidget {
  const AdvancedWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Advanced'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: AdvancedWidget(),
      ),
    );
  }
}