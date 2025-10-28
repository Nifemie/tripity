import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ==================== QUANTITY PROVIDER ====================

final bookingQuantityProvider = StateProvider<int>((ref) => 1);

// ==================== BOOKING FOOTER WIDGET ====================

class BookingFooter extends ConsumerWidget {
  final double pricePerPerson;
  final String priceLabel; // e.g., "person", "ticket", "night"
  final VoidCallback onBookNow;

  const BookingFooter({
    Key? key,
    required this.pricePerPerson,
    required this.priceLabel,
    required this.onBookNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 1, 20, 24),
          child: Row(
            children: [
              // Price Section
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$${pricePerPerson.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                              height: 1.4,
                            ),
                          ),
                          TextSpan(
                            text: '/$priceLabel',
                            style: const TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Plus Button (Single)
              GestureDetector(
                onTap: () {
                  // Navigate to Add to Trip page
                  context.push('/add-to-trip');
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFFF3F4F6),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Book Now Button
              Expanded(
                child: GestureDetector(
                  onTap: onBookNow,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      gradient: const LinearGradient(
                        begin: Alignment(-0.0421, -1.0),
                        end: Alignment(1.0, 1.0712),
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF2563EB),
                          Color(0xFF1E40AF),
                        ],
                        stops: [0.0, 0.5145, 1.0],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
