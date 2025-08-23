import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../providers/auth_providers.dart';

class ExploreSetupScreen extends ConsumerWidget {
  const ExploreSetupScreen({super.key});

  void _handleContinue(BuildContext context, WidgetRef ref) {
    // Handle form submission
    final firstName = ref.read(firstNameProvider);
    final lastName = ref.read(lastNameProvider);
    final email = ref.read(emailProvider);
    final phoneNumber = ref.read(phoneNumberProvider);
    final countryCode = ref.read(countryCodeProvider);
    final password = ref.read(passwordProvider);
    final useOneTimePasscode = ref.read(useOneTimePasscodeProvider);

    print('Form Data:');
    print('Name: $firstName $lastName');
    print('Email: $email');
    print('Phone: $countryCode $phoneNumber');
    print('Use One-Time Passcode: $useOneTimePasscode');

    // Navigate to next screen or submit data
    Navigator.pushNamed(context, '/travel-preferences');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFormValid = ref.watch(isFormValidProvider);
    final isPasswordVisible = ref.watch(isPasswordVisibleProvider);
    final useOneTimePasscode = ref.watch(useOneTimePasscodeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Header with back button and title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Account setup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      height: 27.5 / 20, // 137.5%
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Dynamic Progress bar
              _buildProgressBar(ref),

              const SizedBox(height: 32),

              // Create your account title
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  height: 27.5 / 20, // 137.5%
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Enter basic details to begin exploring trips and recommendations',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                  fontFamily: 'Instrument Sans',
                  height: 21 / 14, // 150%
                ),
              ),

              const SizedBox(height: 24),

              // Form fields
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Name
                      _buildLabel('First Name'),
                      const SizedBox(height: 8),
                      _buildInputWithDivider(
                        hintText: 'Benjamin',
                        icon: Icons.person_outline, // Replace with: SvgPicture.asset('assets/icons/person.svg', ...)
                        onChanged: (value) => ref.read(firstNameProvider.notifier).state = value,
                      ),

                      const SizedBox(height: 16),

                      // Last Name
                      _buildLabel('Last Name'),
                      const SizedBox(height: 8),
                      _buildInputWithDivider(
                        hintText: 'Adeyemi',
                        icon: Icons.person_outline, // Replace with: SvgPicture.asset('assets/icons/person.svg', ...)
                        onChanged: (value) => ref.read(lastNameProvider.notifier).state = value,
                      ),

                      const SizedBox(height: 16),

                      // Email
                      _buildLabel('Email'),
                      const SizedBox(height: 8),
                      _buildInputWithDivider(
                        hintText: 'benjamin.adeyemi@email.com',
                        icon: Icons.email_outlined, // Replace with: SvgPicture.asset('assets/icons/email.svg', ...)
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => ref.read(emailProvider.notifier).state = value,
                      ),

                      const SizedBox(height: 16),

                      // Phone Number
                      _buildLabel('Phone Number', isOptional: true),
                      const SizedBox(height: 8),
                      _buildPhoneInputWithDivider(ref),

                      const SizedBox(height: 16),

                      // Password
                      _buildLabel('Password'),
                      const SizedBox(height: 8),
                      _buildPasswordInputWithDivider(ref, isPasswordVisible, useOneTimePasscode),

                      const SizedBox(height: 16),

