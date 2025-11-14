import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/subscription_widgets/subscription_header_card.dart';
import '../../widgets/subscription_widgets/current_plan_card.dart';
import '../../widgets/subscription_widgets/plan_selector.dart';
import '../../widgets/subscription_widgets/premium_feature_item.dart';
import '../../widgets/subscription_widgets/faq_item.dart';

// Selected plan provider
final selectedPlanProvider = StateProvider<PlanType>((ref) => PlanType.yearly);

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(selectedPlanProvider);

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
          'Subscription',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              context.push('/upgrade-account');
            },
            child: const Text(
              'Upgrade Account',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              const SubscriptionHeaderCard(
                iconPath: 'assets/images/more/Box.svg',
                title: 'Elevate Your Tripitify Experience',
                subtitle:
                    'Choose the plan that fits your journey. Enjoy Premium features, become a Trip Planner, or both.',
              ),

              const SizedBox(height: 32),

              // Current Plan Section
              const _SectionLabel(label: 'CURRENT PLAN'),
              const SizedBox(height: 12),
              CurrentPlanCard(
                iconPath: 'assets/images/more/Box.svg',
                planName: 'Free Plan',
                planDescription: 'Basic travel planning features',
                isActive: true,
                features: const [
                  PlanFeature(title: 'Basic trip planning access'),
                  PlanFeature(
                      title: '3 trips per month', trailingText: '3/3 Left'),
                  PlanFeature(title: 'Access to Explore and Marketplace'),
                  PlanFeature(title: 'Standard chat support'),
                ],
              ),

              const SizedBox(height: 32),

              // Choose Your Plan Section
              const _SectionLabel(label: 'CHOOSE YOUR PLAN'),
              const SizedBox(height: 12),
              PlanSelector(
                selectedPlan: selectedPlan,
                onPlanChanged: (plan) {
                  ref.read(selectedPlanProvider.notifier).state = plan;
                },
                monthlyPrice: '\$9.99',
                yearlyPrice: '\$79.99',
                savingsText: 'Save 33%',
              ),

              const SizedBox(height: 24),

              // Subscribe Button

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
                      onPressed: () {
                        final planName = selectedPlan == PlanType.monthly
                            ? 'Tripitify Premium Monthly'
                            : 'Tripitify Premium Yearly';
                        final price =
                            selectedPlan == PlanType.monthly ? 9.99 : 79.99;

                        context.push('/subscription-payment', extra: {
                          'selectedPlan': selectedPlan,
                          'planName': planName,
                          'price': price,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        'assets/images/more/Box.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: const Text(
                        'Subscribe to Premium',
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

              // Premium Features Section
              const _SectionLabel(label: 'PREMIUM FEATURES'),
              const SizedBox(height: 16),
              const PremiumFeatureItem(
                title: 'Unlimited Trip Planning',
                description: 'Create as many trips as you want',
              ),
              const PremiumFeatureItem(
                title: 'Priority Trip Planner Access',
                description: 'Get matched with top-rated planners first',
              ),
              const PremiumFeatureItem(
                title: 'Priority Support',
                description: '24/7 premium customer support',
              ),
              const PremiumFeatureItem(
                title: 'Advanced Calendar Sync',
                description: 'Sync with all your calendar apps',
              ),
              const PremiumFeatureItem(
                title: 'Group Planning Tools',
                description: 'Collaborate with up to 10 people',
              ),
              const PremiumFeatureItem(
                title: 'Exclusive Destinations',
                description: 'Access to premium destination guides',
              ),
              const PremiumFeatureItem(
                title: 'Early Access Features',
                description: 'Try new features before everyone else',
              ),

              const SizedBox(height: 32),

              // FAQ Section
              const _SectionLabel(label: 'FREQUENTLY ASKED QUESTIONS'),
              const SizedBox(height: 16),
              const FaqItem(
                question: 'Can I cancel anytime?',
                answer:
                    'Yes, you can cancel your premium subscription at any time. You\'ll keep access until the end of your billing period.',
                initiallyExpanded: true,
              ),
              const FaqItem(
                question: 'Do I get a refund if I cancel?',
                answer:
                    'Refunds are available within 14 days of purchase if you haven\'t used any premium features. After that, you can cancel anytime but won\'t receive a refund for the current billing period.',
              ),
              const FaqItem(
                question: 'Can I change my plan?',
                answer:
                    'Yes, you can upgrade or downgrade your plan at any time. Changes will take effect at the start of your next billing cycle.',
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Section Label Widget
class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF6B7280),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.5,
      ),
    );
  }
}
