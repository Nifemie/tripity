import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: List.generate(totalSteps, (index) {
          return Expanded(
            child: Container(
              height: 8,
              margin: EdgeInsets.only(right: index < totalSteps - 1 ? 4 : 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: index < currentStep
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFE5E7EB),
              ),
            ),
          );
        }),
      ),
    );
  }
}
