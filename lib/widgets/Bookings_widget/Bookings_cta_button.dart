import 'package:flutter/material.dart';

// ==================== CTA BUTTON WIDGET ====================
// Reusable button component used throughout booking flow
// Supports primary (gradient blue) and secondary (white with border) variants

class CtaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isEnabled;
  final Color? customBackgroundColor;
  final Color? customBorderColor;
  final Color? customTextColor; // New parameter

  const CtaButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isEnabled = true,
    this.customBackgroundColor,
    this.customBorderColor,
    this.customTextColor, // New parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient:
              isPrimary && isEnabled
                  ? const LinearGradient(
                    begin: Alignment(-0.0421, -1.0),
                    end: Alignment(1.0712, 1.0),
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF2563EB),
                      Color(0xFF1E40AF),
                    ],
                    stops: [0.0, 0.5145, 1.0],
                  )
                  : null,
          color: customBackgroundColor ??
              (isPrimary
                  ? (isEnabled ? null : const Color(0xFFE5E7EB))
                  : Colors.white),
          border: customBorderColor != null
              ? Border.all(color: customBorderColor!, width: 1)
              : (!isPrimary
                  ? Border.all(color: const Color(0xFF3B82F6), width: 1)
                  : null),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: customTextColor ??
                  (isPrimary
                      ? Colors.white
                      : (isEnabled
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF))),
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
