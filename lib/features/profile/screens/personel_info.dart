import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/core/helpers/get_year_helper.dart';
import 'package:abs/features/profile/widgets/avatar.dart';
import 'package:abs/features/profile/widgets/card_group.dart';
import 'package:abs/features/profile/widgets/costum_header.dart';
import 'package:abs/features/profile/widgets/custom_divider.dart';
import 'package:abs/features/profile/widgets/list_item.dart';
import 'package:abs/features/profile/widgets/section_title.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PersonelInfo extends StatelessWidget {
  const PersonelInfo({super.key, required this.user});

  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navBarHeight = kBottomNavigationBarHeight + bottomPadding + 20;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Blue header with avatar
              CostumHeader(user: user),

              // White content area
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                          "${getYearHelper(user.level)} Student",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // --- Operations Section ---
                      SectionTitle(title: l10n.myInfo),
                      CardGroup(
                        children: [
                          ListItem(
                            icon: Icons.message,
                            title: user.email,
                            hasChevron: false,
                          ),
                          CustomDivider(),
                          ListItem(
                            icon: Icons.school,
                            title: "${l10n.matriculeLabel} : ${user.studentId}",
                            hasChevron: false,
                          ),
                          CustomDivider(),
                          ListItem(
                            icon: Icons.group_outlined,
                            title: "${user.level} - ${getGroup(user.group)}",
                            hasChevron: false,
                          ),
                          CustomDivider(),
                          ListItem(
                            icon: Icons.pin_drop_outlined,
                            title: l10n.schoolAddress,
                            hasChevron: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: topPadding + 80 - 44,
            left: 0,
            right: 0,
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
          ),
        ],
      ),
    );
  }
}

String getGroup(String group) {
  return group;
}
