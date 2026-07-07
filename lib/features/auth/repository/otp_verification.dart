import 'package:music_sync/features/auth/view_model/auth_view_model.dart';

abstract class OtpVerification {
  void verify(String otp);
}

class RegisterOtpVerification implements OtpVerification {
  final AuthViewModel vm;
  final String email;

  RegisterOtpVerification({required  this.vm,required  this.email});

  @override
  void verify(String otp) {
    return vm.verifyOtp(email, otp);
  }
}

class ForgotPasswordOtpVerification implements OtpVerification {
  final AuthViewModel vm;
  final String email;
  final String password;

  ForgotPasswordOtpVerification({required this.vm,required  this.email,required  this.password});

  @override
  void verify(String otp) {
    return vm.resetPassword(email, otp, password);
  }
}
