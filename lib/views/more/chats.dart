import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/chat_widgets/chat_list_item.dart';
import 'chat_conversation.dart';

// Chat data model
class ChatItem {
  final String id;
  final String name;
  final String role;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final bool isVerified;
  final bool hasUnread;
  final int unreadCount;

  ChatItem({
    required this.id,
    required this.name,
    required this.role,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    this.isVerified = false,
    this.hasUnread = false,
    this.unreadCount = 0,
  });
}

// Sample chat data provider
final chatsProvider = StateProvider<List<ChatItem>>((ref) {
  return [
    ChatItem(
      id: '1',
      name: 'Wade Warren',
      role: 'Trip Planner',
      lastMessage: 'I\'ve updated your Tokyo itinerary with the new r...',
      time: '05:48 pm',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      isVerified: true,
      hasUnread: true,
      unreadCount: 2,
    ),
    ChatItem(
      id: '2',
      name: 'Esther Howard',
      role: 'Trip Planner',
      lastMessage: 'Would you like to add the volcano hiking tour to...',
      time: '02:34 am',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      isVerified: true,
    ),
    ChatItem(
      id: '3',
      name: 'Robert Fox',
      role: 'Trip Planner',
      lastMessage: 'Would you like to add the volcano hiking tour to...',
      time: 'yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      isVerified: true,
      hasUnread: true,
      unreadCount: 1,
    ),
    ChatItem(
      id: '4',
      name: 'Support Team',
      role: 'Customer Support',
      lastMessage: 'Your booking has been processed successfully...',
      time: 'yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      isVerified: true,
    ),
  ];
});

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Chats',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle settings
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        size: 20,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search conversations...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Chat list or empty state
            Expanded(
              child: chats.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        return ChatListItem(
                          chat: chat,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatConversationScreen(
                                  chatId: chat.id,
                                  name: chat.name,
                                  role: chat.role,
                                  avatarUrl: chat.avatarUrl,
                                  isVerified: chat.isVerified,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.chat_bubble_outline,
              size: 40,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No conversations yet',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Once you connect with a planner or start a trip, your chats will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
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
  }
}
