import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ==================== FAQ MODEL ====================

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

// ==================== FAQ DATA ====================

final List<FAQItem> faqData = [
  FAQItem(
    question: 'What should I bring along with me?',
    answer:
        'Please bring comfortable walking shoes, a water bottle, sunscreen, and a hat. We also recommend bringing a camera to capture the beautiful sights along the way. Weather-appropriate clothing is essential.',
  ),
  FAQItem(
    question: 'Is this suitable for children?',
    answer:
        'Yes, this tour is family-friendly and suitable for children of all ages. The pace is moderate and we make regular stops. Children under 12 must be accompanied by an adult.',
  ),
  FAQItem(
    question: 'What happens if it rains?',
    answer:
        'Tours run rain or shine. In case of light rain, we provide umbrellas and continue the tour. For severe weather conditions, we may reschedule or offer a full refund.',
  ),
  FAQItem(
    question: 'Are dietary restrictions accommodated?',
    answer:
        'Absolutely! Please inform us of any dietary restrictions or allergies when booking. We work with local vendors who can accommodate vegetarian, vegan, gluten-free, and other dietary needs.',
  ),
];

// ==================== FAQS WIDGET ====================

class FAQsWidget extends StatefulWidget {
  const FAQsWidget({Key? key}) : super(key: key);

  @override
  State<FAQsWidget> createState() => _FAQsWidgetState();
}

class _FAQsWidgetState extends State<FAQsWidget> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 12),

        // FAQ Items
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: faqData.length,
          separatorBuilder:
              (context, index) => Container(
                height: 1,
                color: const Color(0xFFE5E7EB),
                margin: const EdgeInsets.symmetric(vertical: 0),
              ),
          itemBuilder: (context, index) {
            final faq = faqData[index];
            final isExpanded = _expandedIndex == index;

            return Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8,
                ),
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF6B7280),
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '?',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6B7280),
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  faq.question,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF6B7280),
                  size: 20,
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? index : null;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 0,
                      bottom: 16,
                      top: 0,
                    ),
                    child: Text(
                      faq.answer,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Still Have Questions Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFEFF6FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/Bookings/Chat_Round.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF3B82F6),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Still have questions?',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Subtitle
              const Text(
                'Our representatives are on ground to put you through what you need to know',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Contact Provider Button
              GestureDetector(
                onTap: () {
                  // Handle contact provider action
                  print('Contact Provider tapped');
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFFFFFFFF),
                  ),
                  child: const Center(
                    child: Text(
                      'Contact Provider',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B82F6),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
