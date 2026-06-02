import 'package:abs/features/qr_scanner/helpers/page_route_builder.dart';
import 'package:abs/features/qr_scanner/screens/qr_scanner_page.dart';
import 'package:flutter/material.dart';

class ScannerErrorScreen extends StatelessWidget {
  const ScannerErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  smoothRoute(page: const QRScannerScreen()),
                );
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
