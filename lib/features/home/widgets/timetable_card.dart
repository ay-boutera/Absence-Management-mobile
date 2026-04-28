import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TimetableCard extends StatelessWidget {
  const TimetableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.myTimetable,
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
                Text(
                  l10n.checkTimetable,
                  style: AppTextStyles.h5.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          SvgPicture.asset(AppAssets.note),
        ],
      ),
    );
  }
}
