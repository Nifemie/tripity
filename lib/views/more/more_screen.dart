import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/more_widgets/more_screens/account_widget.dart';
import '../../widgets/more_widgets/more_screens/communication_widget.dart';
import '../../widgets/more_widgets/more_screens/support_settings.dart';
import '../../widgets/more_widgets/more_screens/profile_widget.dart';
import '../../widgets/more_widgets/more_screens/Travel_management_widget.dart';
import 'package:go_router/go_router.dart';


class MoreScreen extends ConsumerWidget {
  const MoreScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Header: More and Sign Out
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'More',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.375,
                      ),
                    ),

                    // Sign Out Button
                    GestureDetector(
                      onTap: () {
                        // Handle sign out
                        print('Sign out tapped');
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/images/more/Logout.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFEF4444),
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Profile Widget
                TravelProfileCard(
                  onTap: () {
                    context.push('/profile');  // or context.push('/profile')
                  },
                ),

                const SizedBox(height: 24),

                // ACCOUNT Section
                const _SectionLabel(label: 'ACCOUNT'),
                const SizedBox(height: 12),
                const AccountWidget(),

                const SizedBox(height: 24),

                // COMMUNICATION Section
                const _SectionLabel(label: 'COMMUNICATION'),
                const SizedBox(height: 12),
                const CommunicationWidget(),

                const SizedBox(height: 24),

                // TRAVEL MANAGEMENT Section
                const _SectionLabel(label: 'TRAVEL MANAGEMENT'),
                const SizedBox(height: 12),
                const TravelerManagement(),

                const SizedBox(height: 24),

                // SUPPORT & SETTINGS Section
                const _SectionLabel(label: 'SUPPORT & SETTINGS'),
                const SizedBox(height: 12),
                const SupportWidget(),

                const SizedBox(height: 32),

                // Footer
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Tripitify v1.0.0',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '© 2025 Tripitify. All rights reserved.',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
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
