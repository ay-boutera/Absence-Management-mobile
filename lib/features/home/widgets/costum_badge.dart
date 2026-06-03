import 'package:flutter/material.dart';

class CostumBadge extends StatelessWidget {
  const CostumBadge({
    super.key,
    required this.count,
    required this.context,
  });

  final int count;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return count == 0
        ? SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              count.toString(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          );
  }
}
