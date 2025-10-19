import 'package:flutter/material.dart';

// ==================== PRIMARY BUTTON (FILLED BLUE) ====================

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 44,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          gradient: const LinearGradient(
            begin: Alignment(-0.04, -1.0),
            end: Alignment(1.0, 1.07),
            colors: [
              Color(0xFF3B82F6), // -4.21%
              Color(0xFF2563EB), // 51.45%
              Color(0xFF1E40AF), // 107.12%
            ],
            stops: [0.0, 0.51, 1.0],
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: isLoading ? null : onPressed,
          child:
              isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
        ),
      ),
    );
  }
}

// ==================== SECONDARY BUTTON (OUTLINED) ====================

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: const Color(0xFFF3F4F6),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

// ==================== BUTTON ROW (VIEW DETAILS + BOOK NOW) ====================

class TransportButtonRow extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onBookNow;

  const TransportButtonRow({
    Key? key,
    required this.onViewDetails,
    required this.onBookNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // View Details Button (Secondary)
        Expanded(
          child: SecondaryButton(
            text: 'View Details',
            onPressed: onViewDetails,
            isFullWidth: true,
          ),
        ),
        const SizedBox(width: 12),
        // Book Now Button (Primary)
        Expanded(
          child: PrimaryButton(
            text: 'Book Now',
            onPressed: onBookNow,
            isFullWidth: true,
          ),
        ),
      ],
    );
  }
}
