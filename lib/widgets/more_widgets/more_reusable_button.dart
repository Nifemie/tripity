import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



/// A full-width primary bar button styled for the "more" screens.
class MoreFullWidthBarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final Widget? icon;

  const MoreFullWidthBarButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: enabled
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
          color: enabled ? null : const Color(0xFFE5E7EB),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: enabled ? Colors.white : const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// A reusable row of two buttons: secondary (gray) and primary (blue gradient),
/// styled for the "more" screens. Now a ConsumerWidget for Riverpod.
class MoreButtonRow extends ConsumerWidget {
  final String secondaryText;
  final VoidCallback onSecondary;
  final String primaryText;
  final VoidCallback onPrimary;
  final bool isPrimaryEnabled;
  final bool isSecondaryEnabled;

  const MoreButtonRow({
    Key? key,
    required this.secondaryText,
    required this.onSecondary,
    required this.primaryText,
    required this.onPrimary,
    this.isPrimaryEnabled = true,
    this.isSecondaryEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 430,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: Row(
        children: [
          // Secondary Button
          Expanded(
            child: GestureDetector(
              onTap: isSecondaryEnabled ? onSecondary : null,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                alignment: Alignment.center,
                child: Text(
                  secondaryText,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Primary Button
          Expanded(
            child: GestureDetector(
              onTap: isPrimaryEnabled ? onPrimary : null,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient:
                      isPrimaryEnabled
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
                  color: isPrimaryEnabled ? null : const Color(0xFFE5E7EB),
                ),
                alignment: Alignment.center,
                child: Text(
                  primaryText,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color:
                        isPrimaryEnabled
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
