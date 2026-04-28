import 'package:abs/config/constants/app_assets.dart';
import 'package:abs/config/theme/app_text_styles.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/features/auth/widgets/input_field.dart';
import 'package:abs/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigningIn = false;
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isSigningIn) return;
    setState(() => _isSigningIn = true);
    try {
      await context.read<AuthCubit>().login();
    } finally {
      if (mounted) setState(() => _isSigningIn = false);
    }
  }

  Future<void> _handleGoogleLogin() async {
    if (_isSigningIn) return;
    setState(() => _isSigningIn = true);
    try {
      await context.read<AuthCubit>().login();
    } finally {
      if (mounted) setState(() => _isSigningIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.primary,
      body: Column(
        children: [
          // ── Top section: logo/branding ──────────────────────────────
          Expanded(
            flex: 2,
            child: Center(
              child: SvgPicture.asset(
                AppAssets.logo,
                height: screenHeight * 0.18,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // ── Bottom card ─────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    l10n.signIn,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    l10n.signInSubtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Email field
                  InputField(
                    controller: _emailController,
                    hintText: l10n.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: null,
                  ),
                  const SizedBox(height: 14),

                  // Password field
                  InputField(
                    controller: _passwordController,
                    hintText: l10n.passwordHint,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Remember me + Forgot password
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (v) =>
                              setState(() => _rememberMe = v ?? false),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(
                            color: colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.rememberMe,
                        style: AppTextStyles.body.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: navigate to forgot password
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          l10n.forgotPassword,
                          style: AppTextStyles.body.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Log In button
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: _isSigningIn ? null : _handleLogin,
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
                      child: _isSigningIn
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              l10n.logIn,
                              style: AppTextStyles.h2.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Divider "Or log in with"
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorScheme.onSurface.withValues(alpha: 0.15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          l10n.orLogInWith,
                          style: AppTextStyles.body.copyWith(
                            color: colorScheme.onSurface.withValues(
                              alpha: 0.45,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: colorScheme.onSurface.withValues(alpha: 0.15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Google Auth button
                  SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: _isSigningIn ? null : _handleGoogleLogin,
                      icon: Image.asset(
                        AppAssets.google,
                        height: 22,
                        width: 22,
                      ),
                      label: Text(
                        l10n.googleAuth,
                        style: AppTextStyles.h2.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: colorScheme.onSurface.withValues(alpha: 0.2),
                        ),
                        backgroundColor: theme.brightness == Brightness.light
                            ? Colors.white
                            : theme.cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
