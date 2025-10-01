import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  const DateField({
    Key? key,
    required this.label,
    this.date,
    required this.placeholder,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final DateTime? date;
  final String placeholder;
  final VoidCallback onTap;

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD1D5DB)),
              color: const Color(0xFFF9FAFB),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    date != null ? _formatDate(date!) : placeholder,
                    style: TextStyle(
                      color: const Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today_outlined, color: const Color(0xFF6B7280), size: 20),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
