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
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
