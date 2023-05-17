part of 'aithentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String code;
  final String verificationCode;

  AuthenticationSuccess({required this.code, required this.verificationCode});
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({required this.message});
}

class VerifyPhoneNumber extends AuthenticationState {
  final String code;
  final String verificationCode;

  VerifyPhoneNumber({required this.code, required this.verificationCode});
}
