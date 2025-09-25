import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/account_setup_provider.dart';
import 'package:tripitify/widgets/account_setup_widgets.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';
import 'package:go_router/go_router.dart';

class PlannerAccountSetupScreen extends ConsumerWidget {
  const PlannerAccountSetupScreen({super.key});

  void _handleContinue(BuildContext context, WidgetRef ref) {
    final accountSetupState = ref.read(accountSetupProvider);

    print('Form Data:');
    print('Name: ${accountSetupState.firstName} ${accountSetupState.lastName}');
    print('Email: ${accountSetupState.email}');
    print('Phone: ${accountSetupState.countryCode} ${accountSetupState.phoneNumber}');
    print('Use One-Time Passcode: ${accountSetupState.useOneTimePasscode}');

    ref.read(progressProvider.notifier).increment();
    context.push('/planner-profile-setup');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(progressProvider.notifier).decrement();
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Account setup',
                    style: AppStyles.titleTextStyle,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TripProgressBar(
                currentStep: progressState.currentStep,
                totalSteps: progressState.totalSteps,
              ),
              const SizedBox(height: 32),
              const Text(
                'Create your account',
                style: AppStyles.titleTextStyle,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter basic details to begin exploring trips and recommendations',
                style: AppStyles.subtitleTextStyle,
              ),
              const SizedBox(height: 24),
              const AccountSetupForm(),
              ContinueButton(
                onPressed: () => _handleContinue(context, ref),
              ),
            ],
          ),
        ),
      ),
    );
  }
}