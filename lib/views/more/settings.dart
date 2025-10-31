import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/more_widgets/settings/personalization.dart';
import '../../widgets/more_widgets/settings/notifications.dart';
import '../../widgets/more_widgets/settings/privacy_security.dart';
import '../../widgets/more_widgets/settings/advanced.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF111827),
          ),
          onPressed: () {
            // Use GoRouter's pop method instead of Navigator.pop
            if (context.canPop()) {
              context.pop();
            } else {
              // Fallback to a specific route if can't pop
              context.go('/more'); // Adjust this to your main/more screen route
            }
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // PERSONALIZATION Section
                const _SectionLabel(label: 'PERSONALIZATION'),
                const SizedBox(height: 12),
                const PersonalizationWidget(),

                const SizedBox(height: 24),

                // NOTIFICATIONS Section
                const _SectionLabel(label: 'NOTIFICATIONS'),
                const SizedBox(height: 12),
                const NotificationWidget(),

                const SizedBox(height: 24),

                // PRIVACY & SECURITY Section
                const _SectionLabel(label: 'PRIVACY & SECURITY'),
                const SizedBox(height: 12),
                const PrivacySecurityWidget(),

                const SizedBox(height: 24),

                // ADVANCED Section
                const _SectionLabel(label: 'ADVANCED'),
                const SizedBox(height: 12),
                const AdvancedWidget(),

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