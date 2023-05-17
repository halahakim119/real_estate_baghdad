part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({
    required this.message,
  });
}

class VerifyPhoneNumber extends AuthenticationState {
  final String code;
  final String verificationCode;

  VerifyPhoneNumber({
    required this.code,
    required this.verificationCode,
  });
}

class VerifyPhoneNumberSuccess extends AuthenticationState {}

class AuthenticationSigninSuccess extends AuthenticationState {
  final UserEntity userEntity;

  AuthenticationSigninSuccess({required this.userEntity});
}
