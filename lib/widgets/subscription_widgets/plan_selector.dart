import 'package:flutter/material.dart';

enum PlanType { monthly, yearly }

class PlanSelector extends StatelessWidget {
  final PlanType selectedPlan;
  final Function(PlanType) onPlanChanged;
  final String monthlyPrice;
  final String yearlyPrice;
  final String? savingsText;

  const PlanSelector({
    super.key,
    required this.selectedPlan,
    required this.onPlanChanged,
    required this.monthlyPrice,
    required this.yearlyPrice,
    this.savingsText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _PlanOption(
            title: 'Monthly',
            price: monthlyPrice,
            subtitle: 'Cancel anytime',
            isSelected: selectedPlan == PlanType.monthly,
            onTap: () => onPlanChanged(PlanType.monthly),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _PlanOption(
                title: 'Yearly',
                price: yearlyPrice,
                subtitle: 'Cancel anytime',
                isSelected: selectedPlan == PlanType.yearly,
                onTap: () => onPlanChanged(PlanType.yearly),
              ),
              if (savingsText != null)
                Positioned(
                  top: -8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      savingsText!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanOption extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanOption({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
            width: isSelected ? 2 : 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF111827)
                    : const Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF111827),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
