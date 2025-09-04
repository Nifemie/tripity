
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/account_setup_provider.dart';
import 'package:tripitify/widgets/account_setup_widgets.dart';
import 'package:tripitify/widgets/progress_bar.dart';
import 'package:tripitify/providers/progress_provider.dart';

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
    Navigator.pushNamed(context, '/planner-profile-setup');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const AccountSetupScreenHeader(),
              const SizedBox(height: 16),
              const ProgressBar(),
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
