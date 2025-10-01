import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  final Widget label;
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final Widget? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const SizedBox(height: 8),
        Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD1D5DB)),
            color: const Color(0xFFF9FAFB),
          ),
          child: Row(
            children: [
              if (leadingIcon != null) ...[
                const SizedBox(width: 12),
                leadingIcon!,
                const SizedBox(width: 8),
                Container(width: 1, height: 20, color: const Color(0xFFE5E7EB)),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: leadingIcon == null ? const EdgeInsets.symmetric(horizontal: 12, vertical: 16) : EdgeInsets.zero,
                  ),
                ),
              ),
              if (trailingIcon != null) ...[
                Icon(trailingIcon, color: const Color(0xFF6B7280)),
                const SizedBox(width: 16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
