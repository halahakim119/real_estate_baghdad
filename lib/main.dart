import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/injection/injection_container.dart';
import 'core/router/router.gr.dart';
import 'features/authentication/presentation/logic/bloc/authentication_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>(),
      child: OverlaySupport.global(
        child: MaterialApp.router(
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
