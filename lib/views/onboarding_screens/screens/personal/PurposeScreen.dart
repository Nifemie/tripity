import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../screens/role_selection_screen.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';


// State provider for selected purpose
final selectedPurposeProvider = StateProvider<int?>((ref) => null);


class PurposeScreen extends ConsumerWidget {
  final UserRole? role;
  const PurposeScreen({Key? key, this.role}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPurpose = ref.watch(selectedPurposeProvider);
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

                // Title
                const Text(
                  'Any other purpose?',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.375,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'To personalize your experience, we want to understand your full intent.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // Purpose options - REMOVED Expanded widget
                Column(
                  children: [
                    PurposeOption(
                      index: 0,
                      title: 'Planning a vacation',
                      subtitle: 'Short-term stays for your holiday.',
                      assetPath: 'assets/images/account_setup/Suitcase.svg',
                      isSelected: selectedPurpose == 0,
                      onTap: () => ref.read(selectedPurposeProvider.notifier).state = 0,
                    ),

                    const SizedBox(height: 16),

                    PurposeOption(
                      index: 1,
                      title: 'Looking for a temporary stay',
                      subtitle: 'For work, study, or transitions.',
                      assetPath: 'assets/images/account_setup/Case.svg',
                      isSelected: selectedPurpose == 1,
                      onTap: () => ref.read(selectedPurposeProvider.notifier).state = 1,
                    ),

                    const SizedBox(height: 16),

                    PurposeOption(
                      index: 2,
                      title: 'Considering a relocation',
                      subtitle: 'Find a new place to call home.',
                      assetPath: 'assets/images/account_setup/Home.svg',
                      isSelected: selectedPurpose == 2,
                      onTap: () => ref.read(selectedPurposeProvider.notifier).state = 2,
                    ),

                    const SizedBox(height: 16),

                    PurposeOption(
                      index: 3,
                      title: 'Just exploring',
                      subtitle: 'Browse and see what\'s possible.',
                      assetPath: 'assets/images/account_setup/Compass.svg',
                      isSelected: selectedPurpose == 3,
                      onTap: () => ref.read(selectedPurposeProvider.notifier).state = 3,
                    ),
                  ],
                ),

                const SizedBox(height: 132),

                // Complete Setup Button
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    gradient: const LinearGradient(
                      begin: Alignment(-0.04, -1.0),
                      end: Alignment(1.07, 1.0),
                      colors: [
                        Color(0xFF3B82F6),
                        Color(0xFF2563EB),
                        Color(0xFF1E40AF),
                      ],
                      stops: [0.0, 0.5145, 1.0712],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(progressProvider.notifier).increment(); // Increment before navigation
                      if (role == UserRole.both) {
                        context.go('/planner-profile-setup');
                      } else {
                        context.go('/setup-complete');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class PurposeOption extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String assetPath;
  final bool isSelected;
  final VoidCallback onTap;

  const PurposeOption({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFF3F4F6),
          border: isSelected
              ? Border.all(color: const Color(0xFF3B82F6), width: 2)
              : null,
        ),
        child: Row(
          children: [
            // Icon container with white background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  assetPath,
                  width: 20,
                  height: 20,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}