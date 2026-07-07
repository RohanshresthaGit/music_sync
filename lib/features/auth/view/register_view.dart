import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';
import 'package:music_sync/core/common/components/app_textfield.dart';
import 'package:music_sync/core/common/components/primary_button.dart';
import 'package:music_sync/core/common/constants/sizedbox_constants.dart';
import 'package:music_sync/core/extensions/build_context_extensions.dart';
import 'package:music_sync/core/utils/validators/validators.dart';
import 'package:music_sync/features/auth/di/auth_di.dart';
import 'package:music_sync/features/auth/model/otp_arguments.dart';
import 'package:music_sync/features/auth/model/register_request_model.dart';
import 'package:music_sync/features/auth/repository/otp_verification.dart';
import 'package:music_sync/features/auth/view_model/auth_state.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmpasswordController;
  late final GlobalKey<FormState> _formKey;
  late final ProviderSubscription _authListener;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmpasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _authListener = ref.listenManual(authViewModelProvider, (previous, next) {
      switch (next) {
        case RegisterSuccess(data: final data):
          context.go(
            RouteNames.auth.verifyOtp,
            extra: OtpArguments(
              email: data.email,
              verification: RegisterOtpVerification(
                email: data.email,
                vm: ref.read(authViewModelProvider.notifier),
              ),
            ),
          );
          break;

        case AuthFailure(message: final message):
          context.showErrorSnackBar(message);
          break;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _authListener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final authState = ref.watch(authViewModelProvider);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.sizeOf(context).height * 0.3,
            16,
            16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Sign Up', style: context.textTheme.headlineLarge),
              Text(
                'Signup now to enjoy the music.',
                style: context.textTheme.bodyLarge,
              ),
              Spacing.vertical(32),
              AppTextField(
                controller: _emailController,
                hintText: "example@gmail.com",
                prefixIcon: Icons.email,
                validator: Validators.combine([
                  Validators.required('Email'),
                  Validators.email(),
                ]),
              ),
              Spacing.vertical(16),
              AppTextField(
                controller: _usernameController,
                hintText: "Enter your username",
                prefixIcon: Icons.person,
                validator: Validators.combine([
                  Validators.required('Username'),
                  Validators.minLength(3),
                  Validators.maxLength(30),
                ]),
              ),
              Spacing.vertical(16),
              AppTextField(
                controller: _passwordController,
                hintText: "Enter your password",
                prefixIcon: Icons.lock,
                validator: Validators.combine([
                  Validators.required('Password'),
                  Validators.minLength(8),
                  Validators.strongPassword(),
                ]),
              ),
              Spacing.vertical(16),
              AppTextField(
                controller: _confirmpasswordController,
                hintText: "Confirm your password",
                prefixIcon: Icons.lock,
                validator: Validators.combine([
                  Validators.match(() => _passwordController.text.trim()),
                ]),
              ),
              Spacing.vertical(32),
              PrimaryButton(
                isLoading: authState is AuthLoading,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  final loginPayload = RegiterRequestModel(
                    email: _emailController.text.trim(),
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                  );

                  authViewModel.register(loginPayload);
                },
                title: "Sign Up",
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
              Spacing.vertical(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.auth.login),
                    child: Text(
                      'Log In',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
