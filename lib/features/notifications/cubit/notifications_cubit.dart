import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/notification.dart';
import '../domain/repositories/notifications_repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepository)
    : super(const NotificationsInitial());

  final NotificationsRepository _notificationsRepository;

  List<NotificationItem> get notifications => state.notifications;

  int get unreadCount => state.unreadCount;

  Future<void> loadNotifications() async {
    emit(NotificationsLoading(notifications: state.notifications));

    try {
      final notifications = await _notificationsRepository.getNotifications();

      emit(
        NotificationsLoaded(notifications: List.unmodifiable(notifications)),
      );
    } catch (error) {
      emit(
        NotificationsError(
          message: _mapError(error),
          notifications: state.notifications,
        ),
      );
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationsRepository.markAsRead(notificationId);

      final updatedNotifications = state.notifications.map((notification) {
        if (notification.id != notificationId) {
          return notification;
        }

        return NotificationItem(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          isRead: true,
          orderId: notification.orderId,
          createdAt: notification.createdAt,
        );
      }).toList();

      emit(
        NotificationsLoaded(
          notifications: List.unmodifiable(updatedNotifications),
        ),
      );
    } catch (error) {
      emit(
        NotificationsError(
          message: _mapError(error),
          notifications: state.notifications,
        ),
      );
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _notificationsRepository.markAllAsRead();

      final updatedNotifications = state.notifications
          .map(
            (notification) => NotificationItem(
              id: notification.id,
              title: notification.title,
              body: notification.body,
              type: notification.type,
              isRead: true,
              orderId: notification.orderId,
              createdAt: notification.createdAt,
            ),
          )
          .toList();

      emit(
        NotificationsLoaded(
          notifications: List.unmodifiable(updatedNotifications),
        ),
      );
    } catch (error) {
      emit(
        NotificationsError(
          message: _mapError(error),
          notifications: state.notifications,
        ),
      );
    }
  }

  String _mapError(Object error) {
    final message = error.toString();

    if (message.contains('network') ||
        message.contains('SocketException') ||
        message.contains('Failed host lookup')) {
      return 'Network error. Please check your connection.';
    }

    return message;
  }
}
