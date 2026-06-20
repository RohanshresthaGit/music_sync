
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable{}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}


class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

    @override
  List<Object> get props => [message];
}

