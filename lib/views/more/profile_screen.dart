
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Import your widgets
import '../../../widgets/more_widgets/profile/profile_card.dart';
import '../../../widgets/more_widgets/profile/personal_information.dart';
import '../../../widgets/more_widgets/profile/travel_interest.dart';
import '../../../widgets/more_widgets/profile/Travel_stats.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () =>  Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {
              // Navigate to edit profile screen using go_router
              context.push('/edit-profile');
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
            label: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Profile Header Widget
              const ProfileHeaderWidget(),

              const SizedBox(height: 24),

              // TRAVEL STATS Section
              const _SectionLabel(label: 'TRAVEL STATS'),
              const SizedBox(height: 12),
              const TravelStatsWidget(),

              const SizedBox(height: 24),

              // PERSONAL INFORMATION Section
              const _SectionLabel(label: 'PERSONAL INFORMATION'),
              const SizedBox(height: 12),
              const PersonalInformationWidget(),

              const SizedBox(height: 24),

              // TRAVEL INTERESTS Section
              const _SectionLabel(label: 'TRAVEL INTERESTS'),
              const SizedBox(height: 12),
              const TravelInterestsWidget(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Section Label Widget
class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.5,
      ),
    );
  }
}
