import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/more_widgets/more_reusable_button.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final TextEditingController firstNameController = TextEditingController(
    text: 'Benjamin',
  );
  final TextEditingController lastNameController = TextEditingController(
    text: 'Adeyemi',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'Benjamin.adeyemi@email.com',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '(415) 555-0198',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '1/2',
                style: TextStyle(
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
          const SizedBox(height: 8),
          const TripProgressBar(currentStep: 1, totalSteps: 2),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Set Up Your Profile',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tell us a bit about yourself to get started with planning and exploring trips.',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // First Name
                  _buildInputField(
                    icon: Icons.person_outline,
                    hint: 'First Name',
                    controller: firstNameController,
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  _buildInputField(
                    icon: Icons.person_outline,
                    hint: 'Last Name',
                    controller: lastNameController,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildInputField(
                    icon: Icons.mail_outline,
                    hint: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),

                  // Phone Number (optional)
                  _buildPhoneInputField(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Bottom Buttons
          MoreButtonRow(
            secondaryText: 'Exit',
            onSecondary: () => Navigator.of(context).pop(),
            primaryText: 'Next',
            onPrimary: () {
              context.push('/edit-profile-2');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
        color: const Color(0xFFF9FAFB),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B7280), size: 20),
          const SizedBox(width: 8),
          Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111827),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneInputField() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
        color: const Color(0xFFF9FAFB),
      ),
      child: Row(
        children: [
          const Text(
            '+1',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(width: 8),
          Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF111827),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone Number (optional)',
                hintStyle: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
