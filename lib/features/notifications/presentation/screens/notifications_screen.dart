import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../cubit/notifications_cubit.dart';
import '../../cubit/notifications_state.dart';
import '../../domain/entities/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().loadNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final primaryTextColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Notifications',
          style: AppTextStyles.bodyMedium.copyWith(color: primaryTextColor),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state.unreadCount == 0) {
                return const SizedBox.shrink();
              }

              return TextButton(
                onPressed: () {
                  context.read<NotificationsCubit>().markAllAsRead();
                },
                child: Text(
                  'Mark all as read',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: primaryTextColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: AppSpacing.s8),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading && state.notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationsError && state.notifications.isEmpty) {
            return _ErrorView(
              message: state.message,
              primaryTextColor: primaryTextColor,
              secondaryTextColor: secondaryTextColor,
              onRetry: () {
                context.read<NotificationsCubit>().loadNotifications();
              },
            );
          }

          if (state.notifications.isEmpty) {
            return _EmptyView(
              primaryTextColor: primaryTextColor,
              secondaryTextColor: secondaryTextColor,
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<NotificationsCubit>().loadNotifications();
            },
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s16,
                AppSpacing.s8,
                AppSpacing.s16,
                AppSpacing.s32,
              ),
              itemCount: state.notifications.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.s10),
              itemBuilder: (context, index) {
                final notification = state.notifications[index];

                return _NotificationCard(
                  notification: notification,
                  isDark: isDark,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {
                    if (!notification.isRead) {
                      context.read<NotificationsCubit>().markAsRead(
                        notification.id,
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.isDark,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.onTap,
  });

  final NotificationItem notification;
  final bool isDark;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final unreadSurfaceColor = isDark
        ? AppColors.darkSurfaceMuted
        : AppColors.lightSurfaceMuted;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final cardColor = notification.isRead ? surfaceColor : unreadSurfaceColor;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r16),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.s16),
          decoration: BoxDecoration(
            border: Border.all(
              color: notification.isRead
                  ? borderColor
                  : primaryTextColor.withValues(alpha: 0.12),
            ),
            borderRadius: BorderRadius.circular(AppRadius.r16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NotificationIcon(
                type: notification.type,
                isRead: notification.isRead,
                isDark: isDark,
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: primaryTextColor,
                              fontWeight: notification.isRead
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s8),
                        Text(
                          _formatDate(notification.createdAt),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s6),
                    Text(
                      notification.body,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: secondaryTextColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead) ...[
                const SizedBox(width: AppSpacing.s8),
                Container(
                  width: AppSpacing.s8,
                  height: AppSpacing.s8,
                  margin: const EdgeInsets.only(top: AppSpacing.s6),
                  decoration: BoxDecoration(
                    color: primaryTextColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({
    required this.type,
    required this.isRead,
    required this.isDark,
  });

  final String type;
  final bool isRead;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final iconColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    IconData icon;

    switch (type) {
      case 'order':
        icon = Icons.local_shipping_outlined;
        break;
      case 'promotion':
        icon = Icons.local_offer_outlined;
        break;
      case 'account':
        icon = Icons.person_outline_rounded;
        break;
      default:
        icon = Icons.notifications_none_rounded;
    }

    return Container(
      width: AppSpacing.s40,
      height: AppSpacing.s40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Icon(
        icon,
        size: AppSpacing.s20,
        color: isRead ? iconColor.withValues(alpha: 0.65) : iconColor,
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: AppSpacing.s48,
              color: secondaryTextColor,
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              'No notifications yet',
              style: AppTextStyles.bodySmall.copyWith(color: primaryTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              'We will let you know when there is something new.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.onRetry,
  });

  final String message;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: AppSpacing.s48,
              color: secondaryTextColor,
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              'Something went wrong',
              style: AppTextStyles.bodySmall.copyWith(color: primaryTextColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s20),
            OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
