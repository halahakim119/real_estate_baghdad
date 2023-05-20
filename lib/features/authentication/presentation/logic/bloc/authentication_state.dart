part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSignupFailure extends AuthenticationState {}

class VerifyPhoneNumber extends AuthenticationState {
  final String code;
  final String verificationCode;

  VerifyPhoneNumber({
    required this.code,
    required this.verificationCode,
  });
}

class VerifyPhoneNumberSuccess extends AuthenticationState {}

class VerifyPhoneNumberFailure extends AuthenticationState {}

class AuthenticationSigninSuccess extends AuthenticationState {
  final UserEntity userEntity;

  AuthenticationSigninSuccess({required this.userEntity});
}

class AuthenticationSigninFailure extends AuthenticationState {}

class ResetPasswordSuccess extends AuthenticationState {}

class ResetPasswordFailure extends AuthenticationState {}
