import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationComponent extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationComponent({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavigationComponent> createState() => _BottomNavigationComponentState();
}

class _BottomNavigationComponentState extends State<BottomNavigationComponent> {
  final List<NavigationItem> navigationItems = [
    NavigationItem(
      svgPath: 'assets/images/Home/Home_icon.svg', // Replace with your actual path
      label: 'Home',
    ),
    NavigationItem(
      svgPath: 'assets/images/Home/Compass_icon.svg', // Replace with your actual path
      label: 'Explore',
    ),
    NavigationItem(
      svgPath: 'assets/images/Home/Suitcase_icon.svg', // Replace with your actual path
      label: 'Trips',
    ),
    NavigationItem(
      svgPath: 'assets/images/Home/Bookings.svg', // Replace with your actual path
      label: 'Booking',
    ),
    NavigationItem(
      svgPath: 'assets/images/Home/menu_icon.svg', // Replace with your actual path
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(
            color: Color(0xFFE5E7EB), // --Neutral-Gray-200
            width: 1,
          ),
        ),
        color: Color(0xFFFFFFFF), // --Background-Primary
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: navigationItems.asMap().entries.map((entry) {
          int index = entry.key;
          NavigationItem item = entry.value;
          bool isSelected = index == widget.currentIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => widget.onTap(index),
              child: Container(
                height: 64,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? const Color(0xFFEFF6FF) // --Primary-Blue-50
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset(
                        item.svgPath,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? const Color(0xFF3B82F6) // --Primary-Blue-500
                              : const Color(0xFF6B7280), // --Text-Tertiary
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? const Color(0xFF3B82F6) // --Primary-Blue-500
                            : const Color(0xFF6B7280), // --Text-Tertiary
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w600 // --Font-Weight-semibold
                            : FontWeight.w400, // --Font-Weight-normal
                        height: 1.5, // 150% line height (21px / 14px = 1.5)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final String svgPath;
  final String label;

  NavigationItem({
    required this.svgPath,
    required this.label,
  });
}

