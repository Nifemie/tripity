import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  int? expandedIndex;

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
            Icons.arrow_back_ios_new,
            color: Color(0xFF111827),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search topics or issues...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // CONTACT US Section
              const _SectionLabel(label: 'CONTACT US'),
              const SizedBox(height: 16),

              // Live Chat
              _ContactCard(
                icon: Icons.chat_bubble_outline,
                title: 'Live Chat',
                subtitle: 'Chat with our support team',
                additionalInfo: 'Available now',
                additionalInfoColor: const Color(0xFF3B82F6),
                isHighlighted: true,
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Email Support
              _ContactCard(
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'support@triptify.com',
                additionalInfo: 'Respond within 24h',
                additionalInfoColor: const Color(0xFF3B82F6),
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Phone Support
              _ContactCard(
                icon: Icons.phone_outlined,
                title: 'Phone Support',
                subtitle: '+1 (555) 123-4567',
                additionalInfo: 'Mon-Fri, 9 AM - 6 PM EST',
                additionalInfoColor: const Color(0xFF3B82F6),
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // NOTIFICATIONS Section (Help Topics)
              const _SectionLabel(label: 'NOTIFICATIONS'),
              const SizedBox(height: 16),

              // Getting Started Guide
              _HelpTopicCard(
                icon: Icons.menu_book_outlined,
                title: 'Getting Started Guide',
                subtitle:
                    'Learn how to plan and manage your trips with Triptify.',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Booking & Payments
              _HelpTopicCard(
                icon: Icons.attach_money,
                title: 'Booking & Payments',
                subtitle: 'Understand deposits, approvals, and refunds.',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Using Your Travel Calendar
              _HelpTopicCard(
                icon: Icons.calendar_today_outlined,
                title: 'Using Your Travel Calendar',
                subtitle: 'Organize upcoming trips and itineraries easily.',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Connecting with Planners
              _HelpTopicCard(
                icon: Icons.connect_without_contact_outlined,
                title: 'Connecting with Planners',
                subtitle: 'Find, request, and communicate with trip planners.',
                onTap: () {},
              ),

              const SizedBox(height: 12),

              // Video Tutorials
              _HelpTopicCard(
                icon: Icons.play_circle_outline,
                title: 'Video Tutorials',
                subtitle:
                    'Watch quick walkthroughs for common traveler actions.',
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // FREQUENTLY ASKED QUESTIONS Section
              const _SectionLabel(label: 'FREQUENTLY ASKED QUESTIONS'),
              const SizedBox(height: 16),

              _FAQItem(
                question: 'How do I request a trip plan?',
                answer:
                    'You can browse trip planners, view their profiles, and send a request from their page. Once they respond, you\'ll receive updates under "My Requests."',
                isExpanded: expandedIndex == 0,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 0 ? null : 0;
                  });
                },
              ),

              const SizedBox(height: 12),

              _FAQItem(
                question: 'When is my payment charged?',
                answer:
                    'Payment is charged after the trip planner accepts your request and you approve the trip plan.',
                isExpanded: expandedIndex == 1,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 1 ? null : 1;
                  });
                },
              ),

              const SizedBox(height: 12),

              _FAQItem(
                question: 'Can I edit or cancel a trip request?',
                answer:
                    'Yes, you can edit or cancel a trip request before the planner accepts it.',
                isExpanded: expandedIndex == 2,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 2 ? null : 2;
                  });
                },
              ),

              const SizedBox(height: 12),

              _FAQItem(
                question: 'How do I communicate with a planner?',
                answer:
                    'You can communicate with planners through the in-app messaging system.',
                isExpanded: expandedIndex == 3,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 3 ? null : 3;
                  });
                },
              ),

              const SizedBox(height: 12),

              _FAQItem(
                question: 'What if I\'m not satisfied with a trip plan?',
                answer:
                    'You can request revisions or contact our support team for assistance.',
                isExpanded: expandedIndex == 4,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 4 ? null : 4;
                  });
                },
              ),

              const SizedBox(height: 12),

              _FAQItem(
                question: 'Can I plan my own trip without a planner?',
                answer:
                    'Yes, you can use our trip planning tools to create your own itinerary.',
                isExpanded: expandedIndex == 5,
                onTap: () {
                  setState(() {
                    expandedIndex = expandedIndex == 5 ? null : 5;
                  });
                },
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// Section Label Widget
class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF9CA3AF),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.5,
      ),
    );
  }
}

// Contact Card Widget
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String additionalInfo;
  final Color additionalInfoColor;
  final bool isHighlighted;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.additionalInfo,
    required this.additionalInfoColor,
    this.isHighlighted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHighlighted ? const Color(0xFFDCEAFE) : Colors.white,
          border: Border.all(
            color: isHighlighted
                ? const Color(0xFF93C5FD)
                : const Color(0xFFE5E7EB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isHighlighted ? Colors.white : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF111827),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    additionalInfo,
                    style: TextStyle(
                      color: additionalInfoColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// Help Topic Card Widget
class _HelpTopicCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HelpTopicCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFDCEAFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF3B82F6),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

// FAQ Item Widget
class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.help_outline,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 24,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  answer,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
