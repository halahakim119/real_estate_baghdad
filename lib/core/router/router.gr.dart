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
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;

import '../../features/authentication/presentation/view/pages/forgot_password_screen.dart'
    as _i6;
import '../../features/authentication/presentation/view/pages/login_screen.dart'
    as _i4;
import '../../features/authentication/presentation/view/pages/reset_password_screen.dart'
    as _i8;
import '../../features/authentication/presentation/view/pages/signup_screen.dart'
    as _i5;
import '../../features/authentication/presentation/view/pages/verification_screen.dart'
    as _i7;
import '../../features/main/main_page.dart' as _i11;
import '../../features/map/view/map_screen.dart' as _i10;
import '../../features/posts/feed_screen.dart' as _i12;
import '../../features/posts/home.dart' as _i13;
import '../../features/posts/presenation/view/pages/add_post_form.dart' as _i15;
import '../../features/profile/Profile.dart' as _i14;
import '../../features/profile/settings.dart' as _i9;
import '../../features/splash/auth_first_install.dart' as _i3;
import '../../features/splash/first_install.dart' as _i2;
import '../../features/splash/splash.dart' as _i1;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstInstall(),
      );
    },
    AuthFirstInstallRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthFirstInstall(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.LoginScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SignupScreen(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ForgotPasswordScreen(),
      );
    },
    VeificationRoute.name: (routeData) {
      final args = routeData.argsAs<VeificationRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.VeificationScreen(
          key: args.key,
          code: args.code,
          verificationCode: args.verificationCode,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.ResetPasswordScreen(
          verificationCode: args.verificationCode,
          code: args.code,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.Settings(),
      );
    },
    MapRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.MapScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.MainPage(),
      );
    },
    FeedRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.FeedScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.Home(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.Profile(),
      );
    },
    AddPostFormRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.AddPostForm(),
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i16.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i16.RouteConfig(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        ),
        _i16.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i16.RouteConfig(
          SignupRoute.name,
          path: 'signup',
        ),
        _i16.RouteConfig(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
        ),
        _i16.RouteConfig(
          VeificationRoute.name,
          path: 'veification',
        ),
        _i16.RouteConfig(
          ResetPasswordRoute.name,
          path: 'resetPassword',
        ),
        _i16.RouteConfig(
          SettingsRoute.name,
          path: 'Settings',
        ),
        _i16.RouteConfig(
          MapRoute.name,
          path: 'MapScreen',
        ),
        _i16.RouteConfig(
          MainRoute.name,
          path: 'main',
          children: [
            _i16.RouteConfig(
              FeedRoute.name,
              path: 'feed',
              parent: MainRoute.name,
            ),
            _i16.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i16.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainRoute.name,
            ),
            _i16.RouteConfig(
              AddPostFormRoute.name,
              path: 'add post form',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.Splash]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.FirstInstall]
class AuthRoute extends _i16.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i3.AuthFirstInstall]
class AuthFirstInstallRoute extends _i16.PageRouteInfo<void> {
  const AuthFirstInstallRoute()
      : super(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        );

  static const String name = 'AuthFirstInstallRoute';
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.SignupScreen]
class SignupRoute extends _i16.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i6.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
        );

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i7.VeificationScreen]
class VeificationRoute extends _i16.PageRouteInfo<VeificationRouteArgs> {
  VeificationRoute({
    _i17.Key? key,
    required String code,
    required String verificationCode,
  }) : super(
          VeificationRoute.name,
          path: 'veification',
          args: VeificationRouteArgs(
            key: key,
            code: code,
            verificationCode: verificationCode,
          ),
        );

  static const String name = 'VeificationRoute';
}

class VeificationRouteArgs {
  const VeificationRouteArgs({
    this.key,
    required this.code,
    required this.verificationCode,
  });

  final _i17.Key? key;

  final String code;

  final String verificationCode;

  @override
  String toString() {
    return 'VeificationRouteArgs{key: $key, code: $code, verificationCode: $verificationCode}';
  }
}

/// generated route for
/// [_i8.ResetPasswordScreen]
class ResetPasswordRoute extends _i16.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    required String verificationCode,
    required String code,
  }) : super(
          ResetPasswordRoute.name,
          path: 'resetPassword',
          args: ResetPasswordRouteArgs(
            verificationCode: verificationCode,
            code: code,
          ),
        );

  static const String name = 'ResetPasswordRoute';
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    required this.verificationCode,
    required this.code,
  });

  final String verificationCode;

  final String code;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{verificationCode: $verificationCode, code: $code}';
  }
}

/// generated route for
/// [_i9.Settings]
class SettingsRoute extends _i16.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'Settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i10.MapScreen]
class MapRoute extends _i16.PageRouteInfo<void> {
  const MapRoute()
      : super(
          MapRoute.name,
          path: 'MapScreen',
        );

  static const String name = ' MapRoute';
}

/// generated route for
/// [_i11.MainPage]
class MainRoute extends _i16.PageRouteInfo<void> {
  const MainRoute({List<_i16.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i12.FeedScreen]
class FeedRoute extends _i16.PageRouteInfo<void> {
  const FeedRoute()
      : super(
          FeedRoute.name,
          path: 'feed',
        );

  static const String name = 'FeedRoute';
}

/// generated route for
/// [_i13.Home]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i14.Profile]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i15.AddPostForm]
class AddPostFormRoute extends _i16.PageRouteInfo<void> {
  const AddPostFormRoute()
      : super(
          AddPostFormRoute.name,
          path: 'add post form',
        );

  static const String name = 'AddPostFormRoute';
}
