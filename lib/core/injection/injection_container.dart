import 'package:get_it/get_it.dart';

import '../network/internet_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //!internet Checker
  sl.registerLazySingleton(() => InternetChecker());
}
