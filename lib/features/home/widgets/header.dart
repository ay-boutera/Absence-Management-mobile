// features/home/pages/home_page.dart

import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            AppAssets.profile,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
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
              style: AppTextStyles.bodyMedium.copyWith(color: colors.primary),
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset(
          AppAssets.logo,
          colorFilter: ColorFilter.mode(colors.primary, BlendMode.srcIn),
          height: 48,
          width: 48,
        ),
      ],
    );
  }
}
