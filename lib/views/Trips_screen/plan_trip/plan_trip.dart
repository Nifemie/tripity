import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/providers/plan_trip_provider.dart';
import 'package:tripitify/models/plan_trip_model.dart';

class PlanNewTripPage extends ConsumerWidget {
  const PlanNewTripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripPlanningState = ref.watch(tripPlanningProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Plan a New Trip',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false, // Changed to align with back arrow
        titleSpacing: 0, // Reduced spacing between back arrow and title
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'How Would You Like to Plan Your Trip?',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.375,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'You can build your itinerary yourself or work with a verified trip planner to help craft the perfect experience.',
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PlanningOptionWidget(
                    type: PlanningType.planItMyself,
                    title: 'Plan it Myself',
                    description: 'Start from scratch and customize your own itinerary, budget, and preferences.',
                    icon: Icons.person_outline,
                    isSelected: tripPlanningState.selectedType == PlanningType.planItMyself,
                    onTap: () => ref.read(tripPlanningProvider.notifier).selectPlanningType(PlanningType.planItMyself),
                  ),
                  const SizedBox(height: 16),
                  PlanningOptionWidget(
                    type: PlanningType.useTripPlanner,
                    title: 'Use a Trip Planner',
                    description: 'Share your preferences and budget, and we\'ll connect you with trusted travel planners who\'ll handle the details.',
                    icon: Icons.people_outline,
                    isSelected: tripPlanningState.selectedType == PlanningType.useTripPlanner,
                    onTap: () => ref.read(tripPlanningProvider.notifier).selectPlanningType(PlanningType.useTripPlanner),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(
                top: BorderSide(
                  color: Color(0xFFF3F4F6),
                  width: 1,
                ),
              ),
            ),
            child: ContinueButton(
              isEnabled: tripPlanningState.selectedType != null,
              onPressed: () {
                if (tripPlanningState.selectedType == PlanningType.planItMyself) {
                  context.push('/self-plan-setup');
                } else if (tripPlanningState.selectedType == PlanningType.useTripPlanner) {
                  context.push('/search-planner');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlanningOptionWidget extends StatelessWidget {
  final PlanningType type;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanningOptionWidget({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFF3F4F6),
          border: isSelected
              ? Border.all(color: const Color(0xFF3B82F6), width: 2)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: const Color(0xFF111827),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
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
    );
  }
}

class ContinueButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const ContinueButton({
    Key? key,
    required this.isEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26), // Half of height for perfect pill shape
          color: isEnabled ? null : const Color(0xFFD1D5DB),
          gradient: isEnabled
              ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF3B82F6),
              Color(0xFF2563EB),
              Color(0xFF1E40AF),
            ],
            stops: [0.0, 0.51, 1.0],
          )
              : null,
        ),
        child: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}