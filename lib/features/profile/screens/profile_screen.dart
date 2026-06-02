import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/core/helpers/get_year_helper.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/features/change_password.dart/screens/change_password_screen.dart';
import 'package:abs/features/profile/helpers/change_language_bottom_sheet.dart';
import 'package:abs/features/profile/helpers/change_theme_bottom_sheet.dart';
import 'package:abs/features/profile/screens/personel_info.dart';
import 'package:abs/features/profile/widgets/avatar.dart';
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
                      SectionTitle(title: l10n.operations),
                      CardGroup(
                        children: [
                          ListItem(
                            icon: Icons.person_outline,
                            title: l10n.myInformation,
                            hasChevron: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PersonelInfo(user: user),
                                ),
                              );
                            },
                          ),
                          CustomDivider(),
                          ListItem(
                            icon: Icons.calendar_month_outlined,
                            title: l10n.timeTable,
                            hasChevron: true,
                          ),

                          CustomDivider(),
                          ListItem(
                            icon: Icons.group_add,
                            title: l10n.attendanceWithAnotherGroup,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );
                            },
                            hasChevron: true,
                          ),
  
                          CustomDivider(),
                          ListItem(
                            icon: Icons.lock_outline,
                            title: l10n.changePassword,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );
                            },
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
                            onTap: () {
                              changeThemeBottomSheet(context);
                            },
                          ),
                          CustomDivider(),
                          ListItem(
                            icon: Icons.translate,
                            title: l10n.language,
                            hasChevron: true,
                            onTap: () {
                              changeLanguageBottomSheet(context);
                            },
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

          // Avatar overlapping the seam
          Positioned(
            top: topPadding + 80 - 44, // blue bar height minus half the avatar
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
