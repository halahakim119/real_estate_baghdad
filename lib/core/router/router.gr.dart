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
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

import '../../features/authentication/presentation/view/pages/forgot_password_screen.dart'
    as _i7;
import '../../features/authentication/presentation/view/pages/login_screen.dart'
    as _i4;
import '../../features/authentication/presentation/view/pages/reset_password_screen.dart'
    as _i9;
import '../../features/authentication/presentation/view/pages/signup_screen.dart'
    as _i6;
import '../../features/authentication/presentation/view/pages/verification_screen.dart'
    as _i8;
import '../../features/main/main_page.dart' as _i13;
import '../../features/map/view/map_screen.dart' as _i11;
import '../../features/posts/domain/entities/post_entity.dart' as _i19;
import '../../features/posts/home.dart' as _i14;
import '../../features/posts/presenation/view/pages/add_post_form.dart' as _i16;
import '../../features/posts/presenation/view/pages/user_posts_screen.dart'
    as _i12;
import '../../features/profile/Profile.dart' as _i15;
import '../../features/profile/settings.dart' as _i10;
import '../../features/splash/auth_first_install.dart' as _i3;
import '../../features/splash/first_install.dart' as _i2;
import '../../features/splash/splash.dart' as _i1;
import '../utils/auth_buttons.dart' as _i5;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstInstall(),
      );
    },
    AuthFirstInstallRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthFirstInstall(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    AuthButtonsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.AuthButtons(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SignupScreen(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>(
          orElse: () => const ForgotPasswordRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordScreen(key: args.key),
      );
    },
    VeificationRoute.name: (routeData) {
      final args = routeData.argsAs<VeificationRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.VeificationScreen(
          key: args.key,
          code: args.code,
          verificationCode: args.verificationCode,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.ResetPasswordScreen(
          key: args.key,
          verificationCode: args.verificationCode,
          code: args.code,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.Settings(),
      );
    },
    MapRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.MapScreen(),
      );
    },
    UserPostsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserPostsScreenRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.UserPostsScreen(posts: args.posts),
      );
    },
    MainRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.MainPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.Home(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.Profile(),
      );
    },
    AddPostFormRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.AddPostForm(),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i17.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i17.RouteConfig(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        ),
        _i17.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i17.RouteConfig(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        ),
        _i17.RouteConfig(
          SignupRoute.name,
          path: 'signup',
        ),
        _i17.RouteConfig(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
        ),
        _i17.RouteConfig(
          VeificationRoute.name,
          path: 'veification',
        ),
        _i17.RouteConfig(
          ResetPasswordRoute.name,
          path: 'resetPassword',
        ),
        _i17.RouteConfig(
          SettingsRoute.name,
          path: 'Settings',
        ),
        _i17.RouteConfig(
          MapRoute.name,
          path: 'MapScreen',
        ),
        _i17.RouteConfig(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
        ),
        _i17.RouteConfig(
          MainRoute.name,
          path: 'main',
          children: [
            _i17.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i17.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainRoute.name,
            ),
            _i17.RouteConfig(
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
class SplashRoute extends _i17.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.FirstInstall]
class AuthRoute extends _i17.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i3.AuthFirstInstall]
class AuthFirstInstallRoute extends _i17.PageRouteInfo<void> {
  const AuthFirstInstallRoute()
      : super(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        );

  static const String name = 'AuthFirstInstallRoute';
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.AuthButtons]
class AuthButtonsRoute extends _i17.PageRouteInfo<void> {
  const AuthButtonsRoute()
      : super(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        );

  static const String name = 'AuthButtonsRoute';
}

/// generated route for
/// [_i6.SignupScreen]
class SignupRoute extends _i17.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i17.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({_i18.Key? key})
      : super(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
          args: ForgotPasswordRouteArgs(key: key),
        );

  static const String name = 'ForgotPasswordRoute';
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.VeificationScreen]
class VeificationRoute extends _i17.PageRouteInfo<VeificationRouteArgs> {
  VeificationRoute({
    _i18.Key? key,
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

  final _i18.Key? key;

  final String code;

  final String verificationCode;

  @override
  String toString() {
    return 'VeificationRouteArgs{key: $key, code: $code, verificationCode: $verificationCode}';
  }
}

/// generated route for
/// [_i9.ResetPasswordScreen]
class ResetPasswordRoute extends _i17.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i18.Key? key,
    required String verificationCode,
    required String code,
  }) : super(
          ResetPasswordRoute.name,
          path: 'resetPassword',
          args: ResetPasswordRouteArgs(
            key: key,
            verificationCode: verificationCode,
            code: code,
          ),
        );

  static const String name = 'ResetPasswordRoute';
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.verificationCode,
    required this.code,
  });

  final _i18.Key? key;

  final String verificationCode;

  final String code;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, verificationCode: $verificationCode, code: $code}';
  }
}

/// generated route for
/// [_i10.Settings]
class SettingsRoute extends _i17.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'Settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i11.MapScreen]
class MapRoute extends _i17.PageRouteInfo<void> {
  const MapRoute()
      : super(
          MapRoute.name,
          path: 'MapScreen',
        );

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i12.UserPostsScreen]
class UserPostsScreenRoute
    extends _i17.PageRouteInfo<UserPostsScreenRouteArgs> {
  UserPostsScreenRoute({required List<_i19.PostEntity>? posts})
      : super(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
          args: UserPostsScreenRouteArgs(posts: posts),
        );

  static const String name = 'UserPostsScreenRoute';
}

class UserPostsScreenRouteArgs {
  const UserPostsScreenRouteArgs({required this.posts});

  final List<_i19.PostEntity>? posts;

  @override
  String toString() {
    return 'UserPostsScreenRouteArgs{posts: $posts}';
  }
}

/// generated route for
/// [_i13.MainPage]
class MainRoute extends _i17.PageRouteInfo<void> {
  const MainRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i14.Home]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i15.Profile]
class ProfileRoute extends _i17.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i16.AddPostForm]
class AddPostFormRoute extends _i17.PageRouteInfo<void> {
  const AddPostFormRoute()
      : super(
          AddPostFormRoute.name,
          path: 'add post form',
        );

  static const String name = 'AddPostFormRoute';
}
