import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Support Data Model
class SupportItem {
  final String title;
  final String subtitle;
  final String iconPath;
  final VoidCallback? onTap;

  const SupportItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.onTap,
  });
}

// Support items provider
final supportItemsProvider = Provider<List<SupportItem>>((ref) {
  return [
    SupportItem(
      title: 'Settings',
      subtitle: 'Manage app preferences and security',
      iconPath: 'assets/nice/icons.svg',
      onTap: () => print('Settings tapped'),
    ),
    SupportItem(
      title: 'Help & Support',
      subtitle: 'Get answers or contact support',
      iconPath: 'assets/nice/icons.svg',
      onTap: () => print('Help & Support tapped'),
    ),
    SupportItem(
      title: 'Invite Friends',
      subtitle: 'Share Triptify with others',
      iconPath: 'assets/nice/icons.svg',
      onTap: () => print('Invite Friends tapped'),
    ),
  ];
});

// Support Widget
class SupportWidget extends ConsumerWidget {
  const SupportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportItems = ref.watch(supportItemsProvider);

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
          supportItems.length,
              (index) {
            final item = supportItems[index];
            final isLast = index == supportItems.length - 1;

            return Column(
              children: [
                _SupportListTile(item: item),
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

// Support List Tile
class _SupportListTile extends StatelessWidget {
  final SupportItem item;

  const _SupportListTile({required this.item});

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
