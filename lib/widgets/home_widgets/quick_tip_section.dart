import 'package:flutter/material.dart';

class QuickTipSection extends StatelessWidget {
  const QuickTipSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFEFF6FF), // Primary Blue 50
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Tip Header
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  size: 12,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Quick Tip",
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tip Content
          const Text(
            "Book flights on Tuesday afternoons for the best deals. Airlines often release discounts on Monday evenings, and competitors match prices by Tuesday.",
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
              // Text Secondary
              height: 1.5, // 150% line height
            ),
          ),

          const SizedBox(height: 16),

          // View More Button
          Container(
            width: double.infinity,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                "View More",
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2563EB),
                  // Text Link
                  height: 1.25, // 125% line height
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
