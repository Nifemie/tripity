import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../screens/role_selection_screen.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';

// State providers for travel preferences
final selectedInterestsProvider = StateProvider<Set<String>>((ref) => {});
final travelFrequencyProvider = StateProvider<String?>((ref) => null);
final budgetRangeProvider = StateProvider<String?>((ref) => null);


// Form validation provider
final isPreferencesValidProvider = Provider<bool>((ref) {
  final selectedInterests = ref.watch(selectedInterestsProvider);
  final travelFrequency = ref.watch(travelFrequencyProvider);
  final budgetRange = ref.watch(budgetRangeProvider);

  return selectedInterests.isNotEmpty &&
      travelFrequency != null &&
      budgetRange != null;
});

class TravelPreferencesScreen extends ConsumerWidget {
  const TravelPreferencesScreen({super.key});

  void _handleContinue(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.read(selectedInterestsProvider);
    final travelFrequency = ref.read(travelFrequencyProvider);
    final budgetRange = ref.read(budgetRangeProvider);

    final role = ModalRoute.of(context)!.settings.arguments as UserRole?;

    print('Travel Preferences:');
    print('Interests: $selectedInterests');
    print('Travel Frequency: $travelFrequency');
    print('Budget Range: $budgetRange');

    // Navigate to next screen
    ref.read(progressProvider.notifier).increment();
    Navigator.pushNamed(context, '/purpose', arguments: role);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterests = ref.watch(selectedInterestsProvider);
    final travelFrequency = ref.watch(travelFrequencyProvider);
    final budgetRange = ref.watch(budgetRangeProvider);
    final isFormValid = ref.watch(isPreferencesValidProvider);

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
                      onTap: () => Navigator.pop(context),
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
                const ProgressBar(),

                const SizedBox(height: 32),

                // What interests you title
                const Text(
                  'What interests you?',
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
                  'Select your travel preferences to get personalised recommendations',
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

                const SizedBox(height: 32),

                // Travel frequency section
                const Text(
                  'How often do you travel?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    height: 21 / 14, // 150%
                  ),
                ),

                const SizedBox(height: 16),

                // Travel frequency options
                _buildFrequencyOptions(travelFrequency, ref),

                const SizedBox(height: 32),

                // Budget range section
                const Text(
                  'What\'s your typical budget range per trip?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    height: 21 / 14, // 150%
                  ),
                ),

                const SizedBox(height: 16),

                // Budget range options
                _buildBudgetOptions(budgetRange, ref),

                const SizedBox(height: 32),

                // Continue Button
                Container(
                  width: double.infinity,
                  height: 52,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: isFormValid
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
                    onPressed: isFormValid ? () => _handleContinue(context, ref) : null,
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
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    child: const Text(
                      'Continue',
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
      {'title': 'Adventure & Outdoor', 'svgPath': 'assets/images/account_setup/Bonfire.svg'},
      {'title': 'Culture & History', 'svgPath': 'assets/images/account_setup/Globus.svg'},
      {'title': 'Food & Dining', 'svgPath': 'assets/images/account_setup/Chef Hat.svg'},
      {'title': 'Nightlife & Entertainment', 'svgPath': 'assets/images/account_setup/Music Notes.svg'},
      {'title': 'Photography', 'svgPath': 'assets/images/account_setup/Camera.svg'},
      {'title': 'Wellness & Relaxation', 'svgPath': 'assets/images/account_setup/Meditation.svg'},
      {'title': 'Business Travel', 'svgPath': 'assets/images/account_setup/Case.svg'},
      {'title': 'Family Friendly', 'svgPath': 'assets/images/account_setup/Users.svg'},
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
              ref.read(selectedInterestsProvider.notifier).state =
                  currentSelection.difference({title});
            } else {
              ref.read(selectedInterestsProvider.notifier).state =
                  currentSelection.union({title});
            }
          },
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), // Optimized padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: isSelected
                  ? const Color(0xFFEBF4FF)
                  : const Color(0xFFF3F4F6),
              border: isSelected
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
                Expanded( // Use Expanded to fill remaining space
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12, // Smaller font
                        fontWeight: FontWeight.w600,
                        color: isSelected
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
  Widget _buildSvgIcon({required String assetName}) {
    return SvgPicture.asset(
      assetName,
      width: 24,
      height: 24,
      color: const Color(0xFF3B82F6),
    );
  }

  Widget _buildFrequencyOptions(String? selectedFrequency, WidgetRef ref) {
    final frequencies = [
      'Once a year',
      '2 - 3 times per year',
      'Weekly',
      'Monthly',
    ];

    return Column(
      children: frequencies.map((frequency) {
        final isSelected = selectedFrequency == frequency;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () {
              ref.read(travelFrequencyProvider.notifier).state = frequency;
            },
            child: Container(
              width: double.infinity,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSelected
                    ? const Color(0xFFEBF4FF) // Light blue when selected
                    : const Color(0xFFF3F4F6), // Gray when not selected
                border: isSelected
                    ? Border.all(color: const Color(0xFF3B82F6), width: 2)
                    : null,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    height: 17.5 / 14, // 125%
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBudgetOptions(String? selectedBudget, WidgetRef ref) {
    final budgets = [
      ['Under \$500', '\$500 - \$1500'],
      ['\$1500 - \$3000', 'Above \$3000'],
    ];

    return Column(
      children: budgets.map((budgetRow) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: budgetRow.map((budget) {
              final isSelected = selectedBudget == budget;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: budget == budgetRow.first ? 8 : 0,
                    left: budget == budgetRow.last ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(budgetRangeProvider.notifier).state = budget;
                    },
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected
                            ? const Color(0xFFEBF4FF) // Light blue when selected
                            : const Color(0xFFF3F4F6), // Gray when not selected
                        border: isSelected
                            ? Border.all(color: const Color(0xFF3B82F6), width: 2)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          budget,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFF111827),
                            fontFamily: 'Instrument Sans',
                            height: 17.5 / 14, // 125%
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  
}