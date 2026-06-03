import 'package:abs/features/qr_scanner/helpers/page_route_builder.dart';
import 'package:abs/features/qr_scanner/screens/qr_scanner_page.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ScannerErrorScreen extends StatelessWidget {
  const ScannerErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Visual Indicator (Icon with a soft background)
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(
                      alpha: 0.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 64,
                    color: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(height: 32),

                // 2. Clear Title
                Text(
                  'Scan Failed', // If you have a l10n key for this, use it here!
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),

                // 3. The Specific Error Message
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),

                // 4. Prominent, Touch-Friendly Action Button
                SizedBox(
                  width: double.infinity, // Spans the width for easier tapping
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        smoothRoute(page: const QRScannerScreen()),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(
                      l10n.ok,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
