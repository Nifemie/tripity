import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/subscription_widgets/premium_feature_item.dart';
import '../../widgets/subscription_widgets/faq_item.dart';

class UpgradeAccountScreen extends StatelessWidget {
  const UpgradeAccountScreen({super.key});

  void _showConfirmUpgradeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const _ConfirmUpgradeModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upgrade Account',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Crown Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/more/Star.svg',
                      width: 40,
                      height: 40,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF3B82F6),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Center(
                child: const Text(
                  'Upgrade to Trip Planner',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Center(
                child: const Text(
                  'Expand your account, keep your traveler perks and unlock Trip Planner tools to earn by creating and managing trips for others.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Upgrade Button

              SizedBox(
                width: double.infinity,
                height: 56,
                child: Expanded(
                  child: Container(
                    height: 44,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-0.04, -1.0),
                        end: Alignment(1.07, 1.0),
                        colors: [
                          Color(0xFF3B82F6),
                          Color(0xFF2563EB),
                          Color(0xFF1E40AF),
                        ],
                        stops: [0.0, 0.5145, 1.0712],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9999)),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => _showConfirmUpgradeModal(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        'assets/images/more/Star.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: const Text(
                        'Upgrade to Trip Planner',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Trip Planner Features Section
              const Text(
                'TRIP PLANNER FEATURES',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              const PremiumFeatureItem(
                title: 'Planner Dashboard Access',
                description:
                    'Manage requests, trips, and earnings in one place',
              ),
              const PremiumFeatureItem(
                title: 'Accept Trip Requests',
                description:
                    'Receive and respond to traveler requests seamlessly',
              ),
              const PremiumFeatureItem(
                title: 'Itinerary Builder',
                description: 'Create and deliver personalized trip plans',
              ),
              const PremiumFeatureItem(
                title: 'Escrow-Protected Payments',
                description:
                    'Get paid securely when travelers approve your plans',
              ),
              const PremiumFeatureItem(
                title: 'Integrated Chats',
                description:
                    'Communicate with travelers, share drafts, and collaborate easily',
              ),
              const PremiumFeatureItem(
                title: 'Ongoing + Completed Trip Management',
                description: 'Track progress and deliverables for each trip',
              ),
              const PremiumFeatureItem(
                title: 'Keep Your Traveler Perks',
                description:
                    'Enjoy all Premium Traveler benefits while adding planner tools',
              ),

              const SizedBox(height: 32),

              // FAQ Section
              const Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              const FaqItem(
                question: 'Will I lose my Traveler features?',
                answer:
                    'No. Your traveler perks remain, this upgrade only adds Trip Planner tools.',
                initiallyExpanded: true,
              ),
              const FaqItem(
                question: 'Can I switch between roles?',
                answer:
                    'Yes, you can seamlessly switch between Traveler and Trip Planner modes in your account settings.',
              ),
              const FaqItem(
                question: 'Do I need a separate subscription?',
                answer:
                    'No, upgrading to Trip Planner is included with your Premium subscription at no additional cost.',
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmUpgradeModal extends StatelessWidget {
  const _ConfirmUpgradeModal();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 24),

          // Title
          const Text(
            'Confirm Upgrade to Trip Planner',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.375,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Warning Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_rounded,
              size: 48,
              color: Color(0xFFF59E0B),
            ),
          ),

          const SizedBox(height: 24),

          // Description
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This will expand your account, you\'ll keep your traveler perks and unlock Trip Planner tools, including a dedicated Planner Dashboard to manage requests, build itineraries, and earn securely.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          // Terms text
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              children: [
                TextSpan(text: 'By proceeding, you agree to our '),
                TextSpan(
                  text: 'Terms of Use',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 44,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.04, -1.0),
                      end: Alignment(1.07, 1.0),
                      colors: [
                        Color(0xFF3B82F6),
                        Color(0xFF2563EB),
                        Color(0xFF1E40AF),
                      ],
                      stops: [0.0, 0.5145, 1.0712],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.push('/upgrade-success');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    icon: null,
                    label: const Text(
                      'Confirm Upgrade',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
