import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/features/notifications/cubit/notification_cubit.dart';
import 'package:abs/features/notifications/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // The cubit is already running (shared via BlocProvider.value from Header).
    // We only need to mark all as read once the screen opens.
    // We defer until after the first frame so the context is fully ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NotificationCubit>().markAllAsRead();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          _buildHeader(colorScheme),
          Expanded(
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoading ||
                    state is NotificationInitial) {
                  // NotificationInitial should never appear here because the
                  // cubit is already loaded, but guard it just in case.
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NotificationError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  );
                }

                if (state is NotificationLoaded) {
                  if (state.notifications.isEmpty) {
                    return Center(
                      child: Text(
                        "No notifications",
                        style: AppTextStyles.body1.copyWith(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = state.notifications[index];
                      return NotificationCard(
                        item: notification,
                        onPrimaryActionPressed: () {},
                        onSecondaryActionPressed: () {},
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 64, left: 24, right: 24, bottom: 28),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: AppTextStyles.heading1.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Check your notifications",
            style: AppTextStyles.body1.copyWith(
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
