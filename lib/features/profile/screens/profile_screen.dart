import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/features/profile/widgets/card_group.dart';
import 'package:abs/features/profile/widgets/costum_header.dart';
import 'package:abs/features/profile/widgets/custom_divider.dart';
import 'package:abs/features/profile/widgets/list_item.dart';
import 'package:abs/features/profile/widgets/section_title.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navBarHeight = kBottomNavigationBarHeight + bottomPadding + 20;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        children: [
          // Blue header with avatar
          CostumHeader(user: user, theme: theme, bottomPadding: bottomPadding),

          // White content area
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
              child: ListView(
                padding: EdgeInsets.fromLTRB(24, 24, 24, navBarHeight),
                children: [
                  // Profile name & info
                  Center(
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: AppTextStyles.h2.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      user.email,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  if (user.studentId != null || user.level != null) ...[
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        [
                          if (user.studentId != null) user.studentId!,
                          if (user.program != null) user.program!,
                          if (user.level != null) user.level!,
                          if (user.group != null) user.group!,
                        ].join(' · '),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),

                  // --- Operations Section ---
                  SectionTitle(title: l10n.operations),
                  CardGroup(
                    children: [
                      ListItem(
                        icon: Icons.person_outline,
                        title: l10n.myInformation,
                        hasChevron: true,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.calendar_month_outlined,
                        title: l10n.timeTable,
                        hasChevron: true,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.assignment_outlined,
                        title: l10n.examsSchedule,
                        hasChevron: true,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.insert_chart_outlined,
                        title: l10n.attendancePerformance,
                        hasChevron: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Account Section ---
                  SectionTitle(title: l10n.preferences),
                  CardGroup(
                    children: [
                      ListItem(
                        icon: Icons.mode_night_outlined,
                        title: l10n.theme,
                        hasChevron: true,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.translate,
                        title: l10n.language,
                        hasChevron: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Contact ESI Section ---
                  SectionTitle(title: l10n.contactEsi),
                  CardGroup(
                    children: [
                      ListItem(
                        icon: Icons.phone_outlined,
                        title: '${l10n.contact}: +213 48 74 94 52',
                        hasChevron: false,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.email_outlined,
                        title: '${l10n.email}: info@esi-sba.dz',
                        hasChevron: false,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.language_outlined,
                        title: '${l10n.website}: www.esi-sba.dz',
                        hasChevron: false,
                      ),
                      CustomDivider(),
                      ListItem(
                        icon: Icons.location_on_outlined,
                        title:
                            '${l10n.address}: 123 Avenue de l\'Indépendance, Sidi Bel Abbes',
                        hasChevron: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // --- Log Out Button ---
                  OutlinedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: theme.scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: theme.dividerColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      l10n.logOut,
                      style: AppTextStyles.h3.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
