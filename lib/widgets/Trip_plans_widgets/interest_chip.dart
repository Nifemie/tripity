import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({
    Key? key,
    required this.interest,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String interest;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999), // Full border radius
          color: const Color(0xFFF3F4F6), // Neutral gray background
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected) ...[
              SvgPicture.asset(
                'assets/images/Trips/Close_Circle.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              interest,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
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