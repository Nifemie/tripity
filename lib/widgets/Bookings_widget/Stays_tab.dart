import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== PROVIDERS ====================

// Provider to track the selected tab
final selectedStaysTabProvider = StateProvider<String>((ref) => 'All');

// ==================== STAYS TAB MODEL ====================

class StaysTab {
  final String id;
  final String label;

  const StaysTab({required this.id, required this.label});
}

// Available stays tabs
const List<StaysTab> staysTabs = [
  StaysTab(id: 'All', label: 'All'),
  StaysTab(id: 'Hotels', label: 'Hotels'),
  StaysTab(id: 'Apartments', label: 'Apartments'),
  StaysTab(id: 'Hostel', label: 'Hostel'),
  StaysTab(id: 'Resort', label: 'Resort'),
];

// ==================== STAYS TAB BAR ====================

class StaysTabBar extends ConsumerWidget {
  const StaysTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedStaysTabProvider);

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: staysTabs.length,
        itemBuilder: (context, index) {
          final tab = staysTabs[index];
          final isSelected = selectedTab == tab.id;

          return GestureDetector(
            onTap: () {
              ref.read(selectedStaysTabProvider.notifier).state = tab.id;
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index < staysTabs.length - 1 ? 12 : 0,
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
