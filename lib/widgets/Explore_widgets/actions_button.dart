import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback? onPlanTripPressed;
  final VoidCallback? onBrowseOptionsPressed;

  const ActionButtonsWidget({
    Key? key,
    this.onPlanTripPressed,
    this.onBrowseOptionsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFF3F4F6),
            width: 1,
          ),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Plan a Trip Here Button (Fixed Size)
          _buildPlanTripButton(),
          const SizedBox(width: 12),
          // Browse Travel Options Button (Takes remaining space)
          Expanded(child: _buildBrowseOptionsButton()),
        ],
      ),
    );
  }

  Widget _buildPlanTripButton() {
    return GestureDetector(
      onTap: onPlanTripPressed,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          color: const Color(0xFFF3F4F6),
        ),
        child: const Center(
          child: Text(
            'Plan a Trip Here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseOptionsButton() {
    return GestureDetector(
      onTap: onBrowseOptionsPressed,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: const LinearGradient(
            begin: Alignment(-0.04, -1.0),
            end: Alignment(1.07, 1.0),
            colors: [
              Color(0xFF3B82F6), // Primary Blue 500 at -4.21%
              Color(0xFF2563EB), // Primary Blue 600 at 51.45%
              Color(0xFF1E40AF), // Primary Blue 800 at 107.12%
            ],
            stops: [0.0, 0.5145, 1.0712],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Calendar SVG Icon
            SvgPicture.asset(
              'assets/images/Home/Calendar_icon.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            const Flexible(
              child: Text(
                'Browse Travel Options',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}