import 'package:abs/config/constants/enums.dart';
import 'package:abs/features/absences/cubit/my_absence_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterTabs extends StatefulWidget {
  final List<String> labels;

  const FilterTabs({super.key, required this.labels});

  @override
  State<FilterTabs> createState() => _FilterTabsState();
}

class _FilterTabsState extends State<FilterTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      // 1. Wrap the Row in a SingleChildScrollView
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            widget.labels.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index);
                // Tip: Use 'index' directly here instead of 'selectedIndex' to avoid timing bugs
                context.read<MyAbsenceCubit>().filterAbsencesByState(
                  index == 0 ? null : AbsenceStatus.values[index - 1],
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                // 2. Added horizontal padding so the words have breathing room when scrolling
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(120),
                ),
                child: Text(
                  widget.labels[index],
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == index
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: selectedIndex == index
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
