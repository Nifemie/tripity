import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final VoidCallback onSaveForLater;
  final VoidCallback onContinue;
  final String saveText;
  final String continueText;

  const BottomButtons({
    Key? key,
    required this.onSaveForLater,
    required this.onContinue,
    this.saveText = 'Save for Later',
    this.continueText = 'Continue',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              child: ElevatedButton(
                onPressed: onSaveForLater,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6), // Gray background
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999), // Full border radius
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: Text(
                  saveText,
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8), // 8px gap
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                gradient: const LinearGradient(
                  begin: Alignment(-0.04, -1.0),
                  end: Alignment(1.0, 1.0),
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF2563EB),
                    Color(0xFF1E40AF),
                  ],
                  stops: [0.0, 0.51, 1.0],
                ),
              ),
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: Text(
                  continueText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
