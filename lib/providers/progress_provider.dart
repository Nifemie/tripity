import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressState {
  final int currentStep;
  final int totalSteps;

  const ProgressState({required this.currentStep, required this.totalSteps});

  ProgressState copyWith({int? currentStep, int? totalSteps}) {
    return ProgressState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }
}

class ProgressNotifier extends StateNotifier<ProgressState> {
  ProgressNotifier() : super(const ProgressState(currentStep: 1, totalSteps: 4));

  void setCurrentStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void setTotalSteps(int total) {
    state = state.copyWith(totalSteps: total);
  }

  void increment() {
    if (state.currentStep < state.totalSteps) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void decrement() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }
}

final progressProvider = StateNotifierProvider<ProgressNotifier, ProgressState>((ref) {
  return ProgressNotifier();
});
