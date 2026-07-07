import 'package:music_sync/features/auth/repository/otp_verification.dart';

class OtpArguments {
  final String email;
  final OtpVerification verification;

  const OtpArguments({
    required this.email,
    required this.verification,
  });
}