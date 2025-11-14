import 'package:flutter/material.dart';

class SelectionDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final String selectedValue;
  final Function(String) onSelected;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  late String _tempSelectedValue;

  @override
  void initState() {
    super.initState();
    _tempSelectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFF111827),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.375,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            ...widget.options.map((option) {
              final isSelected = _tempSelectedValue == option;
              return InkWell(
                onTap: () {
                  setState(() {
                    _tempSelectedValue = option;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFFD1D5DB),
                            width: 2,
                          ),
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF111827)
                                : const Color(0xFF6B7280),
                            fontSize: 16,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    widget.onSelected(_tempSelectedValue);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog
Future<void> showSelectionDialog({
  required BuildContext context,
  required String title,
  required List<String> options,
  required String selectedValue,
  required Function(String) onSelected,
}) {
  return showDialog(
    context: context,
    builder: (context) => SelectionDialog(
      title: title,
      options: options,
      selectedValue: selectedValue,
      onSelected: onSelected,
    ),
  );
}
