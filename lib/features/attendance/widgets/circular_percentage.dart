import 'package:flutter/material.dart';

class CircularPercentage extends StatelessWidget {
  const CircularPercentage({super.key, required this.percentage});

  final int percentage;

  Color _getColor(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    if (percentage < 30) return Colors.red;
    if (percentage < 50) return Colors.orange;
    if (percentage < 75) return Colors.amber;
    return primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor(context);
    final value = (percentage / 100.0).clamp(0.0, 1.0);

    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 4,
            // Using a lighter version of the color for the background track
            backgroundColor: color.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
          Center(
            child: Text(
              '$percentage%',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
