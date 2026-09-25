import '../../domain/entities/notification.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasource/notifications_remote_data_source.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  Future<List<NotificationItem>> getNotifications() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return const [];
    }

    final data = await _remoteDataSource.getNotifications(user.id);

    return data.map(_mapToEntity).toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.markAsRead(
      notificationId: notificationId,
      userId: user.id,
    );
  }

  @override
  Future<void> markAllAsRead() async {
    final user = _remoteDataSource.currentUser;

    if (user == null) {
      return;
    }

    await _remoteDataSource.markAllAsRead(user.id);
  }

  NotificationItem _mapToEntity(Map<String, dynamic> data) {
    return NotificationItem(
      id: data['id'] as String,
      title: data['title'] as String,
      body: data['body'] as String,
      type: data['type'] as String,
      isRead: data['is_read'] as bool? ?? false,
      orderId: data['order_id'] as String?,
      createdAt: DateTime.parse(data['created_at'] as String),
    );
  }
}
