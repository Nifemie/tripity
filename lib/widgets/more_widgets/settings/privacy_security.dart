import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Privacy & Security Item Type
enum PrivacyItemType {
  navigation,
  toggle,
}

// Privacy & Security Data Model
class PrivacySecurityItem {
  final String title;
  final String subtitle;
  final PrivacyItemType type;
  final bool? isEnabled;
  final VoidCallback? onTap;

  const PrivacySecurityItem({
    required this.title,
    required this.subtitle,
    required this.type,
    this.isEnabled,
    this.onTap,
  });
}

// Two-Factor Authentication provider
final twoFactorAuthProvider = StateProvider<bool>((ref) => true);

// Location Services provider
final locationServicesProvider = StateProvider<bool>((ref) => true);

// Activity Status provider
final activityStatusProvider = StateProvider<bool>((ref) => true);

// Privacy & Security Widget
class PrivacySecurityWidget extends ConsumerWidget {
  const PrivacySecurityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twoFactorEnabled = ref.watch(twoFactorAuthProvider);
    final locationEnabled = ref.watch(locationServicesProvider);
    final activityEnabled = ref.watch(activityStatusProvider);

    final privacyItems = [
      PrivacySecurityItem(
        title: 'Change Password',
        subtitle: 'Update your account password',
        type: PrivacyItemType.navigation,
        onTap: () => context.push('/change-password'),
      ),
      PrivacySecurityItem(
        title: 'Two-Factor Authentication (2FA)',
        subtitle: 'Add extra security to your account',
        type: PrivacyItemType.toggle,
        isEnabled: twoFactorEnabled,
      ),
      PrivacySecurityItem(
        title: 'Location Services',
        subtitle: 'Allow location access for better recommendations',
        type: PrivacyItemType.toggle,
        isEnabled: locationEnabled,
      ),
      PrivacySecurityItem(
        title: 'Activity Status',
        subtitle: 'Show when you\'re online',
        type: PrivacyItemType.toggle,
        isEnabled: activityEnabled,
      ),
    ];

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
          privacyItems.length,
          (index) {
            final item = privacyItems[index];
            final isLast = index == privacyItems.length - 1;

            return Column(
              children: [
                _PrivacySecurityListTile(
                  item: item,
                  onToggleChanged: (value) {
                    if (index == 1) {
                      ref.read(twoFactorAuthProvider.notifier).state = value;
                    } else if (index == 2) {
                      ref.read(locationServicesProvider.notifier).state = value;
                    } else if (index == 3) {
                      ref.read(activityStatusProvider.notifier).state = value;
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

// Privacy & Security List Tile
class _PrivacySecurityListTile extends StatelessWidget {
  final PrivacySecurityItem item;
  final ValueChanged<bool>? onToggleChanged;

  const _PrivacySecurityListTile({
    required this.item,
    this.onToggleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.type == PrivacyItemType.navigation ? item.onTap : null,
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

              // Toggle or Chevron
              if (item.type == PrivacyItemType.toggle)
                Switch(
                  value: item.isEnabled ?? false,
                  onChanged: onToggleChanged,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF3B82F6),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE5E7EB),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              else
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
class PrivacySecurityWidgetExample extends ConsumerWidget {
  const PrivacySecurityWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twoFactor = ref.watch(twoFactorAuthProvider);
    final location = ref.watch(locationServicesProvider);
    final activity = ref.watch(activityStatusProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PrivacySecurityWidget(),
            const SizedBox(height: 16),
            Text(
              '2FA: $twoFactor | Location: $location | Activity: $activity',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
