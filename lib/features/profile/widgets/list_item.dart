import 'package:abs/config/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.hasChevron,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final bool hasChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, size: 22, color: theme.primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color:
                      theme.textTheme.bodyMedium?.color ??
                      const Color(0xFF475569),
                ),
              ),
            ),
            if (hasChevron)
              Icon(
                Icons.chevron_right,
                size: 20,
                color:
                    theme.iconTheme.color?.withValues(alpha: 0.5) ??
                    Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
