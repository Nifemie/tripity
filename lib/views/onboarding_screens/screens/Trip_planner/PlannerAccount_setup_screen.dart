import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../../../../providers/auth_providers.dart';

class PlannerAccountSetupScreen extends ConsumerWidget {
  const PlannerAccountSetupScreen({super.key});

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
    Navigator.pushNamed(context, '/planner-profile-setup');
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
                      _buildTextField(
                        hintText: 'Benjamin',
                        prefixIcon: Icons.person_outline,
                        onChanged: (value) => ref.read(firstNameProvider.notifier).state = value,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Last Name
                      _buildLabel('Last Name'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hintText: 'Adeyemi',
                        prefixIcon: Icons.person_outline,
                        onChanged: (value) => ref.read(lastNameProvider.notifier).state = value,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Email
                      _buildLabel('Email'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hintText: 'benjamin.adeyemi@email.com',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => ref.read(emailProvider.notifier).state = value,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Phone Number
                      _buildLabel('Phone Number', isOptional: true),
                      const SizedBox(height: 8),
                      _buildPhoneField(ref),
                      
                      const SizedBox(height: 16),
                      
                      // Password
                      _buildLabel('Password'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        hintText: '••••••••••••',
                        prefixIcon: Icons.lock_outline,
                        obscureText: !isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: () => ref.read(isPasswordVisibleProvider.notifier).state = !isPasswordVisible,
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: const Color(0xFF6B7280),
                            size: 20,
                          ),
                        ),
                        onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
                        enabled: !useOneTimePasscode,
                      ),
                      
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

  Widget _buildTextField({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
    bool enabled = true,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD1D5DB),
          width: 1,
        ),
        color: enabled ? const Color(0xFFF9FAFB) : const Color(0xFFF3F4F6),
      ),
      child: TextField(
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: enabled ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
          fontFamily: 'Instrument Sans',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9CA3AF),
            fontFamily: 'Instrument Sans',
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: enabled ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  Widget _buildPhoneField(WidgetRef ref) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD1D5DB),
          width: 1,
        ),
        color: const Color(0xFFF9FAFB),
      ),
      child: Row(
        children: [
          // Country code dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
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
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: const Color(0xFFD1D5DB),
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
                  color: Color(0xFF9CA3AF),
                  fontFamily: 'Instrument Sans',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 16),
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