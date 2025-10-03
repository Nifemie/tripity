import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Reusable Custom Button Widget
class ProfileCustomButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final bool isPrimary; // true for blue button, false for gray button
  final VoidCallback? onPressed;
  final Widget? icon;

  const ProfileCustomButton({
    Key? key,
    required this.text,
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
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isPrimary
                ? const Color(0xFF3B82F6) // Blue color
                : const Color(0xFFF3F4F6), // Light gray
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: isPrimary
                        ? Colors.white
                        : const Color(0xFF374151),
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Action Buttons Section with Terms and Buttons
class ActionButtonsSection extends StatelessWidget {
  final VoidCallback? onCancelPressed;
  final VoidCallback? onSendRequestPressed;
  final VoidCallback? onTermsPressed;
  final VoidCallback? onPrivacyPressed;

  const ActionButtonsSection({
    Key? key,
    this.onCancelPressed,
    this.onSendRequestPressed,
    this.onTermsPressed,
    this.onPrivacyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Terms Text with Links
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: 'By proceeding, you agree to our '),
              TextSpan(
                text: 'Terms of Use',
                style: const TextStyle(
                  color: Color(0xFF3B82F6),
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = onTermsPressed,
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: const TextStyle(
                  color: Color(0xFF3B82F6),
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = onPrivacyPressed,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Buttons Row
        Row(
          children: [
            // Cancel Button
            ProfileCustomButton(
              text: 'Cancel',
              isEnabled: true,
              isPrimary: false,
              onPressed: onCancelPressed,
            ),

            const SizedBox(width: 12),

            // Send Request Button
            ProfileCustomButton(
              text: 'Send Request',
              isEnabled: true,
              isPrimary: true,
              onPressed: onSendRequestPressed,
            ),
          ],
        ),
      ],
    );
  }
}

