import 'dart:io';

import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploader extends StatefulWidget {
  // 1. Add the callback parameter here
  const DocumentUploader({super.key, required this.onFilePicked});

  final ValueChanged<String?> onFilePicked;

  @override
  State<DocumentUploader> createState() => _DocumentUploaderState();
}

class _DocumentUploaderState extends State<DocumentUploader> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // 2. Pass the selected path string to the parent page form state
      widget.onFilePicked(pickedFile.path);
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
    // 3. Inform the parent page that the file was removed
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
          onTap: _pickImage,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: _imageFile == null
                ? const EdgeInsets.symmetric(vertical: 24, horizontal: 8)
                : EdgeInsets.zero,
            decoration: containerDecoration,
            child: _imageFile == null
                ? _buildPlaceholder(l10n, theme)
                : _buildImagePreview(theme),
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
          l10n.fileFormatHint,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview(ThemeData theme) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            _imageFile!,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: _removeImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.8),
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
