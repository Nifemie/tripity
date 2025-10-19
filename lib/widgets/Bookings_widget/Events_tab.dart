import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== EVENTS TAB PROVIDER ====================

final selectedEventsTabProvider = StateProvider<String>((ref) => 'All');

// ==================== EVENTS TAB BAR ====================

class EventsTabBar extends ConsumerWidget {
  const EventsTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedEventsTabProvider);

    final tabs = ['All', 'Music', 'Sports', 'Festivals', 'Theatre'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab;

          return GestureDetector(
            onTap: () {
              ref.read(selectedEventsTabProvider.notifier).state = tab;
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isSelected
                            ? const Color(0xFF3B82F6)
                            : Colors.transparent,
                    width: 2.5,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        isSelected
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF6B7280),
                    height: 1.5,
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
