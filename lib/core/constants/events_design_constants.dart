import 'package:flutter/material.dart';

// Design Constants
class EventsColors {
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF4B5563);
  static const textTertiary = Color(0xFF6B7280);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const primaryBlue500 = Color(0xFF3B82F6);
  static const warning400 = Color(0xFFFBBF24);
  static const background = Color(0xFFF9FAFB);
  static const neutralGray100 = Color(0xFFF3F4F6);
}

class EventsTextStyles {
  static const heading5 = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0,
    color: EventsColors.textPrimary,
  );

  static const heading6 = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    color: EventsColors.textPrimary,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: EventsColors.textSecondary,
  );

  static const caption = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: EventsColors.textTertiary,
  );

  static const priceText = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: EventsColors.textPrimary,
  );

  static const buttonText = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: EventsColors.textPrimary,
  );

  static const viewAllText = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: EventsColors.textPrimary,
  );
}
