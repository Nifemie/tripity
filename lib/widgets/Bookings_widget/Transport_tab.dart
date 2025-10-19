import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== PROVIDERS ====================

// Provider to track the selected tab
final selectedTransportTabProvider = StateProvider<String>((ref) => 'All');

// ==================== TRANSPORT TAB MODEL ====================

class TransportTab {
  final String id;
  final String label;

  const TransportTab({required this.id, required this.label});
}

// Available transport tabs
const List<TransportTab> transportTabs = [
  TransportTab(id: 'All', label: 'All'),
  TransportTab(id: 'Flights', label: 'Flights'),
  TransportTab(id: 'Car', label: 'Car'),
  TransportTab(id: 'Bus', label: 'Bus'),
  TransportTab(id: 'Train', label: 'Train'),
];

// ==================== TRANSPORT TAB BAR ====================

class TransportTabBar extends ConsumerWidget {
  const TransportTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTransportTabProvider);

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: transportTabs.length,
        itemBuilder: (context, index) {
          final tab = transportTabs[index];
          final isSelected = selectedTab == tab.id;

          return GestureDetector(
            onTap: () {
              ref.read(selectedTransportTabProvider.notifier).state = tab.id;
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index < transportTabs.length - 1 ? 12 : 0,
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
