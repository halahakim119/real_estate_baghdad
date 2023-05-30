import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/reset_password.dart';
import '../../features/authentication/domain/usecases/signin_with_phone.dart';
import '../../features/authentication/domain/usecases/signup_with_phone.dart';
import '../../features/authentication/domain/usecases/verify_phone_reset_password.dart';
import '../../features/authentication/domain/usecases/verify_phone_signup.dart';
import '../../features/authentication/presentation/logic/bloc/authentication_bloc.dart';
import '../../features/posts/map_screen.dart';
import '../../features/users/data/models/user_model.dart';
import '../../features/users/data/models/user_model_adapter.dart';
import '../network/internet_checker.dart';
import '../utils/api_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Get.put(LocationController());
  
  //! Initialize Hive
  await Hive.initFlutter();

  //! Register Hive Adapters
  sl.registerLazySingleton<Box<UserModel>>(
      () => Hive.box<UserModel>('userBox'));

  //! Register Hive Adapters
  Hive.registerAdapter<UserModel>(UserModelAdapter()); // Register the adapter

  //! Open the Hive box
  await Hive.openBox<UserModel>('userBox'); // Open the box before accessing it

  //! Internet Checker
  sl.registerLazySingleton(() => InternetChecker());

  //! API Provider
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  //! Authentication
  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(() =>
      AuthenticationRemoteDataSourceImpl(
          sl<ApiProvider>(), sl<Box<UserModel>>()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(
    () => AuthenticationBloc(
      signUpWithPhone: sl(),
      signInWithPhone: sl(),
      verifyPhoneSignUp: sl(),
      resetPassword: sl(),
      verifyPhoneResetPassword: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpWithPhone(sl()));
  sl.registerLazySingleton(() => SignInWithPhone(sl()));
  sl.registerLazySingleton(() => VerifyPhoneSignUp(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => VerifyPhoneResetPassword(sl()));
}
