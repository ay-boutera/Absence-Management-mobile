// features/home/pages/home_page.dart

import 'package:flutter/material.dart';

class WarningBanner extends StatelessWidget {
  final String text;

  const WarningBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
          const Icon(Icons.close),
        ],
      ),
    );
  }
}
