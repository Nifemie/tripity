import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/notification_widgets/notification_item.dart';
import '../../widgets/notification_widgets/notification_filter_chip.dart';
import '../../widgets/notification_widgets/empty_notification.dart';
import '../../models/notification_model.dart';

// Provider for notifications
final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier();
});

class NotificationsState {
  final List<NotificationItem> notifications;
  final NotificationFilter selectedFilter;
  final bool hasUnread;

  NotificationsState({
    required this.notifications,
    this.selectedFilter = NotificationFilter.all,
    this.hasUnread = true,
  });

  NotificationsState copyWith({
    List<NotificationItem>? notifications,
    NotificationFilter? selectedFilter,
    bool? hasUnread,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      hasUnread: hasUnread ?? this.hasUnread,
    );
  }

  List<NotificationItem> get filteredNotifications {
    switch (selectedFilter) {
      case NotificationFilter.unread:
        return notifications.where((n) => !n.isRead).toList();
      case NotificationFilter.trips:
        return notifications
            .where((n) => n.type == NotificationType.tripReminder)
            .toList();
      case NotificationFilter.bookings:
        return notifications
            .where((n) => n.type == NotificationType.bookingConfirmed)
            .toList();
      case NotificationFilter.all:
        return notifications;
    }
  }

  int get unreadCount => notifications.where((n) => !n.isRead).toList().length;
  int get tripsCount => notifications
      .where((n) => n.type == NotificationType.tripReminder)
      .toList()
      .length;
  int get bookingsCount => notifications
      .where((n) => n.type == NotificationType.bookingConfirmed)
      .toList()
      .length;
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  NotificationsNotifier()
      : super(NotificationsState(notifications: _sampleNotifications));

  static final List<NotificationItem> _sampleNotifications = [
    NotificationItem(
      id: '1',
      type: NotificationType.bookingConfirmed,
      title: 'Booking Confirmed',
      message:
          'Your hotel reservation at Grand Hyatt Tokyo has been confirmed for March 15-22.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      type: NotificationType.message,
      title: 'New Message from Sarah Chen',
      message:
          'I\'ve updated your Tokyo itinerary with restaurant recommendations.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      type: NotificationType.tripReminder,
      title: 'Trip Reminder',
      message:
          'Your Paris getaway starts in 5 days. Don\'t forget to check-in online!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
    ),
    NotificationItem(
      id: '4',
      type: NotificationType.payment,
      title: 'Payment Processed',
      message:
          'Payment of \$65 for Tokyo Adventure trip plan request has successfully processed.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: false,
    ),
    NotificationItem(
      id: '5',
      type: NotificationType.offer,
      title: 'Special Offer',
      message:
          'Get 20% off on your next booking! Use code TRAVEL20. Valid until September 21.',
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      isRead: false,
    ),
  ];

  void markAsRead(String id) {
    state = state.copyWith(
      notifications: state.notifications.map((n) {
        if (n.id == id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList(),
    );
  }

  void markAllAsRead() {
    state = state.copyWith(
      notifications:
          state.notifications.map((n) => n.copyWith(isRead: true)).toList(),
      hasUnread: false,
    );
  }

  void setFilter(NotificationFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

enum NotificationFilter { all, unread, trips, bookings }

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsProvider);
    final filteredNotifications = notificationsState.filteredNotifications;
    final hasNotifications =
        notificationsState.hasUnread && filteredNotifications.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.375,
                        ),
                      ),
                    ],
                  ),
                  if (hasNotifications)
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(notificationsProvider.notifier)
                            .markAllAsRead();
                      },
                      child: const Text(
                        'Mark All as Read',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Filter Chips
            if (hasNotifications)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      NotificationFilterChip(
                        label: 'All',
                        count: notificationsState.notifications.length,
                        isSelected: notificationsState.selectedFilter ==
                            NotificationFilter.all,
                        onTap: () => ref
                            .read(notificationsProvider.notifier)
                            .setFilter(NotificationFilter.all),
                      ),
                      const SizedBox(width: 8),
                      NotificationFilterChip(
                        label: 'Unread',
                        count: notificationsState.unreadCount,
                        isSelected: notificationsState.selectedFilter ==
                            NotificationFilter.unread,
                        onTap: () => ref
                            .read(notificationsProvider.notifier)
                            .setFilter(NotificationFilter.unread),
                      ),
                      const SizedBox(width: 8),
                      NotificationFilterChip(
                        label: 'Trips',
                        count: notificationsState.tripsCount,
                        isSelected: notificationsState.selectedFilter ==
                            NotificationFilter.trips,
                        onTap: () => ref
                            .read(notificationsProvider.notifier)
                            .setFilter(NotificationFilter.trips),
                      ),
                      const SizedBox(width: 8),
                      NotificationFilterChip(
                        label: 'Bookings',
                        count: notificationsState.bookingsCount,
                        isSelected: notificationsState.selectedFilter ==
                            NotificationFilter.bookings,
                        onTap: () => ref
                            .read(notificationsProvider.notifier)
                            .setFilter(NotificationFilter.bookings),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Content
            Expanded(
              child: hasNotifications
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = filteredNotifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: NotificationItemWidget(
                            notification: notification,
                            onTap: () {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .markAsRead(notification.id);
                            },
                            onMarkAsRead: () {
                              ref
                                  .read(notificationsProvider.notifier)
                                  .markAsRead(notification.id);
                            },
                          ),
                        );
                      },
                    )
                  : const EmptyNotificationWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
