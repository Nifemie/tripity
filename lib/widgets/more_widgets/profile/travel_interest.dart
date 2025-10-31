import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Travel Interest Model
class TravelInterest {
  final String label;
  final bool isSelected;

  const TravelInterest({
    required this.label,
    this.isSelected = false,
  });

  TravelInterest copyWith({String? label, bool? isSelected}) {
    return TravelInterest(
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

// Travel Interests Provider
final travelInterestsProvider = StateNotifierProvider<TravelInterestsNotifier, List<TravelInterest>>((ref) {
  return TravelInterestsNotifier();
});

class TravelInterestsNotifier extends StateNotifier<List<TravelInterest>> {
  TravelInterestsNotifier()
      : super([
    const TravelInterest(label: 'Adventure'),
    const TravelInterest(label: 'Food & Dining'),
    const TravelInterest(label: 'Nature'),
    const TravelInterest(label: 'Photography'),
    const TravelInterest(label: 'Culture'),
    const TravelInterest(label: 'Beach'),
    const TravelInterest(label: 'Shopping'),
    const TravelInterest(label: 'Nightlife'),
  ]);

  void toggleInterest(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(isSelected: !state[i].isSelected)
        else
          state[i],
    ];
  }
}

// Travel Interests Widget
class TravelInterestsWidget extends ConsumerWidget {
  const TravelInterestsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interests = ref.watch(travelInterestsProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14172554),
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          const Text(
            'Travel Interests',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Interest Pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interests.asMap().entries.map((entry) {
              final index = entry.key;
              final interest = entry.value;
              return _InterestPill(
                label: interest.label,
                isSelected: interest.isSelected,
                onTap: () => ref.read(travelInterestsProvider.notifier).toggleInterest(index),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Interest Pill
class _InterestPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _InterestPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// Example Usage
class TravelInterestsExample extends ConsumerWidget {
  const TravelInterestsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Travel Interests'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TravelInterestsWidget(),
            const SizedBox(height: 16),
            // Display selected interests
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Interests:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, ref, child) {
                      final interests = ref.watch(travelInterestsProvider);
                      final selected = interests
                          .where((i) => i.isSelected)
                          .map((i) => i.label)
                          .toList();

                      return Text(
                        selected.isEmpty ? 'None selected' : selected.join(', '),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      );
                    },
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