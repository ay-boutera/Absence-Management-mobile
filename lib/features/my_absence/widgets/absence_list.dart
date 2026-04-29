import 'package:abs/core/entities/Absence_entity.dart';
import 'package:abs/features/my_absence/widgets/absence_list_item.dart';
import 'package:flutter/material.dart';

class AbsenceList extends StatelessWidget {
  final List<AbsenceItem> absences;

  const AbsenceList({super.key, required this.absences});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: absences.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return AbsenceListItem(absence: absences[index]);
      },
    );
  }
}
