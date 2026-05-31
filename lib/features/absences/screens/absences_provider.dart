import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsencesProvider extends StatelessWidget {
  const AbsencesProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAbsenceCubit()..getAbsences(),
      child: child,
    );
  }
}
