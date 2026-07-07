import 'package:equatable/equatable.dart';
import 'package:music_sync/features/auth/model/login_response_model.dart';
import 'package:music_sync/features/auth/model/register_response_model.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends AuthState {
  final RegisterResponseModel data;

  RegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class VerifyEmailSuccess extends AuthState {
  VerifyEmailSuccess();

  @override
  List<Object> get props => [];
}

class ResendOtpSuccess extends AuthState {
  ResendOtpSuccess();

  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthState {
  LoginSuccess(this.data);
  final LoginResponseModel data;
  @override
  List<Object> get props => [data];
}

class ForgotPasswordOtpSent extends AuthState {
  ForgotPasswordOtpSent();

  @override
  List<Object> get props => [];
}

class ResetPasswordSuccess extends AuthState {
  ResetPasswordSuccess();

  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
