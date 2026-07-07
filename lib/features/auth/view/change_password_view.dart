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

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final GlobalKey<FormState> _formKey;

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (_, next) {
      if (next is ResetPasswordSuccess) {
        context.showSuccessSnackBar('Password changed successfully');
        context.go(RouteNames.auth.login);
      }
      if (next is AuthFailure) {
        context.showErrorSnackBar(next.message);
      }
    });

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Change Password')),
      body: SafeArea(
        child: Padding(
          padding: Paddings.kPadding16,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Spacing.vertical(24),
                CircleAvatar(
                  radius: 46,
                  backgroundColor: context.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  child: Icon(
                    Icons.lock_reset_rounded,
                    size: 44,
                    color: context.colorScheme.primary,
                  ),
                ),
                Spacing.vertical(20),
                Text(
                  'Set a new password',
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacing.vertical(8),
                Text(
                  'Use a strong password you have not used before.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Spacing.vertical(24),
                AppTextField(
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
                  prefixIcon: Icons.lock_outline,
                  isObsecure: _obscureCurrent,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureCurrent = !_obscureCurrent),
                    icon: Icon(
                      _obscureCurrent ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  validator: Validators.required('Current Password'),
                ),
                Spacing.vertical(16),
                AppTextField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  prefixIcon: Icons.lock_outline,
                  isObsecure: _obscureNew,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                    icon: Icon(
                      _obscureNew ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  validator: Validators.combine([
                    Validators.required('New Password'),
                    Validators.minLength(8),
                    Validators.strongPassword(),
                  ]),
                ),
                Spacing.vertical(16),
                AppTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm New Password',
                  prefixIcon: Icons.lock_outline,
                  isObsecure: _obscureConfirm,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  validator: Validators.combine([
                    Validators.required('Confirm Password'),
                    Validators.match(() => _newPasswordController.text),
                  ]),
                ),
                Spacing.vertical(32),
                PrimaryButton(
                  isLoading: authState is AuthLoading,
                  title: 'Update Password',
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    authViewModel.changePassword(
                      _currentPasswordController.text.trim(),
                      _newPasswordController.text.trim(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
