import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Personal Information Data Model
class PersonalInformation {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String location;

  const PersonalInformation({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.location,
  });

  PersonalInformation copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? location,
  }) {
    return PersonalInformation(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
    );
  }
}

// Personal Information provider
final personalInformationProvider = StateProvider<PersonalInformation>((ref) {
  return const PersonalInformation(
    firstName: 'Benjamin',
    lastName: 'Adeyemi',
    email: 'ben.adeyemi@email.com',
    phoneNumber: '(415) 555-0198',
    location: 'Milan, Italy',
  );
});

// Personal Information Widget
class PersonalInformationWidget extends ConsumerWidget {
  const PersonalInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalInfo = ref.watch(personalInformationProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14172554),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Name
          _InputField(
            label: 'First Name',
            value: personalInfo.firstName,
            icon: Icons.person_outline,
            onChanged: (value) {
              ref.read(personalInformationProvider.notifier).state =
                  personalInfo.copyWith(firstName: value);
            },
          ),

          const SizedBox(height: 16),

          // Last Name
          _InputField(
            label: 'Last Name',
            value: personalInfo.lastName,
            icon: Icons.person_outline,
            onChanged: (value) {
              ref.read(personalInformationProvider.notifier).state =
                  personalInfo.copyWith(lastName: value);
            },
          ),

          const SizedBox(height: 16),

          // Email
          _InputField(
            label: 'Email',
            value: personalInfo.email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              ref.read(personalInformationProvider.notifier).state =
                  personalInfo.copyWith(email: value);
            },
          ),

          const SizedBox(height: 16),

          // Phone Number
          _PhoneInputField(
            label: 'Phone Number',
            value: personalInfo.phoneNumber,
            onChanged: (value) {
              ref.read(personalInformationProvider.notifier).state =
                  personalInfo.copyWith(phoneNumber: value);
            },
          ),

          const SizedBox(height: 16),

          // Location
          _InputField(
            label: 'Location',
            value: personalInfo.location,
            icon: Icons.location_on_outlined,
            onChanged: (value) {
              ref.read(personalInformationProvider.notifier).state =
                  personalInfo.copyWith(location: value);
            },
          ),
        ],
      ),
    );
  }
}

// Input Field Widget
class _InputField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const _InputField({
    required this.label,
    required this.value,
    required this.icon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),

        // Input Container
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD1D5DB),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Icon
              Icon(
                icon,
                color: const Color(0xFF6B7280),
                size: 20,
              ),

              const SizedBox(width: 8),

              // Vertical Divider
              Container(
                width: 1,
                height: 24,
                color: const Color(0xFFD1D5DB),
              ),

              const SizedBox(width: 8),

              // Text Field
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.collapsed(offset: value.length),
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  keyboardType: keyboardType,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Phone Input Field Widget (with country code dropdown)
class _PhoneInputField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String>? onChanged;

  const _PhoneInputField({
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF111827),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),

        // Input Container
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFD1D5DB),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Country Code Dropdown
              Row(
                children: [
                  const Text(
                    '+1',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                ],
              ),

              const SizedBox(width: 8),

              // Vertical Divider
              Container(
                width: 1,
                height: 24,
                color: const Color(0xFFD1D5DB),
              ),

              const SizedBox(width: 8),

              // Text Field
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value)
                    ..selection = TextSelection.collapsed(offset: value.length),
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Example Usage
class PersonalInformationExample extends ConsumerWidget {
  const PersonalInformationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PersonalInformationWidget(),
            const SizedBox(height: 16),
            // Display current values
            Consumer(
              builder: (context, ref, child) {
                final info = ref.watch(personalInformationProvider);
                return Text(
                  'Name: ${info.firstName} ${info.lastName}\n'
                      'Email: ${info.email}\n'
                      'Phone: ${info.phoneNumber}\n'
                      'Location: ${info.location}',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}