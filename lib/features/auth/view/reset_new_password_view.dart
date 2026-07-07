import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';
import 'package:music_sync/core/common/components/app_textfield.dart';
import 'package:music_sync/core/common/components/primary_button.dart';
import 'package:music_sync/core/common/constants/padding_constants.dart';
import 'package:music_sync/core/common/constants/sizedbox_constants.dart';
import 'package:music_sync/core/extensions/build_context_extensions.dart';
import 'package:music_sync/core/utils/validators/validators.dart';
import 'package:music_sync/features/auth/di/auth_di.dart';
import 'package:music_sync/features/auth/model/otp_arguments.dart';
import 'package:music_sync/features/auth/repository/otp_verification.dart';

class ResetNewPasswordView extends ConsumerStatefulWidget {
  const ResetNewPasswordView({super.key, required this.email});
  final String email;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetNewPasswordViewState();
}

class _ResetNewPasswordViewState extends ConsumerState<ResetNewPasswordView> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final GlobalKey<FormState> _formKey;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create New Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: Paddings.kPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 46,
                backgroundColor: context.colorScheme.primary.withValues(
                  alpha: 0.1,
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  size: 44,
                  color: context.colorScheme.primary,
                ),
              ),
              Spacing.vertical(24),
              Text(
                "Set a new password",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacing.vertical(10),
              Text(
                "Choose a strong password to secure your account.",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Spacing.vertical(28),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: _passwordController,
                      hintText: "New Password",
                      prefixIcon: Icons.lock_outline,
                      isObsecure: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: Validators.combine([
                        Validators.required("Password"),
                        Validators.minLength(8),
                        Validators.strongPassword(),
                      ]),
                    ),
                    Spacing.vertical(16),
                    AppTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      prefixIcon: Icons.lock_outline,
                      isObsecure: _obscureConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      validator: Validators.combine([
                        Validators.required("Confirm password"),
                        Validators.match(() => _passwordController.text),
                      ]),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                title: "Continue",
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final args = OtpArguments(
                    email: widget.email,
                    verification: ForgotPasswordOtpVerification(
                      vm: ref.read(authViewModelProvider.notifier),
                      email: widget.email,
                      password: _passwordController.text.trim(),
                    ),
                  );
                  context.push(RouteNames.auth.verifyOtp, extra: args);
                },
              ),
              Spacing.vertical(20),
            ],
          ),
        ),
      ),
    );
  }
}
