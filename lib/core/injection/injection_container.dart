import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../features/users/data/datasource/user_data_source.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/domain/usecases/user_crud_use_cases.dart';
import '../../features/users/presentation/logic/bloc/user_bloc.dart';

import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/reset_password.dart';
import '../../features/authentication/domain/usecases/signin_with_phone.dart';
import '../../features/authentication/domain/usecases/signup_with_phone.dart';
import '../../features/authentication/domain/usecases/verify_phone_reset_password.dart';
import '../../features/authentication/domain/usecases/verify_phone_signup.dart';
import '../../features/authentication/presentation/logic/bloc/authentication_bloc.dart';
import '../../features/posts/data/datasource/post_data_source.dart';
import '../../features/map/controller/location_controller.dart';
import '../../features/posts/data/models/post_model.dart';
import '../../features/posts/data/models/post_model_adapter.dart';
import '../../features/posts/data/repository/post_repository_impl.dart';
import '../../features/posts/domain/repositories/post_repository.dart';
import '../../features/posts/domain/usecases/create_post_use_case.dart';
import '../../features/posts/domain/usecases/delete_post_use_case.dart';
import '../../features/posts/domain/usecases/get_post_by_id_use_case.dart';
import '../../features/posts/domain/usecases/update_post_use_case.dart';
import '../../features/posts/presenation/logic/bloc/add_edit_delete_post_bloc.dart';
import '../../features/posts/presenation/logic/cubit/add_edit_delete_post_cubit.dart';
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
  sl.registerLazySingleton<Box<Map<String, dynamic>>>(
      () => Hive.box<Map<String, dynamic>>('infoBox'));
 

  //! Register Hive Adapters
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<PostModel>(PostModelAdapter());

  //! Open the Hive box
  await Hive.openBox<UserModel>('userBox'); // Open the box before accessing it

  //! Open the Hive box
  await Hive.openBox<Map<String, dynamic>>(
      'infoBox'); // Open the box before accessing it

  //! Internet Checker
  sl.registerLazySingleton(() => InternetChecker());

  //! API Provider
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  //! Authentication
  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
            sl<ApiProvider>(),
            sl<Box<UserModel>>(),
            sl<Box<Map<String, dynamic>>>(),
          ),
  );

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

  //! post
  // Data sources
  sl.registerLazySingleton<PostDataSource>(() => PostDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(postDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(
    () => AddEditDeletePostBloc(
        createPostUseCase: sl(),
        deletePostUseCase: sl(),
        getPostByIdUseCase: sl(),
        updatePostUseCase: sl()),
  );

  // BLoC
  sl.registerFactory(
    () => AddEditDeletePostCubit(
      createPostUseCase: sl(),
      deletePostUseCase: sl(),
      getPostByIdUseCase: sl(),
      updatePostUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => CreatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => GetPostByIdUseCase(sl()));

    //! user
  // Data sources
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
    sl<Box<UserModel>>(),
    sl<Box<Map<String, dynamic>>>(),
    sl<AuthenticationRemoteDataSource>(), // Add this line
  ));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(() => UserBloc(
        deleteUserUseCase: sl(),
        editUserUseCase: sl(),
        getUserUseCase: sl(),
        updatePhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
}
