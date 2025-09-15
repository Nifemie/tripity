import 'package:flutter/material.dart';

class ExploreHeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onViewAllTap;

  const ExploreHeaderSection({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onViewAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            if (onViewAllTap != null)
              GestureDetector(
                onTap: onViewAllTap,
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2563EB),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFF3B82F6),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 20), // Keep the spacing after the header
      ],
    );
  }
}
