import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (user.avatarUrl != null) {
      return Image.network(
        user.avatarUrl!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
    final initials =
        '${user.firstName.isNotEmpty ? user.firstName[0] : ''}'
                '${user.lastName.isNotEmpty ? user.lastName[0] : ''}'
            .toUpperCase();
    return Container(
      width: 100,
      height: 100,
      color: theme.primaryColor,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: AppTextStyles.h1.copyWith(color: Colors.white),
      ),
    );
  }
}
