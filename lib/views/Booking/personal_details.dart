import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/providers/booking_providers.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/Bookings_widget/Bookings_cta_button.dart';

// ==================== PERSONAL DETAILS PROVIDERS ====================

final firstNameProvider = StateProvider<String>((ref) => '');
final lastNameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final phoneNumberProvider = StateProvider<String>((ref) => '');
final countryCodeProvider = StateProvider<String>((ref) => '+1');

// Validation provider
final isPersonalDetailsValidProvider = Provider<bool>((ref) {
  final firstName = ref.watch(firstNameProvider);
  final lastName = ref.watch(lastNameProvider);
  final email = ref.watch(emailProvider);
  final phone = ref.watch(phoneNumberProvider);

  return firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      email.contains('@') &&
      phone.isNotEmpty &&
      phone.length >= 10;
});

// ==================== PERSONAL DETAILS PAGE ====================

class PersonalDetailsPage extends ConsumerWidget {
  const PersonalDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(firstNameProvider);
    final lastName = ref.watch(lastNameProvider);
    final email = ref.watch(emailProvider);
    final phoneNumber = ref.watch(phoneNumberProvider);
    final countryCode = ref.watch(countryCodeProvider);
    final isValid = ref.watch(isPersonalDetailsValidProvider);
    final currentStep = ref.watch(bookingStepProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            ref.read(bookingStepProvider.notifier).state = 1;
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$currentStep/3',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          const SizedBox(height: 8),
          TripProgressBar(currentStep: currentStep, totalSteps: 3),
          const SizedBox(height: 24),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle
                    const Text(
                      'Please provide your personal details',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // First Name and Last Name Row
                    Row(
                      children: [
                        // First Name
                        Expanded(
                          child: _buildTextField(
                            label: 'First Name',
                            value: firstName,
                            placeholder: 'John',
                            onChanged: (value) {
                              ref.read(firstNameProvider.notifier).state =
                                  value;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Last Name
                        Expanded(
                          child: _buildTextField(
                            label: 'Last Name',
                            value: lastName,
                            placeholder: 'Doe',
                            onChanged: (value) {
                              ref.read(lastNameProvider.notifier).state = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Email
                    _buildTextField(
                      label: 'Email',
                      value: email,
                      placeholder: 'john@example.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        ref.read(emailProvider.notifier).state = value;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone Number
                    _buildPhoneField(
                      ref: ref,
                      countryCode: countryCode,
                      phoneNumber: phoneNumber,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom CTA Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Cancel Button (Secondary)
                  Expanded(
                    child: CtaButton(
                      text: 'Cancel',
                      onPressed: () {
                        _showCancelDialog(context);
                      },
                      isPrimary: false,
                      customBackgroundColor: const Color(0xFFF3F4F6),
                      customBorderColor: Colors.transparent,
                      customTextColor: const Color(0xFF111827), // Set text color to black
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Continue to Payment Button (Primary)
                  Expanded(
                    child: CtaButton(
                      text: 'Continue to Payment',
                      onPressed: () {
                        _continueToPayment(context, ref);
                      },
                      isEnabled: isValid,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TEXT FIELD ====================

  Widget _buildTextField({
    required String label,
    required String value,
    required String placeholder,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
            color: const Color(0xFFF9FAFB),
          ),
          child: TextField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111827),
              height: 1.5,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== PHONE FIELD ====================

  Widget _buildPhoneField({
    required WidgetRef ref,
    required String countryCode,
    required String phoneNumber,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone Number',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
            color: const Color(0xFFF9FAFB),
          ),
          child: Row(
            children: [
              // Country Code Dropdown
              GestureDetector(
                onTap: () {
                  _showCountryCodePicker(ref);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        countryCode,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: Color(0xFF6B7280),
                      ),
                    ],
                  ),
                ),
              ),

              // Vertical Divider
              Container(width: 1, height: 32, color: const Color(0xFFD1D5DB)),

              // Phone Number Input
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    onChanged: (value) {
                      ref.read(phoneNumberProvider.notifier).state = value;
                    },
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF111827),
                      height: 1.5,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '(415) 555-0198',
                      hintStyle: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9CA3AF),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== COUNTRY CODE PICKER ====================

  void _showCountryCodePicker(WidgetRef ref) {
    // Simple country codes list
    final countryCodes = [
      '+1',
      '+44',
      '+91',
      '+61',
      '+81',
      '+86',
      '+33',
      '+49',
    ];

    showModalBottomSheet(
      context: ref.context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFE5E7EB),
                  ),
                ),

                // Title
                const Text(
                  'Select Country Code',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Country codes list
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: countryCodes.length,
                  separatorBuilder:
                      (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  itemBuilder: (context, index) {
                    final code = countryCodes[index];
                    return ListTile(
                      title: Text(
                        code,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),
                      onTap: () {
                        ref.read(countryCodeProvider.notifier).state = code;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== CANCEL DIALOG ====================

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Cancel Booking?',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          content: const Text(
            'Are you sure you want to cancel this booking? All your entered information will be lost.',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No, Continue',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== NAVIGATION ====================

  void _continueToPayment(BuildContext context, WidgetRef ref) {
    // Increment booking step
    ref.read(bookingStepProvider.notifier).state = 3;

    // Navigate to payment page
    context.push('/payment-confirmation');
  }
}
