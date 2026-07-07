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
import 'package:music_sync/features/auth/view_model/auth_state.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;
  late final ProviderSubscription _authListener;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _emailController = TextEditingController();

    _authListener = ref.listenManual(authViewModelProvider, (previous, next) {
      switch (next) {
        case ForgotPasswordOtpSent():
          context.push(
            RouteNames.auth.resetNewPassword,
            extra: _emailController.text.trim(),
          );
          break;
        case AuthFailure(:final message):
          context.showErrorSnackBar(message);
          break;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authListener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Forgot Password")),
      body: SafeArea(
        child: Padding(
          padding: Paddings.kPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Icon
              CircleAvatar(
                radius: 45,
                backgroundColor: context.colorScheme.primary.withValues(
                  alpha: .1,
                ),
                child: Icon(
                  Icons.lock_reset_rounded,
                  size: 45,
                  color: context.colorScheme.primary,
                ),
              ),

              Spacing.vertical(32),

              Text(
                "Forgot your password?",
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              Spacing.vertical(12),

              Text(
                "Enter your registered email address and we'll send you an OTP to reset your password.",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),

              Spacing.vertical(40),

              Form(
                key: _formKey,
                child: AppTextField(
                  controller: _emailController,
                  hintText: "Email Address",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.combine([
                    Validators.required("Email"),
                    Validators.email(),
                  ]),
                ),
              ),

              const Spacer(),

              PrimaryButton(
                isLoading: authState is AuthLoading,
                title: "Send OTP",
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  authViewModel.forgotPassword(_emailController.text.trim());
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
