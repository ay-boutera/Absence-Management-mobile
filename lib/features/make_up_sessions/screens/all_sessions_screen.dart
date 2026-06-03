import 'package:abs/features/home/cubit/home_cubit.dart';
import 'package:abs/features/home/screens/home_page.dart';
import 'package:abs/features/home/widgets/empty_class_card.dart';
import 'package:abs/features/make_up_sessions/widgets/module_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSessionsScreen extends StatelessWidget {
  const AllSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedSuccess) {
                  final allModules = context
                      .read<HomeCubit>()
                      .allSessions
                      .where((session) {
                        return (session.type == 'Cours');
                      })
                      .toList();

                  if (allModules.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [EmptyClassCard(isBorder: false)],
                    );
                  }
                  return Column(
                    children: [
                      const SizedBox(height: 36),

                      ...(allModules.map((session) {
                        return ModuleCard(
                          moduleId: session.moduleId,
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
          ),
        ),
      ),
    );
  }
}
