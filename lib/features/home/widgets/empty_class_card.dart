import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyClassCard extends StatelessWidget {
  const EmptyClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: theme.colorScheme.primary.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 16),
          SvgPicture.asset(AppAssets.empty),
          SizedBox(height: 16),
          Text(l10n.noClassesAvailable, style: theme.textTheme.bodyLarge),
          SizedBox(height: 16),
          Text(l10n.noClassesAvailableDescreption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
