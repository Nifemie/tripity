import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== PROVIDERS ====================

// Provider to track the selected tab
final selectedExperiencesTabProvider = StateProvider<String>((ref) => 'All');

// ==================== EXPERIENCES TAB MODEL ====================

class ExperiencesTab {
  final String id;
  final String label;

  const ExperiencesTab({required this.id, required this.label});
}

// Available experiences tabs
const List<ExperiencesTab> experiencesTabs = [
  ExperiencesTab(id: 'All', label: 'All'),
  ExperiencesTab(id: 'Guided Tour', label: 'Guided Tour'),
  ExperiencesTab(id: 'Adventure', label: 'Adventure'),
  ExperiencesTab(id: 'Cultural Experience', label: 'Cultural Experience'),
];

// ==================== EXPERIENCES TAB BAR ====================

class ExperiencesTabBar extends ConsumerWidget {
  const ExperiencesTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedExperiencesTabProvider);

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: experiencesTabs.length,
        itemBuilder: (context, index) {
          final tab = experiencesTabs[index];
          final isSelected = selectedTab == tab.id;

          return GestureDetector(
            onTap: () {
              ref.read(selectedExperiencesTabProvider.notifier).state = tab.id;
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index < experiencesTabs.length - 1 ? 12 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border:
                    isSelected
                        ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFF3B82F6),
                            width: 2.5,
                          ),
                        )
                        : null,
              ),
              child: Center(
                child: Text(
                  tab.label,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color:
                        isSelected
                            ? const Color(0xFF111827)
                            : const Color(0xFF6B7280),
                    height: 1.25,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
