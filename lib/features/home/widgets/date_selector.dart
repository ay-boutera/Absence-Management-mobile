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

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: _DayItem(date: date, isSelected: isSelected),
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
    final dayNumber = DateFormat('dd').format(date);
    final weekDay = DateFormat('EEE').format(date);
    final theme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            dayNumber,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : theme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            weekDay,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
