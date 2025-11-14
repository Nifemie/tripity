import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// Account Data Model
class AccountItem {
  final String title;
  final String subtitle;
  final String iconPath;
  final bool hasGradient;
  final int? badgeCount;
  final String? badgeText;
  final VoidCallback? onTap;

  const AccountItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.hasGradient = false,
    this.badgeCount,
    this.badgeText,
    this.onTap,
  });
}

// Wishlist count provider
final wishlistCountProvider = StateProvider<int>((ref) => 2);

// Account Widget
class AccountWidget extends ConsumerWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistCount = ref.watch(wishlistCountProvider);

    final accountItems = [
      AccountItem(
        title: 'Wishlist',
        subtitle: 'Saved destinations & bookings',
        iconPath: 'assets/images/more/Heart.svg',
        badgeCount: wishlistCount,
        onTap: () => context.push('/wishlist'),
      ),
      AccountItem(
        title: 'My Bookings',
        subtitle: 'View all your reservations',
        iconPath: 'assets/images/more/Calendar.svg',
        onTap: () => context.push('/my-bookings'),
      ),
      AccountItem(
        title: 'Wallet',
        subtitle: 'Manage your payments and balances',
        iconPath: 'assets/images/more/Wallet.svg',
        onTap: () => context.push('/wallet'),
      ),
      AccountItem(
        title: 'Subscribe to Premium',
        subtitle: 'Unlock more with Premium',
        iconPath: 'assets/images/more/Box.svg',
        hasGradient: true,
        badgeText: 'Free',
        onTap: () => context.push('/subscription'),
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
          accountItems.length,
          (index) {
            final item = accountItems[index];
            final isLast = index == accountItems.length - 1;

            return Column(
              children: [
                _AccountListTile(item: item),
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

// Account List Tile
class _AccountListTile extends StatelessWidget {
  final AccountItem item;

  const _AccountListTile({required this.item});

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
                decoration: BoxDecoration(
                  gradient: item.hasGradient
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF3B82F6),
                            Color(0xFF2563EB),
                            Color(0xFF1E40AF),
                          ],
                          stops: [0.0, 0.51, 1.0],
                        )
                      : null,
                  color: item.hasGradient ? null : const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item.iconPath,
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      item.hasGradient ? Colors.white : const Color(0xFF111827),
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

              // Badge or Arrow
              if (item.badgeCount != null)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${item.badgeCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              else if (item.badgeText != null)
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
                      item.badgeText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
class AccountWidgetExample extends ConsumerWidget {
  const AccountWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const AccountWidget(),
            const SizedBox(height: 16),
            // Example: Update wishlist count
            ElevatedButton(
              onPressed: () {
                ref.read(wishlistCountProvider.notifier).state++;
              },
              child: const Text('Add to Wishlist'),
            ),
          ],
        ),
      ),
    );
  }
}
