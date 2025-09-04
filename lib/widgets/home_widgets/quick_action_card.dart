import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickActionCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTap;

  const QuickActionCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFF3F4F6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/Home/ArrowRightUp.svg',
                  // Replace with your arrow SVG path
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    Colors.grey[400]!,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
