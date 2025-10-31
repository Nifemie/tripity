import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Profile Header Data Model
class ProfileHeaderData {
  final String avatarUrl;
  final String fullName;
  final String memberSince;

  const ProfileHeaderData({
    required this.avatarUrl,
    required this.fullName,
    required this.memberSince,
  });
}

// Profile Header provider
final profileHeaderProvider = StateProvider<ProfileHeaderData>((ref) {
  return const ProfileHeaderData(
    avatarUrl: 'https://i.pravatar.cc/150?img=12',
    fullName: 'Benjamin Adeyemi',
    memberSince: 'Member since 2025',
  );
});

// Profile Header Widget
class ProfileHeaderWidget extends ConsumerWidget {
  final VoidCallback? onEditPhoto;

  const ProfileHeaderWidget({
    Key? key,
    this.onEditPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileHeaderProvider);

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with Camera Icon
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Avatar
              Container(
                width: 102,
                height: 102,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(profileData.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Camera Icon Button
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditPhoto ?? () => print('Edit photo tapped'),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Full Name
          Text(
            profileData.fullName,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.375,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Traveler Badge
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

          const SizedBox(height: 8),

          // Member Since
          Text(
            profileData.memberSince,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Example Usage
class ProfileHeaderExample extends ConsumerWidget {
  const ProfileHeaderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeaderWidget(
              onEditPhoto: () {
                // Handle photo edit
                print('Edit photo');
              },
            ),
            const SizedBox(height: 16),
            // Example: Update profile
            ElevatedButton(
              onPressed: () {
                ref.read(profileHeaderProvider.notifier).state =
                const ProfileHeaderData(
                  avatarUrl: 'https://i.pravatar.cc/150?img=8',
                  fullName: 'John Doe',
                  memberSince: 'Member since 2024',
                );
              },
              child: const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}