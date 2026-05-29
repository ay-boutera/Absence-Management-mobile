import 'package:abs/core/entities/user_entity.dart';
import 'package:flutter/material.dart';

class CostumHeader extends StatelessWidget {
  const CostumHeader({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(
      builder: (context) {
        final topPadding = MediaQuery.of(context).padding.top;
        // Just a plain blue bar — no avatar, no bottom padding trick
        return Container(
          color: theme.primaryColor,
          height: topPadding + 80, // enough height for the bar
        );
      },
    );
  }
}
