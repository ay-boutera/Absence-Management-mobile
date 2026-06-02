import 'dart:io';

import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentUploader extends StatefulWidget {
  const DocumentUploader({super.key, required this.onFilePicked});

  final ValueChanged<String?> onFilePicked;

  @override
  State<DocumentUploader> createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null || result.files.single.path == null) {
      return;
    }

    setState(() {
      _selectedFile = File(result.files.single.path!);
      _fileName = result.files.single.name;
    });

    widget.onFilePicked(result.files.single.path);
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });

    widget.onFilePicked(null);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final containerDecoration = BoxDecoration(
      color: theme.colorScheme.surface.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: theme.colorScheme.outlineVariant),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.evidenceDocumentLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _pickFile,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: _selectedFile == null
                ? const EdgeInsets.symmetric(vertical: 24, horizontal: 8)
                : EdgeInsets.zero,
            decoration: containerDecoration,
            child: _selectedFile == null
                ? _buildPlaceholder(l10n, theme)
                : _buildFilePreview(theme),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder(AppLocalizations l10n, ThemeData theme) {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.upload, width: 32, height: 32),
        const SizedBox(height: 12),
        Text(
          l10n.clickToUpload,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PDF only • Max 5 MB',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFilePreview(ThemeData theme) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.picture_as_pdf_rounded,
                size: 40,
                color: Colors.red,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _fileName ?? 'PDF Document',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: _removeFile,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
