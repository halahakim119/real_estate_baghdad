import 'package:bloc/bloc.dart';

import '../../../domain/usecases/reset_password.dart';
import '../../../domain/usecases/signin_with_phone.dart';
import '../../../domain/usecases/signup_with_phone.dart';
import '../../../domain/usecases/verify_phone_reset_password.dart';
import '../../../domain/usecases/verify_phone_signup.dart';

part 'aithentication_event.dart';
part 'aithentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpWithPhone signUpWithPhone;
  final SignInWithPhone signInWithPhone;
  final ResetPassword resetPassword;
  final VerifyPhoneSignUp verifyPhoneSignUp;
  final VerifyPhoneResetPassword verifyPhoneResetPassword;

  AuthenticationBloc(
      {required this.signInWithPhone,
      required this.resetPassword,
      required this.verifyPhoneSignUp,
      required this.verifyPhoneResetPassword,
      required this.signUpWithPhone})
      : super(AuthenticationInitial()) {
    on<SignUpWithPhoneRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await signUpWithPhone.call(
        name: event.name,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      result.fold(
          (failure) => emit(AuthenticationFailure(message: failure.toString())),
          (code) {
        (code) => emit(AuthenticationSuccess(code: code['code'],verificationCode: code['verificationCode']));
        emit(VerifyPhoneNumber(
            code: code['code']!, verificationCode: code['verificationCode']!));
      });
    });

    on<SignInWithPhoneRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await signInWithPhone.call(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      result.fold(
        (failure) => emit(AuthenticationFailure(message: failure.toString())),
        (code) => emit(AuthenticationSuccess(code: code.name,verificationCode: code.id)),
      );
    });

    on<VerifyPhoneSignUpRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await verifyPhoneSignUp.call(
        code: event.code,
        verificationCode: event.verificationCode,
      );
      result.fold(
        (failure) => emit(AuthenticationFailure(message: failure.toString())),
        (_) => emit(VerifyPhoneNumber(
            code: event.code, verificationCode: event.verificationCode)),
      );
    });

    // on<ResetPasswordRequested>((event, emit) async {
    //   emit(AuthenticationLoading());
    //   final result = await resetPassword.call(phoneNumber: event.phoneNumber);
    //   result.fold(
    //     (failure) => emit(AuthenticationFailure(message: failure.toString())),
    //     (success) => emit(VerifyPhoneNumber(code: s)),
    //   );
    // });

    on<VerifyPhoneResetPasswordRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await verifyPhoneResetPassword.call(
        code: event.code,
        verificationCode: event.verificationCode,
        newPassword: event.newPassword,
      );
      result.fold(
        (failure) => emit(AuthenticationFailure(message: failure.toString())),
        (success) => emit(AuthenticationSuccess(
            code: success.name, verificationCode: success.id)),
      );
    });
  }
}
