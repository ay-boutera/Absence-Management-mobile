import 'package:abs/features/attendance/widgets/semester_tab_item.dart';
import 'package:flutter/material.dart';

class SemesterTab extends StatelessWidget {
  const SemesterTab({
    super.key,
    required this.label1,
    required this.label2,
    required this.selectedIndex,
    required this.onChanged,
  });

  final String label1;
  final String label2;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 44,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SemesterTabItem(
            label: label1,
            isSelected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
          SemesterTabItem(
            label: label2,
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}
