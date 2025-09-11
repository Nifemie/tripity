import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../providers/auth_providers.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';
import 'package:go_router/go_router.dart';


class PlannerTravelPreferencesScreen extends ConsumerWidget {
  const PlannerTravelPreferencesScreen({super.key});

  void _handleCompleteSetup(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.read(selectedInterestsProvider);

    print('Travel Preferences:');
    print('Interests: $selectedInterests');

    // Navigate to next screen
    ref.read(progressProvider.notifier).increment();
    context.push('/planner-setup-complete');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.watch(selectedInterestsProvider);
    final isFormValid = ref.watch(isPreferencesValidProvider);
    final progressState = ref.watch(progressProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Header with back button and title
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(progressProvider.notifier).decrement();
                        context.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Account setup',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        height: 27.5 / 20, // 137.5%
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Progress bar - all steps completed
                ProgressBar(
                  currentStep: progressState.currentStep,
                  totalSteps: progressState.totalSteps,
                ),

                const SizedBox(height: 32),

                // What kind of trips title
                const Text(
                  'What kind of trips do you enjoy planning?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    height: 27.5 / 20, // 137.5%
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Let us know your specialties to help match you with the right travellers.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4B5563),
                    fontFamily: 'Instrument Sans',
                    height: 21 / 14, // 150%
                  ),
                ),

                const SizedBox(height: 24),

                // Interest categories grid (2x4)
                _buildInterestGrid(selectedInterests, ref),

                const SizedBox(height: 40),

                // Complete Setup Button
                Container(
                  width: double.infinity,
                  height: 52,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration:
                      isFormValid
                          ? BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            gradient: const LinearGradient(
                              begin: Alignment(-0.0421, -1.0),
                              end: Alignment(1.0712, 1.0),
                              colors: [
                                Color(0xFF3B82F6), // Primary Blue 500
                                Color(0xFF2563EB), // Primary Blue 600
                                Color(0xFF1E40AF), // Primary Blue 800
                              ],
                              stops: [0.0, 0.5145, 1.0712],
                            ),
                          )
                          : BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            color: const Color(0xFFE5E7EB),
                          ),
                  child: ElevatedButton(
                    onPressed:
                        isFormValid
                            ? () => _handleCompleteSetup(context, ref)
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      disabledBackgroundColor: Colors.transparent,
                      disabledForegroundColor: const Color(0xFF9CA3AF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Complete Setup',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Instrument Sans',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Widget _buildInterestGrid(Set<String> selectedInterests, WidgetRef ref) {
    final interests = [
      {
        'title': 'Adventure & Outdoor',
        'svgPath': 'assets/images/account_setup/Bonfire.svg',
      },
      {
        'title': 'Culture & History',
        'svgPath': 'assets/images/account_setup/Globus.svg',
      },
      {
        'title': 'Food & Dining',
        'svgPath': 'assets/images/account_setup/Chef Hat.svg',
      },
      {
        'title': 'Nightlife & Entertainment',
        'svgPath': 'assets/images/account_setup/Music Notes.svg',
      },
      {
        'title': 'Photography',
        'svgPath': 'assets/images/account_setup/Camera.svg',
      },
      {
        'title': 'Wellness & Relaxation',
        'svgPath': 'assets/images/account_setup/Meditation.svg',
      },
      {
        'title': 'Business Travel',
        'svgPath': 'assets/images/account_setup/Case.svg',
      },
      {
        'title': 'Family Friendly',
        'svgPath': 'assets/images/account_setup/Users.svg',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 187 / 100, // Keep original size
      ),
      itemCount: interests.length,
      itemBuilder: (context, index) {
        final interest = interests[index];
        final title = interest['title'] as String;
        final svgPath = interest['svgPath'] as String;
        final isSelected = selectedInterests.contains(title);

        return GestureDetector(
          onTap: () {
            final currentSelection = ref.read(selectedInterestsProvider);
            if (isSelected) {
              ref
                  .read(selectedInterestsProvider.notifier)
                  .state = currentSelection.difference({title});
            } else {
              ref
                  .read(selectedInterestsProvider.notifier)
                  .state = currentSelection.union({title});
            }
          },
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 10,
            ), // Optimized padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  isSelected
                      ? const Color(0xFFEBF4FF)
                      : const Color(0xFFF3F4F6),
              border:
                  isSelected
                      ? Border.all(color: const Color(0xFF3B82F6), width: 2)
                      : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 20, // Reduced icon size from 24 to 20
                  height: 20,
                ),
                const SizedBox(height: 4), // Reduced spacing
                Expanded(
                  // Use Expanded to fill remaining space
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12, // Smaller font
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        height: 1.1, // Tighter line height
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}