// features/home/pages/home_page.dart

import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/features/notifications/screens/notifications_screen.dart';
import 'package:abs/features/notifications/cubit/notification_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        ClipOval(
          child: SvgPicture.asset(
            AppAssets.logo,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() + user.firstName.substring(1) : ''} "
              "${user.lastName.isNotEmpty ? user.lastName[0].toUpperCase() + user.lastName.substring(1) : ''}",
              style: AppTextStyles.bodyMedium,
            ),
            Text(
              "${user.level} student (${user.group})",
              style: AppTextStyles.bodyMedium.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        const Spacer(),
        BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            int unreadCount = 0;
            if (state is NotificationLoaded) {
              unreadCount = state.unreadCount;
            }

            final cubit = context.read<NotificationCubit>();

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: const NotificationsScreen(),
                    ),
                  ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    color: colorScheme.primary,
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
