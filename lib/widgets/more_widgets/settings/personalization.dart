import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Personalization Data Model
class PersonalizationItem {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const PersonalizationItem({
    required this.title,
    required this.value,
    this.onTap,
  });
}

// Theme provider
final themeProvider = StateProvider<String>((ref) => 'System default');

// Language provider
final languageProvider = StateProvider<String>((ref) => 'English (US)');

// Currency provider
final currencyProvider = StateProvider<String>((ref) => 'USD (\$)');

// Personalization items provider
final personalizationItemsProvider = Provider<List<PersonalizationItem>>((ref) {
  final theme = ref.watch(themeProvider);
  final language = ref.watch(languageProvider);
  final currency = ref.watch(currencyProvider);

  return [
    PersonalizationItem(
      title: 'Theme',
      value: theme,
      onTap: () => print('Theme tapped'),
    ),
    PersonalizationItem(
      title: 'Language',
      value: language,
      onTap: () => print('Language tapped'),
    ),
    PersonalizationItem(
      title: 'Currency',
      value: currency,
      onTap: () => print('Currency tapped'),
    ),
  ];
});

// Personalization Widget
class PersonalizationWidget extends ConsumerWidget {
  const PersonalizationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalizationItems = ref.watch(personalizationItemsProvider);

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
      child: Column(
        children: List.generate(
          personalizationItems.length,
              (index) {
            final item = personalizationItems[index];
            final isLast = index == personalizationItems.length - 1;

            return Column(
              children: [
                _PersonalizationListTile(item: item),
                if (!isLast)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFF3F4F6),
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Personalization List Tile
class _PersonalizationListTile extends StatelessWidget {
  final PersonalizationItem item;

  const _PersonalizationListTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.value,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Chevron Arrow
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example Usage
class PersonalizationWidgetExample extends ConsumerWidget {
  const PersonalizationWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Personalization'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PersonalizationWidget(),
            const SizedBox(height: 16),
            // Example: Update theme
            ElevatedButton(
              onPressed: () {
                ref.read(themeProvider.notifier).state = 'Dark mode';
              },
              child: const Text('Change to Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}