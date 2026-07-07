import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_sync/config/router/route_names/route_names.dart';
import 'package:music_sync/core/common/components/primary_button.dart';
import 'package:music_sync/core/common/constants/padding_constants.dart';
import 'package:music_sync/core/common/constants/sizedbox_constants.dart';
import 'package:music_sync/core/extensions/build_context_extensions.dart';
import 'package:music_sync/features/auth/di/auth_di.dart';
import 'package:music_sync/features/auth/model/otp_arguments.dart';
import 'package:music_sync/features/auth/view_model/auth_state.dart';

class VerifyOtpView extends ConsumerStatefulWidget {
  final OtpArguments args;
  // final Future<void> Function(String email, String otp) onVerify;

  const VerifyOtpView({super.key, required this.args});

  @override
  ConsumerState<VerifyOtpView> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtpView>
    with WidgetsBindingObserver {
  final int length = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  final ValueNotifier<int> activeIndex = ValueNotifier(0);

  late final ProviderSubscription _authSubscription;
  Timer? _resendTimer;
  DateTime? _resendAvailableAt;
  Duration _remaining = Duration.zero;

  bool get _canResend => _remaining == Duration.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());

    focusNodes[0].requestFocus();

    _authSubscription = ref.listenManual(authViewModelProvider, (
      privious,
      next,
    ) {
      switch (next) {
        case VerifyEmailSuccess():
        case ResetPasswordSuccess():
          context.go(RouteNames.auth.login);
          break;
        case ResendOtpSuccess():
          context.showSuccessSnackBar('OTP resent successfully');
          break;
        case AuthFailure(message: final message):
          context.showErrorSnackBar(message);
          break;
      }
    });

    _startResendCountdown();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _updateRemaining();
    }
  }

  void _startResendCountdown() {
    _resendAvailableAt = DateTime.now().add(const Duration(minutes: 1));
    _updateRemaining();
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    final endAt = _resendAvailableAt;
    if (endAt == null) return;

    final remaining = endAt.difference(DateTime.now());
    if (remaining <= Duration.zero) {
      _resendTimer?.cancel();
      if (_remaining != Duration.zero) {
        setState(() {
          _remaining = Duration.zero;
        });
      }
      return;
    }
    setState(() {
      _remaining = remaining;
    });
  }

  void _onResendPressed() {
    if (!_canResend) return;
    ref.read(authViewModelProvider.notifier).resendOtp(widget.args.email);
    _startResendCountdown();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resendTimer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    activeIndex.dispose();
    _authSubscription.close();
    super.dispose();
  }

  String getOtp() => controllers.map((e) => e.text).join();

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget buildBox(int index) {
    return ValueListenableBuilder<int>(
      valueListenable: activeIndex,
      builder: (context, active, _) {
        final isActive = active == index;
        final hasValue = controllers[index].text.isNotEmpty;

        return AnimatedScale(
          duration: const Duration(milliseconds: 180),
          scale: isActive ? 1.05 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 45,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isActive
                    ? context.theme.primaryColor
                    : hasValue
                    ? Colors.green
                    : Colors.grey.shade400,
                width: 1.4,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: context.theme.primaryColor.withValues(
                          alpha: 0.35,
                        ),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 1,
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                // isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onTap: () {
                activeIndex.value = index;
              },

              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (index < length - 1) {
                    activeIndex.value = index + 1;
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                } else {
                  if (index > 0) {
                    activeIndex.value = index - 1;
                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                  }
                }

                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const Spacing.vertical(20),

            const Icon(Icons.email_outlined, size: 70, color: Colors.blue),

            const Spacing.vertical(12),

            Text("OTP sent to your email", style: context.textTheme.bodyMedium),

            const Spacing.vertical(8),

            Text(
              widget.args.email,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacing.vertical(32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: buildBox(index),
                ),
              ),
            ),

            const Spacing.vertical(24),

            Padding(
              padding: Paddings.kHorizontalPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _canResend ? _onResendPressed : null,
                      child: Text(
                        _canResend
                            ? 'Resend OTP'
                            : 'Resend in ${_formatDuration(_remaining)}',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: Paddings.kHorizontalPadding16,
              child: PrimaryButton(
                isLoading: state is AuthLoading,
                onPressed: () {
                  final otp = getOtp();
                  widget.args.verification.verify(otp);
                },
                title: "Verify",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