                      // One-Time Passcode Toggle
                      _buildCheckboxTile(
                        'Use One-Time Passcode Instead',
                        useOneTimePasscode,
                            (value) => ref.read(useOneTimePasscodeProvider.notifier).state = value ?? false,
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // Continue Button
              Container(
                width: double.infinity,
                height: 52,
                margin: const EdgeInsets.only(bottom: 32),
                decoration: isFormValid
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.0421, -1.0),
                    end: Alignment(1.0712, 1.0),
                    colors: [
                      Color(0xFF3B82F6), // Primary Blue 500
                      Color(0xFF2563EB), // Primary Blue 600
                      Color(0xFF1E40AF), // Primary Blue 800
                    ],
                    stops: [0.0, 0.5145, 1.0712],
                  ),
                )
                    : BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: const Color(0xFFE5E7EB),
                ),
                child: ElevatedButton(
                  onPressed: isFormValid ? () => _handleContinue(context, ref) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    disabledBackgroundColor: Colors.transparent,
                    disabledForegroundColor: const Color(0xFF9CA3AF),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Instrument Sans',
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

  Widget _buildProgressBar(WidgetRef ref) {
    final currentStep = ref.watch(currentStepProvider);
    const totalSteps = 4;

    return Container(
      height: 8,
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isActive = index < currentStep;
          final isFirst = index == 0;
          final isLast = index == totalSteps - 1;

          return Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: isFirst ? const Radius.circular(100) : Radius.zero,
                  bottomLeft: isFirst ? const Radius.circular(100) : Radius.zero,
                  topRight: isLast ? const Radius.circular(100) : Radius.zero,
                  bottomRight: isLast ? const Radius.circular(100) : Radius.zero,
                ),
                color: isActive
                    ? const Color(0xFF3B82F6) // Primary Blue 500 for completed/active steps
                    : const Color(0xFFE5E7EB), // Gray for inactive steps
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isOptional = false}) {
    return Text(
      isOptional ? '$text (optional)' : text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF374151),
        fontFamily: 'Instrument Sans',
      ),
    );
  }

  // Updated input field with SVG icon, divider, and consistent styling
  Widget _buildInputWithDivider({
    required String hintText,
    required IconData icon, // You can replace this with Widget icon for SVG support
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
    bool enabled = true,
    bool obscureText = false,
    Widget? suffixWidget,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: enabled ? const Color(0xFFF9FAFB) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon (replace with SvgPicture.asset when using SVG)
          Icon(icon, color: Colors.grey.shade400, size: 20),
          // For SVG: SvgPicture.asset('assets/icons/your_icon.svg', width: 20, height: 20, color: Colors.grey.shade400),

          const SizedBox(width: 12),

          // Vertical divider
          Container(
            width: 1,
            height: 24,
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
          ),

          const SizedBox(width: 12),

          // Text field
          Expanded(
            child: TextField(
              enabled: enabled,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onChanged,
              style: TextStyle(
                color: enabled ? Colors.black87 : const Color(0xFF9CA3AF),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Instrument Sans',
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Instrument Sans',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: false,
              ),
            ),
          ),

          // Optional suffix widget (like visibility toggle)
          if (suffixWidget != null) ...[
            const SizedBox(width: 12),
            suffixWidget,
          ],
        ],
      ),
    );
  }

  // Phone input field with country code dropdown, divider, and consistent styling
  Widget _buildPhoneInputWithDivider(WidgetRef ref) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Country code dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: ref.watch(countryCodeProvider),
              items: const [
                DropdownMenuItem(value: '+1', child: Text('+1')),
                DropdownMenuItem(value: '+44', child: Text('+44')),
                DropdownMenuItem(value: '+234', child: Text('+234')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(countryCodeProvider.notifier).state = value;
                }
              },
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
              ),
              icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF6B7280)),
            ),
          ),

          const SizedBox(width: 8),

          // Another vertical divider between country code and phone number
          Container(
            width: 1,
            height: 24,
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
          ),

          const SizedBox(width: 12),

          // Phone number input
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) => ref.read(phoneNumberProvider.notifier).state = value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
              ),
              decoration: const InputDecoration(
                hintText: '(415) 555-0198',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Instrument Sans',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Password input field with visibility toggle
  Widget _buildPasswordInputWithDivider(WidgetRef ref, bool isPasswordVisible, bool useOneTimePasscode) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: useOneTimePasscode ? const Color(0xFFF3F4F6) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Lock icon (replace with SVG)
          Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 20),
          // For SVG: SvgPicture.asset('assets/icons/lock.svg', width: 20, height: 20, color: Colors.grey.shade400),

          const SizedBox(width: 12),

          // Vertical divider
          Container(
            width: 1,
            height: 24,
            decoration: const BoxDecoration(color: Color(0xFFF9FAFB)),
          ),

          const SizedBox(width: 12),

          // Password text field
          Expanded(
            child: TextField(
              enabled: !useOneTimePasscode,
              obscureText: !isPasswordVisible,
              onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
              style: TextStyle(
                color: useOneTimePasscode ? const Color(0xFF9CA3AF) : Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Instrument Sans',
              ),
              decoration: const InputDecoration(
                hintText: '••••••••••••',
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Instrument Sans',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: false,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Password visibility toggle
          GestureDetector(
            onTap: useOneTimePasscode ? null : () => ref.read(isPasswordVisibleProvider.notifier).state = !isPasswordVisible,
            child: Icon(
              isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: useOneTimePasscode ? const Color(0xFF9CA3AF) : Colors.grey.shade400,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(String title, bool value, ValueChanged<bool?> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: value ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
                width: 2,
              ),
              color: value ? const Color(0xFF3B82F6) : Colors.transparent,
            ),
            child: value
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 14,
            )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF374151),
              fontFamily: 'Instrument Sans',
            ),
          ),
        ],
      ),
    );
  }
}