import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/providers/account_setup_provider.dart';
import 'package:go_router/go_router.dart';

class AppStyles {
  static const Color primaryBlue500 = Color(0xFF3B82F6);
  static const Color primaryBlue600 = Color(0xFF2563EB);
  static const Color primaryBlue800 = Color(0xFF1E40AF);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);
  static const Color neutral100 = Color(0xFFF9FAFB);
  static const Color neutral200 = Color(0xFFF3F4F6);
  static const Color neutral300 = Color(0xFFD1D5DB);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: gray900,
    fontFamily: 'Instrument Sans',
    height: 27.5 / 20,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF4B5563),
    fontFamily: 'Instrument Sans',
    height: 21 / 14,
  );

  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: gray700,
    fontFamily: 'Instrument Sans',
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: gray900,
    fontFamily: 'Instrument Sans',
  );

  static const TextStyle hintTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: gray400,
    fontFamily: 'Instrument Sans',
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Instrument Sans',
  );
}

class AccountSetupScreenHeader extends StatelessWidget {
  const AccountSetupScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Account setup',
          style: AppStyles.titleTextStyle,
        ),
      ],
    );
  }
}

class AccountSetupForm extends ConsumerWidget {
  const AccountSetupForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountSetupProvider);
    final notifier = ref.read(accountSetupProvider.notifier);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Label('First Name'),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'Benjamin',
              prefixIcon: Icons.person_outline,
              onChanged: notifier.setFirstName,
            ),
            const SizedBox(height: 16),
            const Label('Last Name'),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'Adeyemi',
              prefixIcon: Icons.person_outline,
              onChanged: notifier.setLastName,
            ),
            const SizedBox(height: 16),
            const Label('Email'),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'benjamin.adeyemi@email.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              onChanged: notifier.setEmail,
            ),
            const SizedBox(height: 16),
            const Label('Phone Number', isOptional: true),
            const SizedBox(height: 8),
            PhoneField(
              onCountryCodeChanged: notifier.setCountryCode,
              onPhoneNumberChanged: notifier.setPhoneNumber,
            ),
            const SizedBox(height: 16),
            const Label('Password'),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: '••••••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: !state.isPasswordVisible,
              suffixIcon: IconButton(
                onPressed: notifier.togglePasswordVisibility,
                icon: Icon(
                  state.isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppStyles.gray500,
                  size: 20,
                ),
              ),
              onChanged: notifier.setPassword,
              enabled: !state.useOneTimePasscode,
            ),
            const SizedBox(height: 16),
            CheckboxTile(
              title: 'Use One-Time Passcode Instead',
              value: state.useOneTimePasscode,
              onChanged: (value) => notifier.setUseOneTimePasscode(value ?? false),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends ConsumerWidget {
  final VoidCallback onPressed;

  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFormValid = ref.watch(accountSetupProvider).isFormValid;

    return Container(
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
                  AppStyles.primaryBlue500,
                  AppStyles.primaryBlue600,
                  AppStyles.primaryBlue800,
                ],
                stops: [0.0, 0.5145, 1.0712],
              ),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: AppStyles.gray200,
            ),
      child: ElevatedButton(
        onPressed: isFormValid ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: AppStyles.gray400,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        child: const Text(
          'Continue',
          style: AppStyles.buttonTextStyle,
        ),
      ),
    );
  }
}

class Label extends StatelessWidget {
  final String text;
  final bool isOptional;

  const Label(this.text, {super.key, this.isOptional = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      isOptional ? '$text (optional)' : text,
      style: AppStyles.labelTextStyle,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppStyles.neutral300,
          width: 1,
        ),
        color: enabled ? AppStyles.neutral100 : AppStyles.neutral200,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            prefixIcon,
            color: enabled ? AppStyles.gray500 : AppStyles.gray400,
            size: 20,
          ),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: 24,
            color: AppStyles.neutral300,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              enabled: enabled,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              style: AppStyles.inputTextStyle.copyWith(
                color: enabled ? AppStyles.gray900 : AppStyles.gray400,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppStyles.hintTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}

class PhoneField extends ConsumerWidget {
  final ValueChanged<String> onCountryCodeChanged;
  final ValueChanged<String> onPhoneNumberChanged;

  const PhoneField({
    super.key,
    required this.onCountryCodeChanged,
    required this.onPhoneNumberChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCode = ref.watch(accountSetupProvider).countryCode;

    return Container(
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppStyles.neutral300,
          width: 1,
        ),
        color: AppStyles.neutral100,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: countryCode,
                items: const [
                  DropdownMenuItem(value: '+1', child: Text('+1')),
                  DropdownMenuItem(value: '+44', child: Text('+44')),
                  DropdownMenuItem(value: '+234', child: Text('+234')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onCountryCodeChanged(value);
                  }
                },
                style: AppStyles.inputTextStyle,
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: AppStyles.neutral300,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: onPhoneNumberChanged,
              textAlignVertical: TextAlignVertical.center,
              style: AppStyles.inputTextStyle,
              decoration: const InputDecoration(
                hintText: '(415) 555-0198',
                hintStyle: AppStyles.hintTextStyle,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class CheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                color: value ? AppStyles.primaryBlue500 : AppStyles.neutral300,
                width: 2,
              ),
              color: value ? AppStyles.primaryBlue500 : Colors.transparent,
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
            style: AppStyles.inputTextStyle.copyWith(color: AppStyles.gray700),
          ),
        ],
      ),
    );
  }
}