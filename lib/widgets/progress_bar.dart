import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/progress_provider.dart';

class ProgressBar extends ConsumerWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);

    return Container(
      height: 8,
      child: Row(
        children: List.generate(progress.totalSteps, (index) {
          final isActive = index < progress.currentStep;
          final isFirst = index == 0;
          final isLast = index == progress.totalSteps - 1;

          return Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: isFirst ? const Radius.circular(100) : Radius.zero,
                  bottomLeft: isFirst ? const Radius.circular(100) : Radius.zero,
                  topRight: isLast ? const Radius.circular(100) : Radius.zero,
                  bottomRight: isLast ? const Radius.circular(100) : Radius.zero,
                ),
                color: isActive
                    ? const Color(0xFF3B82F6) // Primary Blue 500 for completed/active steps
                    : const Color(0xFFE5E7EB), // Gray for inactive steps
              ),
            ),
          );
        }),
      ),
    );
  }
}
