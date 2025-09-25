import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'destinationDetails_screen.dart';
import '../../../../widgets/Explore_widgets/actions_button.dart';// Import the action buttons widget

// Data models
class InfoCardData {
  final String iconPath;
  final String title;
  final String subtitle;
  final String description;

  InfoCardData({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

class TagData {
  final String text;

  TagData({required this.text});
}

class RequirementData {
  final String label;
  final String value;

  RequirementData({
    required this.label,
    required this.value,
  });
}

// Providers
final infoCardsProvider = Provider<List<InfoCardData>>((ref) {
  return [
    InfoCardData(
      iconPath: 'assets/images/Home/Calendar_icon.svg', // You'll need to add your SVG assets
      title: 'Best Time to Visit',
      subtitle: 'May - October',
      description: 'Warm weather, less rain',
    ),
    InfoCardData(
      iconPath: 'assets/images/explore/Dollar.svg',
      title: 'Average Daily Cost',
      subtitle: '\$80 - 150',
      description: 'Mid-range budget',
    ),
    InfoCardData(
      iconPath: 'assets/images/Home/user.svg',
      title: 'Ideal For',
      subtitle: 'Couples, Photography',
      description: 'Romantic atmosphere',
    ),
    InfoCardData(
      iconPath: 'assets/images/explore/car.svg',
      title: 'Getting Around',
      subtitle: 'Walking, ATV',
      description: 'Compact island',
    ),
    InfoCardData(
      iconPath: 'assets/images/explore/car.svg',
      title: 'Travel Time',
      subtitle: '8-10 hours from Milan',
      description: 'Comfortable flight',
    ),
  ];
});

final tagsProvider = Provider<List<TagData>>((ref) {
  return [
    TagData(text: 'Culture'),
    TagData(text: 'Romantic Getaway'),
    TagData(text: 'Fashion'),
    TagData(text: 'Food & Cuisine'),
  ];
});

final travelRequirementsProvider = Provider<List<RequirementData>>((ref) {
  return [
    RequirementData(label: 'Visa Required:', value: 'No (EU citizens)'),
    RequirementData(label: 'Passport:', value: 'Required'),
    RequirementData(label: 'Currency:', value: 'Euro (€)'),
    RequirementData(label: 'Language:', value: 'French, English'),
  ];
});

final emergencyContactsProvider = Provider<List<RequirementData>>((ref) {
  return [
    RequirementData(label: 'Emergency:', value: '112'),
    RequirementData(label: 'Tourist Police:', value: '+30 22860 22649'),
    RequirementData(label: 'Currency:', value: 'Euro (€)'),
    RequirementData(label: 'Language:', value: 'French, English'),
  ];
});

// Main Widget
class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoCards = ref.watch(infoCardsProvider);
    final tags = ref.watch(tagsProvider);
    final travelRequirements = ref.watch(travelRequirementsProvider);
    final emergencyContacts = ref.watch(emergencyContactsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Info Cards Grid
            _buildInfoCardsGrid(infoCards),
            const SizedBox(height: 24),
            // Perfect For Section
            _buildPerfectForSection(tags),
            const SizedBox(height: 24),
            // Travel Requirements Section
            _buildRequirementsSection('Travel Requirements', travelRequirements),
            const SizedBox(height: 16),
            // Emergency Contacts Section
            _buildRequirementsSection('Emergency Contacts', emergencyContacts),
            const SizedBox(height: 20), // Extra padding at bottom
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCardsGrid(List<InfoCardData> cards) {
    return Column(
      children: [
        // First row - 2 cards
        Row(
          children: [
            Expanded(child: _buildInfoCard(cards[0])),
            const SizedBox(width: 16),
            Expanded(child: _buildInfoCard(cards[1])),
          ],
        ),
        const SizedBox(height: 16),
        // Second row - 2 cards
        Row(
          children: [
            Expanded(child: _buildInfoCard(cards[2])),
            const SizedBox(width: 16),
            Expanded(child: _buildInfoCard(cards[3])),
          ],
        ),
        const SizedBox(height: 16),
        // Third row - 1 card (centered)
        Row(
          children: [
            Expanded(child: _buildInfoCard(cards[4])),
            const Expanded(child: SizedBox()), // Empty space to center
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(InfoCardData data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SVG Icon
          SvgPicture.asset(
            data.iconPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Color(0xFF6B7280),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            data.title,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontFamily: 'Instrument Sans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle
          Text(
            data.subtitle,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            data.description,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontFamily: 'Instrument Sans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerfectForSection(List<TagData> tags) {
    return Container(
      width: 390,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Perfect For',
            style: TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) => _buildTag(tag.text)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        color: const Color(0xFFF3F4F6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF6B7280),
          fontFamily: 'Instrument Sans',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildRequirementsSection(String title, List<RequirementData> requirements) {
    return Container(
      width: 390,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Requirements List
          ...requirements.map((requirement) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label (Left)
                Text(
                  requirement.label,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                // Value (Right)
                Flexible(
                  child: Text(
                    requirement.value,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}

// App entry point