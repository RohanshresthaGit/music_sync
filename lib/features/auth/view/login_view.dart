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
import 'package:music_sync/features/auth/view_model/auth_state.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;
  late final ProviderSubscription _authListener;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _authListener = ref.listenManual(authViewModelProvider, (previous, next) {
      switch (next) {
        case LoginSuccess(:final data):
          context.go(RouteNames.homepage.homepage);
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
    _passwordController.dispose();
    _authListener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacing.vertical(24),
                Text('Welcome Back', style: context.textTheme.headlineLarge),
                const Spacing.vertical(8),
                Text(
                  'Login to continue listening to your favorite music.',
                  style: context.textTheme.bodyLarge,
                ),
                const Spacing.vertical(32),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  validator: Validators.combine([
                    Validators.required('Email'),
                    Validators.email(),
                  ]),
                ),
                const Spacing.vertical(16),
                AppTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  isObsecure: _isPasswordHidden,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  validator: Validators.combine([
                    Validators.required('Password'),
                    Validators.minLength(8),
                  ]),
                ),
                const Spacing.vertical(4),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => context.push(RouteNames.auth.forgotPassword),
                    child: Text(
                      'Forgot Password?',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const Spacing.vertical(24),
                PrimaryButton(
                  isLoading: authState is AuthLoading,
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    authViewModel.login(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    );
                  },
                  title: 'Login',
                  backgroundColor: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const Spacing.vertical(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: context.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(RouteNames.auth.register);
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
