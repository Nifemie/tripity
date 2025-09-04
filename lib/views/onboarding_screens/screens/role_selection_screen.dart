import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/progress_provider.dart';
import 'package:tripitify/widgets/progress_bar.dart';

// State management with Riverpod
enum UserRole { none, personal, serviceProvider, both }

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.none);

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(userRoleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Back button and Welcome title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'Instrument Sans',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Progress bar - connected segments
              const ProgressBar(),
              const SizedBox(height: 24),
              // Main question
              const Text(
                'What brings you to Tripitify?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  height: 1.375,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your role to personalize your experience',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                  fontFamily: 'Instrument Sans',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Role options
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RoleOptionCard(
                        icon: Icons.person_outline,
                        title: 'I want to explore & plan my own trips',
                        description:
                            'Plan your own adventures, get AI recommendations, or work with professional trip planners',
                        tags: const [
                          'Self Planning',
                          'AI Recommendations',
                          'Professional Help',
                        ],
                        role: UserRole.personal,
                        isSelected: selectedRole == UserRole.personal,
                        onTap:
                            () => ref
                                .read(userRoleProvider.notifier)
                                .update((state) => UserRole.personal),
                      ),
                      const SizedBox(height: 16),
                      RoleOptionCard(
                        icon: Icons.person_outline,
                        title: 'I want to offer trip planning services',
                        description:
                            'Share your travel expertise, earn money by planning trips, and build your reputation',
                        tags: const [
                          'Earn Money',
                          'Share Expertise',
                          'Build Reputation',
                        ],
                        role: UserRole.serviceProvider,
                        isSelected: selectedRole == UserRole.serviceProvider,
                        onTap:
                            () => ref
                                .read(userRoleProvider.notifier)
                                .update((state) => UserRole.serviceProvider),
                      ),
                      const SizedBox(height: 16),
                      RoleOptionCard(
                        icon: Icons.groups_outlined,
                        title: 'I want to do both',
                        description:
                            'Plan your own trips and help others too. Get the full Tripitify experience',
                        tags: const [
                          'Complete Access',
                          'Community',
                          'Flexibility',
                        ],
                        role: UserRole.both,
                        isSelected: selectedRole == UserRole.both,
                        onTap:
                            () => ref
                                .read(userRoleProvider.notifier)
                                .update((state) => UserRole.both),
                      ),
                    ],
                  ),
                ),
              ),
              // Replace the Continue button section in TripitifyOnboardingScreen with this:

const SizedBox(height: 24),
// Continue button
SizedBox(
  width: double.infinity,
  height: 52,
  child: ElevatedButton(
    onPressed: selectedRole != UserRole.none
        ? () {
            // Handle navigation based on selected role
            switch (selectedRole) {
              case UserRole.personal:
                // Navigate to account setup for personal users
                Navigator.pushNamed(context, '/explore-setup', arguments: selectedRole);
                break;
              case UserRole.serviceProvider:
                // You can create a separate route for service providers
                // For now, let's use the same account setup
                Navigator.pushNamed(context, '/planner-account-setup', arguments: selectedRole);
                break;
              case UserRole.both:
                // Navigate to account setup for users who want both
                Navigator.pushNamed(context, '/explore-setup', arguments: selectedRole);
                break;
              case UserRole.none:
                // This shouldn't happen due to the null check
                break;
            }
            
            ref.read(progressProvider.notifier).increment();
            // Optional: Store the selected role for use in the next screen
            // You can pass it as arguments or store it in a global state
            print('Navigating with role: $selectedRole');
          }
        : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: selectedRole != UserRole.none
          ? const Color(0xFF3B82F6) // Primary Blue 500
          : const Color(0xFFD1D5DB), // Disabled Gray
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
    ),
    child: const Text(
      'Continue',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
),
const SizedBox(height: 32),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color:
              isSelected
                  ? const Color(
                    0xFFEBF4FF,
                  ) // Light blue background when selected
                  : const Color(0xFFF3F4F6), // Neutral Gray 100
          border:
              isSelected
                  ? Border.all(
                    color: const Color(0xFF3B82F6), // Primary Blue 500
                    width: 2,
                  )
                  : Border.all(
                    color: const Color(0xFFE5E7EB), // Light gray border
                    width: 1,
                  ),
        ),
        child: Stack(
          children: [
            // Main content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? const Color(0xFF3B82F6) // Primary Blue 500
                            : const Color(
                              0xFFF9FAFB,
                            ), // Very light gray background
                    borderRadius: BorderRadius.circular(20),
                    border:
                        isSelected
                            ? null
                            : Border.all(
                              color: const Color(
                                0xFFE5E7EB,
                              ), // Light gray border
                              width: 1,
                            ),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          fontFamily: 'Instrument Sans',
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Description
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4B5563),
                          fontFamily: 'Instrument Sans',
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            tags
                                .map(
                                  (tag) => TagChip(
                                    label: tag,
                                    isSelected: isSelected,
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Checkmark icon in top right corner
            if (isSelected)
              Positioned(
                top: 1,
                right: 1,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3B82F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TagChip({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white, // Always white background
        border: Border.all(
          color:
              isSelected
                  ? const Color(0xFF3B82F6) // Primary Blue 500 when selected
                  : const Color(0xFFE5E7EB), // Gray border when not selected
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color:
              isSelected
                  ? const Color(0xFF3B82F6) // Primary Blue 500 when selected
                  : const Color(0xFF6B7280), // Gray 500 when not selected
        ),
      ),
    );
  }
}
