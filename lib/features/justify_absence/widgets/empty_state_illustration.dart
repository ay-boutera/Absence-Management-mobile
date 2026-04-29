import 'package:flutter/material.dart';

class EmptyStateIllustration extends StatelessWidget {
  const EmptyStateIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative background elements
          Positioned(
            left: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: Icon(
              Icons.star_outline,
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              size: 16,
            ),
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: Icon(
              Icons.star_outline,
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              size: 12,
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.add,
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              size: 16,
            ),
          ),
          // Main circle with X
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(color: theme.colorScheme.primary, width: 2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: theme.colorScheme.primary,
              size: 48,
            ),
          ),
          // TODO: Replace with your SVG asset
          // Uncomment and use this instead:
          // SvgPicture.asset(
          //   'assets/icons/no-exams.svg',
          //   width: 200,
          //   height: 200,
          //   fit: BoxFit.contain,
          // ),
        ],
      ),
    );
  }
}
