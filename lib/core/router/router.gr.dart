// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../features/authentication/presentation/view/pages/login_screen.dart'
    as _i4;
import '../../features/authentication/presentation/view/pages/signup_screen.dart'
    as _i5;
import '../../features/main/main_page.dart' as _i6;
import '../../features/posts/feed.dart' as _i7;
import '../../features/posts/home.dart' as _i8;
import '../../features/posts/Profile.dart' as _i9;
import '../../features/splash/auth_first_install.dart' as _i3;
import '../../features/splash/first_install.dart' as _i2;
import '../../features/splash/splash.dart' as _i1;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstInstall(),
      );
    },
    AuthFirstInstallRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthFirstInstall(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SignupScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.MainPage(),
      );
    },
    FeedRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.Feed(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.Home(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.Profile(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i10.RouteConfig(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i10.RouteConfig(
          SignupRoute.name,
          path: 'signup',
        ),
        _i10.RouteConfig(
          MainRoute.name,
          path: 'main',
          children: [
            _i10.RouteConfig(
              FeedRoute.name,
              path: 'feed',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i10.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.Splash]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.FirstInstall]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i3.AuthFirstInstall]
class AuthFirstInstallRoute extends _i10.PageRouteInfo<void> {
  const AuthFirstInstallRoute()
      : super(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        );

  static const String name = 'AuthFirstInstallRoute';
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.SignupScreen]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i6.MainPage]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i7.Feed]
class FeedRoute extends _i10.PageRouteInfo<void> {
  const FeedRoute()
      : super(
          FeedRoute.name,
          path: 'feed',
        );

  static const String name = 'FeedRoute';
}

/// generated route for
/// [_i8.Home]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i9.Profile]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}
