import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/validators.dart';

// Providers for OTP verification state
final otpControllersProvider = Provider<List<TextEditingController>>((ref) {
  final controllers = List.generate(6, (index) => TextEditingController());

  // Dispose controllers when provider is disposed
  ref.onDispose(() {
    for (var controller in controllers) {
      controller.dispose();
    }
  });

  return controllers;
});

final otpFocusNodesProvider = Provider<List<FocusNode>>((ref) {
  final focusNodes = List.generate(6, (index) => FocusNode());

  // Dispose focus nodes when provider is disposed
  ref.onDispose(() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
  });

  return focusNodes;
});

final timerSecondsProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

final otpCodeProvider = StateProvider<String>((ref) => '');

final isCodeCompleteProvider = StateProvider<bool>((ref) => false);

// Timer State Notifier
class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(59) {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state = state - 1;
      } else {
        timer.cancel();
      }
    });
  }

  void resendCode() {
    state = 59;
    _startTimer();
  }

  String get formattedTime {
    int minutes = state ~/ 60;
    int seconds = state % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// Providers for account setup form
final currentStepProvider = StateProvider<int>((ref) => 2); // Step 2 for account setup

final firstNameProvider = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final phoneNumberProvider = StateProvider<String>((ref) => '');
final countryCodeProvider = StateProvider<String>((ref) => '+1');
final passwordProvider = StateProvider<String>((ref) => '');
final useOneTimePasscodeProvider = StateProvider<bool>((ref) => false);
final isPasswordVisibleProvider = StateProvider<bool>((ref) => false);

// Form validation provider
final isFormValidProvider = Provider<bool>((ref) {
  final firstName = ref.watch(firstNameProvider);
  final lastName = ref.watch(lastNameProvider);
  final email = ref.watch(emailProvider);
  final password = ref.watch(passwordProvider);
  final useOneTimePasscode = ref.watch(useOneTimePasscodeProvider);

  return Validators.isNotEmpty(firstName) &&
      Validators.isNotEmpty(lastName) &&
      Validators.isValidEmail(email) &&
      (useOneTimePasscode || Validators.isPasswordValid(password));
});