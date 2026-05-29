import 'package:abs/config/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);  
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: AppTextStyles.h3.copyWith(
          color: theme.textTheme.titleLarge?.color ?? const Color(0xFF334155),
        ),
      ),
    );
  }
}
