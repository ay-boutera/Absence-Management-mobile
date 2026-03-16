import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = false;

  Future<void> _handleLogin() async {
    if (_isSigningIn) return;

    setState(() => _isSigningIn = true);

    try {
      await context.read<AuthCubit>().login();
    } finally {
      if (mounted) {
        setState(() => _isSigningIn = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: screenHeight * 0.25,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.login,
              height: 450,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      l10n.signIn,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      AppAssets.logo,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    TextButton.icon(
                      onPressed: _isSigningIn ? null : _handleLogin,
                      icon: _isSigningIn
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Image.asset(
                              AppAssets.google,
                              height: 24,
                              width: 24,
                            ),
                      label: Text(
                        AppLocalizations.of(context).signIn,
                        style: AppTextStyles.h2,
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.brightness == Brightness.light
                            ? Colors.white
                            : theme.cardColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 35,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: theme.dividerColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
