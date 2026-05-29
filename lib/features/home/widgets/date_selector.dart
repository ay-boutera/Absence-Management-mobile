import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime selectedDate;
  late List<DateTime> days;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();
    selectedDate = today;

    // Generate 7 days with TODAY in the middle (index 3)
    days = List.generate(7, (index) => today.add(Duration(days: index - 3)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((date) {
        final isSelected =
            date.day == selectedDate.day &&
            date.month == selectedDate.month &&
            date.year == selectedDate.year;

        // Wrap with Expanded so every day gets exactly 1/7th of the screen width
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: _DayItem(date: date, isSelected: isSelected),
          ),
        );
      }).toList(),
    );
  }
}

class _DayItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  const _DayItem({required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final locale = Localizations.localeOf(context).languageCode;

    final dayNumber = date.day.toString().padLeft(2, '0');
    final weekDay = DateFormat('EEE', locale).format(date);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        color: isSelected ? theme.primaryColor : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayNumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 4),

          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              weekDay,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.textTheme.bodySmall?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
