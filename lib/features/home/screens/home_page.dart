import 'package:abs/core/entities/user_entity.dart';
import 'package:abs/features/home/cubit/home_cubit.dart';
import 'package:abs/features/home/widgets/bottom_nav.dart';
import 'package:abs/features/home/widgets/class_card.dart';
import 'package:abs/features/home/widgets/costum_badge.dart';
import 'package:abs/features/home/widgets/date_selector.dart';
import 'package:abs/features/home/widgets/empty_class_card.dart';
import 'package:abs/features/home/widgets/header.dart';
import 'package:abs/features/home/widgets/timetable_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: const BottomNav(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Header(user: user),
            Divider(color: theme.colorScheme.outline.withValues(alpha: 0.1)),

            const SizedBox(height: 16),

            const DateSelector(),
            const SizedBox(height: 24),

            const TimetableCard(),

            const SizedBox(height: 16),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedSuccess) {
                  if (state.sessions.isEmpty) {
                    return EmptyClassCard(isBorder: true);
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.todayClasses,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(width: 8),
                          CostumBadge(
                            count: state.sessions.length,
                            context: context,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      ...(state.sessions.map((session) {
                        return ClassCard(
                          title: session.subject,
                          teacher: session.teachers.isNotEmpty
                              ? '${session.teachers.first.firstName.toTitleCase()} ${session.teachers.first.lastName.toTitleCase()}'
                              : l10n.notRegistered,
                          room: session.room ?? l10n.notRegistered,
                          time: '${session.timeStart} - ${session.timeEnd}',
                        );
                      })),
                    ],
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                } else if (state is HomeLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

extension StringCapitalization on String {
  String toTitleCase() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
