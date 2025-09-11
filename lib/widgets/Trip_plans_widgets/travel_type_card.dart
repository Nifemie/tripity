import 'package:flutter/material.dart';

class TravelTypeCard extends StatelessWidget {
  const TravelTypeCard({
    Key? key,
    required this.type,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String type;
  final String subtitle;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? const Color(0xFFF0F9FF) : const Color(0xFFF3F4F6), // Changed from Colors.white to gray
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF111827),
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.33,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}