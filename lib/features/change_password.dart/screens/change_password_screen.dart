import 'dart:convert';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/features/auth/widgets/input_field.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;
  bool _isChangingPassword = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  String? _validateNewPassword(String password, context) {
    final l10n = AppLocalizations.of(context);
    if (password.length < 8) return l10n.passwordMustBeAtLeast8Characters;
    if (!password.contains(RegExp(r'[A-Z]')))
      return l10n.passwordMustContainAtLeastOneUppercaseLetter;
    if (!password.contains(RegExp(r'[a-z]')))
      return l10n.passwordMustContainAtLeastOneLowercaseLetter;
    if (!password.contains(RegExp(r'[0-9]')))
      return l10n.passwordMustContainAtLeastOneNumber;
    if (!password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')))
      return l10n.passwordMustContainAtLeastOneSpecialCharacter;
    return null;
  }

  Future<void> _handleChangePassword() async {
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmNewPasswordController.text.trim();

    final l10n = AppLocalizations.of(context);

    // Basic empty check
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showDialog(l10n.pleaseFillInAllFields, isError: true);
      return;
    }

    // Validate new password strength
    final validationError = _validateNewPassword(newPassword, context);
    if (validationError != null) {
      _showDialog(validationError, isError: true);
      return;
    }

    // Confirm passwords match
    if (newPassword != confirmPassword) {
      _showDialog(l10n.newPasswordsDoNotMatch, isError: true);
      return;
    }

    setState(() => _isChangingPassword = true);

    try {
      const storage = FlutterSecureStorage();
      final token = (await storage.read(key: 'access_token'))?.trim();
      final refreshToken = await storage.read(key: 'refresh_token');
      final csrfToken = await storage.read(key: 'csrf_token');

      if (token == null) {
        _showDialog(l10n.noAccessTokenFound, isError: true);
        return;
      }

      final response = await http.post(
        Uri.parse(
          'https://absence-management-backend.onrender.com/api/v1/auth/change-password',
        ),
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'Cookie':
              'access_token=$token; refresh_token=$refreshToken; csrf_token=$csrfToken',
          'X-CSRF-Token': csrfToken ?? '',
        },
        body: jsonEncode({
          'current_password': oldPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        _showDialog(l10n.passwordChangedSuccessfully, isError: false);
        if (mounted) Navigator.of(context).pop();
      } else if (response.statusCode == 422) {
        _showDialog(l10n.invalidInputPleaseCheckYourFields, isError: true);
      } else {
        _showDialog(l10n.failedToChangePassword, isError: true);
      }
    } catch (e) {
      _showDialog(l10n.anErrorOccurred, isError: true);
    } finally {
      if (mounted) setState(() => _isChangingPassword = false);
    }
  }

  void _showDialog(String message, {required bool isError}) {
    final l10n = AppLocalizations.of(context);
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        icon: Icon(
          isError ? Icons.error_rounded : Icons.check_circle_rounded,
          color: isError ? Theme.of(context).colorScheme.error : Colors.green,
          size: 48,
        ),
        title: Text(
          isError ? l10n.error : l10n.success,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: isError
                  ? Theme.of(context).colorScheme.error
                  : Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                bottom: 24,
                left: 24,
                right: 24,
                top: 72,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  Text(
                    l10n.changePassword,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.enterYourInformation,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.currentPassword,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InputField(
                    controller: _oldPasswordController,
                    hintText: l10n.oldPasswordHint,
                    obscureText: _obscureOldPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureOldPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20,
                      ),
                      onPressed: () => setState(
                        () => _obscureOldPassword = !_obscureOldPassword,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.newPassword,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InputField(
                    controller: _newPasswordController,
                    hintText: l10n.newPasswordHint,
                    obscureText: _obscureNewPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20,
                      ),
                      onPressed: () => setState(
                        () => _obscureNewPassword = !_obscureNewPassword,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.confirmNewPassword,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InputField(
                    controller: _confirmNewPasswordController,
                    hintText: l10n.confirmPasswordHint,
                    obscureText: _obscureConfirmNewPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmNewPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20,
                      ),
                      onPressed: () => setState(
                        () => _obscureConfirmNewPassword =
                            !_obscureConfirmNewPassword,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isChangingPassword
                          ? null
                          : _handleChangePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        disabledBackgroundColor: colorScheme.primary.withValues(
                          alpha: 0.6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isChangingPassword
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              l10n.changePassword,
                              style: AppTextStyles.h2.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
