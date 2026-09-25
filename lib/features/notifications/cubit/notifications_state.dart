import 'package:equatable/equatable.dart';

import '../domain/entities/notification.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const [],
  });

  final List<NotificationItem> notifications;

  int get unreadCount =>
      notifications.where((notification) => !notification.isRead).length;

  @override
  List<Object?> get props => [notifications];
}

final class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

final class NotificationsLoading extends NotificationsState {
  const NotificationsLoading({
    super.notifications,
  });
}

final class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({
    required super.notifications,
  });
}

final class NotificationsError extends NotificationsState {
  const NotificationsError({
    required this.message,
    super.notifications,
  });

  final String message;

  @override
  List<Object?> get props => [notifications, message];
}