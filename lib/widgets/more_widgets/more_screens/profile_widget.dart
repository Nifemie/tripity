import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User Model
class UserProfile {
  final String avatarUrl;
  final String fullName;
  final String email;
  final int tripsCompleted;
  final int memberSinceYear;

  const UserProfile({
    required this.avatarUrl,
    required this.fullName,
    required this.email,
    required this.tripsCompleted,
    required this.memberSinceYear,
  });
}

// Riverpod Provider for User Profile
final userProfileProvider = StateProvider<UserProfile>((ref) {
  return const UserProfile(
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    fullName: 'Benjamin Adeyemi',
    email: 'ben.adeyemi@email.com',
    tripsCompleted: 5,
    memberSinceYear: 2025,
  );
});

// Profile Card Widget with Riverpod
class TravelProfileCard extends ConsumerWidget {
  final VoidCallback? onTap;

  const TravelProfileCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(profile.avatarUrl),
                  backgroundColor: const Color(0xFFF3F4F6),
                ),
                const SizedBox(width: 12),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name and Badge Row
                      Row(
                        children: [
                          Text(
                            profile.fullName,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFDBEAFE),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: const Text(
                              'Traveler',
                              style: TextStyle(
                                color: Color(0xFF2563EB),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Email
                      Text(
                        profile.email,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Trip Info
                      Text(
                        '${profile.tripsCompleted} trips completed • Member since ${profile.memberSinceYear}',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chevron Icon
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF9CA3AF),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// How to update the profile (example):
// ref.read(userProfileProvider.notifier).state = UserProfile(
//   avatarUrl: 'new_url',
//   fullName: 'New Name',
//   email: 'new@email.com',
//   tripsCompleted: 10,
//   memberSinceYear: 2024,
// );