import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable Custom Button Widget
class ProfileCustomButton extends StatelessWidget {
  final String text;
  final String? iconPath; // Path to SVG icon
  final bool isEnabled;
  final bool isPrimary; // true for gradient button, false for gray button
  final VoidCallback? onPressed;
  final Widget? icon; // Alternative to iconPath for direct icon widget

  const ProfileCustomButton({
    Key? key,
    required this.text,
    this.iconPath,
    this.isEnabled = true,
    this.isPrimary = false,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            gradient: isPrimary && isEnabled
                ? const LinearGradient(
              begin: Alignment(-0.04, -1.0),
              end: Alignment(1.07, 1.0),
              colors: [
                Color(0xFF3B82F6), // -4.21%
                Color(0xFF2563EB), // 51.45%
                Color(0xFF1E40AF), // 107.12%
              ],
              stops: [0.0, 0.51, 1.0],
            )
                : null,
            color: !isPrimary ? const Color(0xFFF3F4F6) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              if (iconPath != null)
                SvgPicture.asset(
                  iconPath!,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    isPrimary
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
                    BlendMode.srcIn,
                  ),
                )
              else if (icon != null)
                icon!,

              if (iconPath != null || icon != null) const SizedBox(width: 8),

              // Text
              Text(
                text,
                style: TextStyle(
                  color: isPrimary
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Action Buttons Section with Chat and Request Trip buttons
class ActionButtonsSection extends StatelessWidget {
  final VoidCallback? onChatPressed;
  final VoidCallback? onRequestTripPressed;
  final bool isChatEnabled;

  const ActionButtonsSection({
    Key? key,
    this.onChatPressed,
    this.onRequestTripPressed,
    this.isChatEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buttons Row
        Row(
          children: [
            // Chat Button
            ProfileCustomButton(
              text: 'Chat',
              icon: Icon(
                Icons.lock_outline,
                size: 20,
                color: isChatEnabled
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF9CA3AF),
              ),
              // iconPath: 'assets/icons/lock.svg', // Use this if you have SVG
              isEnabled: isChatEnabled,
              isPrimary: false,
              onPressed: onChatPressed,
            ),

            const SizedBox(width: 12),

            // Request a Trip Plan Button
            ProfileCustomButton(
              text: 'Request a Trip Plan',
              icon: const Icon(
                Icons.assignment_outlined,
                size: 20,
                color: Colors.white,
              ),
              // iconPath: 'assets/icons/clipboard.svg', // Use this if you have SVG
              isEnabled: true,
              isPrimary: true,
              onPressed: onRequestTripPressed,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Helper Text
        const Text(
          'Chat will be unlocked after trip request approval',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

