// features/home/pages/home_page.dart

import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: "Schedule",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.check), label: "Attendance"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
      ],
    );
  }
}
