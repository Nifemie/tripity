import 'package:flutter/material.dart';

enum NotificationType {
  bookingConfirmed,
  message,
  tripReminder,
  payment,
  offer,
}

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  NotificationItem copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }

  IconData get iconData {
    switch (type) {
      case NotificationType.bookingConfirmed:
        return Icons.check_circle_outline;
      case NotificationType.message:
        return Icons.chat_bubble_outline;
      case NotificationType.tripReminder:
        return Icons.access_time;
      case NotificationType.payment:
        return Icons.credit_card;
      case NotificationType.offer:
        return Icons.local_offer_outlined;
    }
  }

  Color get iconColor {
    switch (type) {
      case NotificationType.bookingConfirmed:
        return const Color(0xFF10B981);
      case NotificationType.message:
        return const Color(0xFF3B82F6);
      case NotificationType.tripReminder:
        return const Color(0xFFF59E0B);
      case NotificationType.payment:
        return const Color(0xFF10B981);
      case NotificationType.offer:
        return const Color(0xFF8B5CF6);
    }
  }

  Color get iconBackgroundColor {
    switch (type) {
      case NotificationType.bookingConfirmed:
        return const Color(0xFFD1FAE5);
      case NotificationType.message:
        return const Color(0xFFDBEAFE);
      case NotificationType.tripReminder:
        return const Color(0xFFFEF3C7);
      case NotificationType.payment:
        return const Color(0xFFD1FAE5);
      case NotificationType.offer:
        return const Color(0xFFEDE9FE);
    }
  }
}
