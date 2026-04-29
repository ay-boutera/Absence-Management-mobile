import 'package:abs/features/home/widgets/bottom_nav.dart';
import 'package:abs/features/home/widgets/class_card.dart';
import 'package:abs/features/home/widgets/date_selector.dart';
import 'package:abs/features/home/widgets/empty_class_card.dart';
import 'package:abs/features/home/widgets/header.dart';
import 'package:abs/features/home/widgets/timetable_card.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Widget> classesList = const [
    const ClassCard(
      title: "BDD",
      teacher: "Dr. Ammar Bensaber",
      room: "Salle 5 - sup",
      time: "09:30 - 11:00",
    ),

    const ClassCard(
      title: "Machine Learning",
      teacher: "Dr. Sami Khelifa",
      room: "Salle 2 - sup",
      time: "01:30 - 03:00",
    ),

    const ClassCard(
      title: "Machine Learning",
      teacher: "Dr. Sami Khelifa",
      room: "Salle 2 - sup",
      time: "01:30 - 03:00",
    ),
  ];

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
            const Header(),
            Divider(color: theme.colorScheme.outline.withValues(alpha: 0.1)),

            const SizedBox(height: 16),

            const DateSelector(),
            const SizedBox(height: 24),

            const TimetableCard(),

            const SizedBox(height: 16),

            Row(
              children: [
                Text(l10n.todayClasses, style: theme.textTheme.titleLarge),
                const SizedBox(width: 8),
                _badge(classesList.length),
              ],
            ),

            const SizedBox(height: 12),

            ...(classesList.isEmpty ? [EmptyClassCard()] : classesList),

            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  Widget _badge(int count) {
    return count == 0
        ? SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(count.toString()),
          );
  }
}
