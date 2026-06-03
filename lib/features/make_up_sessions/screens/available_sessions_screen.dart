import 'package:abs/features/home/widgets/empty_class_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/features/make_up_sessions/cubit/available_sessions_cubit.dart';
import 'package:abs/features/make_up_sessions/widgets/module_card.dart';

class AvailableSessionsScreen extends StatelessWidget {
  const AvailableSessionsScreen({super.key, required this.moduleId});
  final String moduleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AvailableSessionsCubit()..getAvailableSessions(moduleId),
      child: AvailableSessionsView(moduleId: moduleId),
    );
  }
}

class AvailableSessionsView extends StatelessWidget {
  const AvailableSessionsView({super.key, required this.moduleId});
  final String moduleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AvailableSessionsCubit, AvailableSessionsState>(
        builder: (context, state) {
          if (state is AvailableSessionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AvailableSessionsError) {
            return Center(child: Text(state.message));
          } else if (state is AvailableSessionsLoaded) {
            if (state.sessions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [EmptyClassCard(isBorder: false)],
                ),
              );
            }
            return ListView.builder(
              itemCount: state.sessions.length,
              itemBuilder: (context, index) {
                final session = state.sessions[index];
                return ModuleCard(
                  moduleId: moduleId,
                  title: session.moduleName,
                  teacher: session.teacherName,
                  room: session.room,
                  time: session.date,
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
