import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/more_widgets/more_reusable_button.dart';
import 'package:tripitify/widgets/more_widgets/update_password_downsheet_modal.dart';

// Riverpod providers for password visibility
final currentPasswordVisibleProvider = StateProvider<bool>((ref) => false);
final newPasswordVisibleProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibleProvider = StateProvider<bool>((ref) => false);

// Riverpod providers for controllers (autoDispose for cleanup)
final currentPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );
final newPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );
final confirmPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPasswordController = ref.watch(
      currentPasswordControllerProvider,
    );
    final newPasswordController = ref.watch(newPasswordControllerProvider);
    final confirmPasswordController = ref.watch(
      confirmPasswordControllerProvider,
    );
    final currentPasswordVisible = ref.watch(currentPasswordVisibleProvider);
    final newPasswordVisible = ref.watch(newPasswordVisibleProvider);
    final confirmPasswordVisible = ref.watch(confirmPasswordVisibleProvider);

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
          'Change Password',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Choose a strong password to keep your account secure',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 28),
                _buildPasswordField(
                  label: 'Current Password',
                  controller: currentPasswordController,
                  visible: currentPasswordVisible,
                  onVisibilityToggle:
                      () =>
                          ref
                              .read(currentPasswordVisibleProvider.notifier)
                              .state = !currentPasswordVisible,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  label: 'New Password',
                  controller: newPasswordController,
                  visible: newPasswordVisible,
                  onVisibilityToggle:
                      () =>
                          ref.read(newPasswordVisibleProvider.notifier).state =
                              !newPasswordVisible,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  label: 'Confirm New Password',
                  controller: confirmPasswordController,
                  visible: confirmPasswordVisible,
                  onVisibilityToggle:
                      () =>
                          ref
                              .read(confirmPasswordVisibleProvider.notifier)
                              .state = !confirmPasswordVisible,
                ),
                const SizedBox(height: 28),
                const Text(
                  'Your password must include:',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(height: 12),
                _buildChecklistItem('At least 8 characters'),
                _buildChecklistItem('One uppercase letter (A–Z)'),
                _buildChecklistItem('One lowercase letter (a–z)'),
                _buildChecklistItem('One number (0–9)'),
                _buildChecklistItem('One special character (@#\$%*&)'),
                const SizedBox(height: 40),
                MoreFullWidthBarButton(
                  text: 'Update Password',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder:
                          (context) => UpdatePasswordDownsheetModal(
                            onDone: () => Navigator.of(context).pop(),
                          ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onVisibilityToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFD1D5DB), width: 1),
            color: const Color(0xFFF9FAFB),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.lock_outline,
                  color: Color(0xFF6B7280),
                  size: 20,
                ),
              ),
              Container(width: 1, height: 28, color: const Color(0xFFD1D5DB)),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: !visible,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    color: Color(0xFF111827),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  visible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF6B7280),
                  size: 20,
                ),
                onPressed: onVisibilityToggle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2563EB), size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2563EB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
