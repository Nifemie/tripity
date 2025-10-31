import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/more_widgets/more_reusable_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdatePasswordDownsheetModal extends ConsumerWidget {
  final VoidCallback onDone;
  final VoidCallback? onClose;

  const UpdatePasswordDownsheetModal({
    Key? key,
    required this.onDone,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 430,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A111827),
            blurRadius: 24,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              // Success Icon
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Trips/success_icon.svg',
                    width: 36,
                    height: 36,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Password updated!',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your password has been updated successfully. You can now sign in with your new password.',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              MoreFullWidthBarButton(text: 'Done', onPressed: onDone),
            ],
          ),
          // Close button (top right)
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF6B7280), size: 22),
              onPressed: onClose ?? () => Navigator.of(context).pop(),
              splashRadius: 20,
              tooltip: 'Close',
            ),
          ),
        ],
      ),
    );
  }
}
