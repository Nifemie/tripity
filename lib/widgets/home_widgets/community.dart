import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// State model for community highlight data
class CommunityHighlight {
  final String question;
  final int helpfulAnswers;
  final String timeAgo;

  CommunityHighlight({
    required this.question,
    required this.helpfulAnswers,
    required this.timeAgo,
  });
}

// Riverpod provider for community highlight state
final communityHighlightProvider = StateProvider<CommunityHighlight>((ref) {
  return CommunityHighlight(
    question: "What's the best time to visit Santorini for fewer crowds?",
    helpfulAnswers: 47,
    timeAgo: "2 hours ago",
  );
});

class CommunityHighlightWidget extends ConsumerWidget {
  const CommunityHighlightWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlight = ref.watch(communityHighlightProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24), // --Border-Radius-3xl
        border: Border.all(
          color: const Color(0xFFF3F4F6), // --Neutral-Gray-100
          width: 1,
        ),
        color: const Color(0xFFFFFFFF), // --Surface-Card
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 0,
            color: const Color(0xFF172554).withOpacity(0.08), // Card Shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/Home/Dialog.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Community Highlight',
                style: TextStyle(
                  color: Color(0xFF111827), // --Text-Primary
                  fontFamily: 'Instrument Sans',
                  fontSize: 16, // --Font-Size-base
                  fontWeight: FontWeight.w500, // --Font-Weight-medium
                  height: 24 / 16, // line-height: 24px
                  letterSpacing: 0, // --Letter-Spacing-normal
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // --Border-Radius-xl
              border: Border.all(
                color: const Color(0xFFF3F4F6), // --Neutral-Gray-100
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: Text(
              highlight.question,
              style: const TextStyle(
                color: Color(0xFF4B5563), // --Text-Secondary
                fontFamily: 'Instrument Sans',
                fontSize: 14, // --Font-Size-sm
                fontWeight: FontWeight.w400, // --Font-Weight-normal
                height: 21 / 14, // line-height: 21px
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Stats text
          Text(
            '${highlight.helpfulAnswers} helpful answers • ${highlight.timeAgo}',
            style: const TextStyle(
              color: Color(0xFF3B82F6), // --Primary-Blue-500
              fontFamily: 'Instrument Sans',
              fontSize: 12, // --Font-Size-xs
              fontWeight: FontWeight.w400, // --Font-Weight-normal
              height: 18 / 12, // line-height: 18px
            ),
          ),
          const SizedBox(height: 16),

          // Join conversation button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                // Handle join conversation action
                _onJoinConversation(ref);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF3F4F6), // --Neutral-Gray-100
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999), // --Border-Radius-full
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text(
                'Join the Conversation',
                style: TextStyle(
                  color: Color(0xFF111827), // --Text-Primary
                  fontFamily: 'Instrument Sans',
                  fontSize: 14, // --Font-Size-sm
                  fontWeight: FontWeight.w500, // --Font-Weight-medium
                  height: 17.5 / 14, // line-height: 17.5px
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onJoinConversation(WidgetRef ref) {
    // Handle the join conversation button tap
    // You can update state, navigate, or perform other actions here
    print('Join conversation tapped');

    // Example: You could update some state when button is pressed
    // ref.read(someOtherProvider.notifier).joinConversation();
  }
}

// Example usage in a screen
class CommunityHighlightScreen extends ConsumerWidget {
  const CommunityHighlightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: CommunityHighlightWidget(),
          ),
        ),
      ),
    );
  }
}

// Provider for handling button interactions or other state changes
final conversationStateProvider = StateNotifierProvider<ConversationStateNotifier, bool>((ref) {
  return ConversationStateNotifier();
});

class ConversationStateNotifier extends StateNotifier<bool> {
  ConversationStateNotifier() : super(false);

  void joinConversation() {
    state = true;
    // Handle join conversation logic here
  }

  void leaveConversation() {
    state = false;
  }
}