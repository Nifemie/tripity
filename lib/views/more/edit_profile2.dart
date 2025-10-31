import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/more_widgets/more_reusable_button.dart';

// Riverpod provider for selected interests (local to this screen)
final selectedInterestsProvider = StateProvider<Set<String>>((ref) => {});

class EditProfileStep2Page extends ConsumerWidget {
  const EditProfileStep2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.watch(selectedInterestsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '2/2',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const TripProgressBar(currentStep: 2, totalSteps: 2),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Your Traveler Interests',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select the types of trips you love planning to help us connect you with travelers seeking your expertise.',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Interest Grid (reused logic)
                  _buildInterestGrid(selectedInterests, ref),
                  const SizedBox(height: 20),

                  // Add Custom Interest Dashed Box
                  Container(
                    width: 390,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD1D5DB),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      // Dashed border effect (Flutter doesn't support true dashed natively)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Color(0xFF3B82F6)),
                        const SizedBox(width: 8),
                        Text(
                          'Add Custom Interest',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Bottom Buttons
          MoreButtonRow(
            secondaryText: 'Back',
            onSecondary: () => context.pop(),
            primaryText: 'Save Changes',
            onPrimary: () {
              // Save logic here
            },
          ),
        ],
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
        childAspectRatio: 187 / 100,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                // You can use SvgPicture.asset(svgPath) if flutter_svg is imported
                Icon(
                  Icons.image,
                  size: 24,
                  color: isSelected ? Color(0xFF3B82F6) : Color(0xFF6B7280),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Color(0xFF3B82F6) : Color(0xFF111827),
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
