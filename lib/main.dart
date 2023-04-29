import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/router/router.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter =  AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        routerDelegate: AutoRouterDelegate(_appRouter),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
