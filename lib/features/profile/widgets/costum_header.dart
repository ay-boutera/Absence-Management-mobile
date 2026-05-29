import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/features/profile/widgets/avatar.dart';
import 'package:flutter/material.dart';

class CostumHeader extends StatelessWidget {
  const CostumHeader({
    super.key,
    required this.user,
    required this.theme,
    required this.bottomPadding,
  });

  final UserEntity user;
  final ThemeData theme;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final topPadding = MediaQuery.of(context).padding.top;
        return Container(
          color: theme.primaryColor,
          padding: EdgeInsets.only(top: topPadding + 16, bottom: 60),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Avatar(user: user),
              ),
            ),
          ),
        );
      },
    );
  }
}
