import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/plan_trip_provider.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentConfirmationScreen extends ConsumerWidget {
  final String plannerName;
  final String planningFee;
  final String deductedFrom;
  final bool isSecured;
  final String plannerImage;

  const PaymentConfirmationScreen({
    Key? key,
    this.plannerName = 'Joseph Fubara',
    this.planningFee = '\$75',
    this.deductedFrom = 'Tripify Wallet',
    this.isSecured = true,
    this.plannerImage = 'assets/images/Trips/planner_avatar.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () {
            ref.read(selfPlanStepProvider.notifier).state = 3;
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment & Confirmation',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '4/4',
                style: TextStyle(
                  color: const Color(0xFF111827).withOpacity(0.5),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TripProgressBar(currentStep: 4, totalSteps: 4),
            const SizedBox(height: 24),

            // Secure Your Planning Session
            const Text(
              'Secure Your Planning Session',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.375,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Before we send your trip request to $plannerName, please confirm the planning fee',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF4B5563),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Fee Summary Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFF3F4F6),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF172554).withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fee Summary Header
                    const Text(
                      'Fee Summary',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Planning Fee Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dollar Icon
                        Image.asset(
                          'assets/images/Trips/Dollar.png',
                          width: 40,
                          height: 40,
                        ),

                        const SizedBox(width: 12),

                        // Planning Fee Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Planning Fee',
                                style: TextStyle(
                                  color: Color(0xFF111827),
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Temporarily held amount',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price
                        Text(
                          planningFee,
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Divider
                    const Divider(
                      color: Color(0xFFF3F4F6),
                      thickness: 1,
                      height: 1,
                    ),

                    const SizedBox(height: 16),

                    // Deducted From Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Deducted From:',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          deductedFrom,
                          style: const TextStyle(
                            color: Color(0xFF111827),
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDEEBFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/Trips/Shield_Check.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Secured',
                                style: TextStyle(
                                  color: Color(0xFF3B82F6),
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Info Message (Outside Card)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDD5),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Funds will only be released when you approve the trip plan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF97316),
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Arrow Down Icon
            SvgPicture.asset(
              'assets/images/Trips/Round_Arrow_Down.svg',
              width: 24,
              height: 24,
            ),

            const SizedBox(height: 16),

            // Planner Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: const Color(0xFFF3F4F6),
                ),
                child: Row(
                  children: [
                    // Planner Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        plannerImage,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Planner Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                plannerName,
                                style: const TextStyle(
                                  color: Color(0xFF111827),
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                'assets/images/Trips/Verified_Check.svg',
                                width: 16,
                                height: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Trip Planner',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontFamily: 'Instrument Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
