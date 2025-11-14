import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../../providers/auth_providers.dart';

class OtpVerification extends ConsumerWidget {
  final String email;

  const OtpVerification({Key? key, required this.email}) : super(key: key);

  void _onCodeChanged(String value, int index, WidgetRef ref) {
    final controllers = ref.read(otpControllersProvider);
    final focusNodes = ref.read(otpFocusNodesProvider);

    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    // Update the OTP code
    final code = controllers.map((controller) => controller.text).join();
    ref.read(otpCodeProvider.notifier).state = code;

    // Update the completion status
    final isComplete = controllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    ref.read(isCodeCompleteProvider.notifier).state = isComplete;
  }

  void _resendCode(WidgetRef ref) {
    ref.read(timerSecondsProvider.notifier).resendCode();
    // Add your resend OTP logic here
  }

  void _verifyCode(BuildContext context, WidgetRef ref) async {
    final code = ref.read(otpCodeProvider);

    try {
      // Add your verification logic here
      print('Verifying code: $code');

      // Simulate API verification call
      await Future.delayed(const Duration(seconds: 1));

      // Navigate to account setup after successful verification
      if (context.mounted) {
        context.push('/account-setup');
      }
    } catch (error) {
      // Handle verification error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = ref.watch(otpControllersProvider);
    final focusNodes = ref.watch(otpFocusNodesProvider);
    final remainingSeconds = ref.watch(timerSecondsProvider);
    final timerNotifier = ref.watch(timerSecondsProvider.notifier);
    final isCodeComplete = ref.watch(isCodeCompleteProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Verify your email',
          style: TextStyle(
            color: Color(0xFF111827), // Text-Primary
            fontFamily: 'Instrument Sans', // Font-Primary
            fontSize: 20, // Font-Size-xl
            fontWeight: FontWeight.w600, // Font-Weight-semibold
            height: 27.5 / 20, // 137.5% line-height
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            // Added to prevent overflow
            child: ConstrainedBox(
              // Ensures minimum height
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                // Makes children fill available space
                child: Column(
                  children: [
                    const SizedBox(height: 40), // Reduced from 80
                    // Title
                    const Text(
                      'Enter Verification Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111827), // Text-Primary
                        fontFamily: 'Instrument Sans', // Font-Primary
                        fontSize: 20, // Font-Size-xl
                        fontWeight: FontWeight.w600, // Font-Weight-semibold
                        height: 27.5 / 20, // 137.5% line-height
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    const Text(
                      'We\'ve sent a 6-digit code to your email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B5563), // Text-Secondary
                        fontFamily: 'Instrument Sans', // Font-Primary
                        fontSize: 16, // Font-Size-base
                        fontWeight: FontWeight.w400, // Font-Weight-normal
                        height: 24 / 16, // 150% line-height
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Email
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF3B82F6), // Primary-Blue-500
                        fontFamily: 'Instrument Sans', // Font-Primary
                        fontSize: 16, // Font-Size-base
                        fontWeight: FontWeight.w500, // Font-Weight-medium
                        height: 24 / 16, // line-height
                        letterSpacing: 0, // Letter-Spacing-normal
                      ),
                    ),

                    const SizedBox(height: 32), // Reduced from 48
                    // OTP Input Fields - Fixed spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => Flexible(
                          // Added Flexible to prevent overflow
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: index == 0 || index == 5
                                  ? 0
                                  : 4, // Add horizontal padding except first and last
                            ),
                            child: _buildOtpField(index, ref),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24), // Reduced from 32
                    // Timer and Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Code expires in ',
                          style: TextStyle(
                            color: Color(0xFF4B5563), // Text-Secondary
                            fontFamily: 'Instrument Sans', // Font-Primary
                            fontSize: 16, // Font-Size-base
                            fontWeight: FontWeight.w400, // Font-Weight-normal
                            height: 24 / 16, // 150% line-height
                          ),
                        ),
                        Text(
                          timerNotifier.formattedTime,
                          style: const TextStyle(
                            color: Color(0xFF4B5563), // Text-Secondary
                            fontFamily: 'Instrument Sans', // Font-Primary
                            fontSize: 16, // Font-Size-base
                            fontWeight: FontWeight.w400, // Font-Weight-normal
                            height: 24 / 16, // 150% line-height
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Resend Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn\'t receive any code? ',
                          style: TextStyle(
                            color: Color(0xFF4B5563), // Text-Secondary
                            fontFamily: 'Instrument Sans', // Font-Primary
                            fontSize: 16, // Font-Size-base
                            fontWeight: FontWeight.w400, // Font-Weight-normal
                            height: 24 / 16, // 150% line-height
                          ),
                        ),
                        GestureDetector(
                          onTap: remainingSeconds == 0
                              ? () => _resendCode(ref)
                              : null,
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: remainingSeconds == 0
                                  ? const Color(
                                      0xFF3B82F6,
                                    ) // Primary-Blue-500 when enabled
                                  : const Color(
                                      0xFF9CA3AF,
                                    ), // Gray when disabled
                              fontFamily: 'Instrument Sans', // Font-Primary
                              fontSize: 16, // Font-Size-base
                              fontWeight: FontWeight.w500, // Font-Weight-medium
                              height: 24 / 16, // line-height
                              letterSpacing: 0, // Letter-Spacing-normal
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(), // This will push the button to the bottom
                    // Verify Button
                    Container(
                      width: double.infinity,
                      height: 52,
                      margin: const EdgeInsets.only(bottom: 40),
                      decoration: isCodeComplete
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                9999,
                              ), // Border-Radius-full
                              gradient: const LinearGradient(
                                begin: Alignment(
                                  -0.0421,
                                  -1.0,
                                ), // 109deg equivalent
                                end: Alignment(1.0712, 1.0),
                                colors: [
                                  Color(0xFF3B82F6), // Primary-Blue-500
                                  Color(0xFF2563EB), // Primary-Blue-600
                                  Color(0xFF1E40AF), // Primary-Blue-800
                                ],
                                stops: [0.0, 0.5145, 1.0712],
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(9999),
                              color: const Color(
                                0xFFE5E7EB,
                              ), // Gray when disabled
                            ),
                      child: ElevatedButton(
                        onPressed: isCodeComplete
                            ? () => _verifyCode(context, ref)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              9999,
                            ), // Full border radius
                          ),
                          disabledBackgroundColor: Colors.transparent,
                          disabledForegroundColor: const Color(0xFF9CA3AF),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontFamily: 'Instrument Sans', // Font-Primary
                            fontSize: 16, // Font-Size-base
                            fontWeight: FontWeight.w500, // Font-Weight-medium
                            height: 24 / 16, // line-height
                            letterSpacing: 0, // Letter-Spacing-normal
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(int index, WidgetRef ref) {
    final controllers = ref.watch(otpControllersProvider);
    final focusNodes = ref.watch(otpFocusNodesProvider);

    return Container(
      width: 48, // Reduced from 52 to give more space
      height: 48, // Reduced from 52 to give more space
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Border-Radius-xl
        border: Border.all(
          color: const Color(0xFFD1D5DB), // Neutral-Gray-300
          width: 1,
        ),
        color: const Color(0xFFF9FAFB), // Neutral-Gray-50
      ),
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20, // Reduced from 24 to fit better
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          _onCodeChanged(value, index, ref);
        },
      ),
    );
  }
}
