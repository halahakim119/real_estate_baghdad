import 'package:bloc/bloc.dart';
import '../../../../users/domain/entities/user_entity.dart';

import '../../../domain/usecases/reset_password.dart';
import '../../../domain/usecases/signin_with_phone.dart';
import '../../../domain/usecases/signup_with_phone.dart';
import '../../../domain/usecases/verify_phone_reset_password.dart';
import '../../../domain/usecases/verify_phone_signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpWithPhone signUpWithPhone;
  final SignInWithPhone signInWithPhone;
  final ResetPassword resetPassword;
  final VerifyPhoneSignUp verifyPhoneSignUp;
  final VerifyPhoneResetPassword verifyPhoneResetPassword;

  AuthenticationBloc({
    required this.signUpWithPhone,
    required this.signInWithPhone,
    required this.resetPassword,
    required this.verifyPhoneSignUp,
    required this.verifyPhoneResetPassword,
  }) : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is SignUpWithPhoneRequested) {
      yield AuthenticationLoading();
      final result = await signUpWithPhone.call(
        name: event.name,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      yield* result.fold(
        (failure) async* {
          yield AuthenticationFailure(message: failure.toString());
        },
        (code) async* {
          yield VerifyPhoneNumber(
            code: code['code']!,
            verificationCode: code['verificationCode']!,
          );
        },
      );
    } else if (event is SignInWithPhoneRequested) {
      yield AuthenticationLoading();
      final result = await signInWithPhone.call(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      yield* result.fold(
        (failure) async* {
          yield AuthenticationFailure(message: failure.toString());
        },
        (userEntity) async* {
          yield AuthenticationSigninSuccess(userEntity: userEntity);
        },
      );
    } else if (event is VerifyPhoneSignUpRequested) {
      yield AuthenticationLoading();
      final result = await verifyPhoneSignUp.call(
        code: event.code,
        verificationCode: event.verificationCode,
      );
      yield* result.fold(
        (failure) async* {
          yield AuthenticationFailure(message: failure.toString());
        },
        (_) async* {
          yield VerifyPhoneNumberSuccess();
        },
      );
    } else if (event is ResetPasswordRequested) {
      yield AuthenticationLoading();
      final result = await resetPassword.call(phoneNumber: event.phoneNumber);
      yield* result.fold(
        (failure) async* {
          yield AuthenticationFailure(message: failure.toString());
        },
        (code) async* {
          yield VerifyPhoneNumber(
            code: code['code']!,
            verificationCode: code['verificationCode']!,
          );
        },
      );
    } else if (event is VerifyPhoneResetPasswordRequested) {
      yield AuthenticationLoading();
      final result = await verifyPhoneResetPassword.call(
        code: event.code,
        verificationCode: event.verificationCode,
        newPassword: event.newPassword,
      );
      yield* result.fold(
        (failure) async* {
          yield AuthenticationFailure(message: failure.toString());
        },
        (_) async* {
          yield VerifyPhoneNumberSuccess();
        },
      );
    }
  }
}
