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
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;

import '../../features/authentication/presentation/view/pages/forgot_password_screen.dart'
    as _i7;
import '../../features/authentication/presentation/view/pages/login_screen.dart'
    as _i4;
import '../../features/authentication/presentation/view/pages/reset_password_screen.dart'
    as _i10;
import '../../features/authentication/presentation/view/pages/signup_screen.dart'
    as _i6;
import '../../features/authentication/presentation/view/pages/verification_screen.dart'
    as _i8;
import '../../features/main/main_page.dart' as _i15;
import '../../features/map/view/map_screen.dart' as _i12;
import '../../features/posts/domain/entities/post_entity.dart' as _i21;
import '../../features/posts/home.dart' as _i16;
import '../../features/posts/presenation/view/pages/add_post_form.dart' as _i18;
import '../../features/posts/presenation/view/pages/post_details_screen.dart'
    as _i9;
import '../../features/posts/presenation/view/pages/user_posts_screen.dart'
    as _i13;
import '../../features/profile/edit_profile_screen.dart' as _i14;
import '../../features/profile/Profile.dart' as _i17;
import '../../features/profile/settings.dart' as _i11;
import '../../features/splash/auth_first_install.dart' as _i3;
import '../../features/splash/first_install.dart' as _i2;
import '../../features/splash/splash.dart' as _i1;
import '../utils/auth_buttons.dart' as _i5;

class AppRouter extends _i19.RootStackRouter {
  AppRouter([_i20.GlobalKey<_i20.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstInstall(),
      );
    },
    AuthFirstInstallRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthFirstInstall(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    AuthButtonsRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.AuthButtons(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SignupScreen(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>(
          orElse: () => const ForgotPasswordRouteArgs());
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordScreen(key: args.key),
      );
    },
    VeificationRoute.name: (routeData) {
      final args = routeData.argsAs<VeificationRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.VeificationScreen(
          key: args.key,
          code: args.code,
          verificationCode: args.verificationCode,
          typeForm: args.typeForm,
        ),
      );
    },
    PostDetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PostDetailsScreenRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.PostDetailsScreen(
          post: args.post,
          name: args.name,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ResetPasswordScreen(
          key: args.key,
          verificationCode: args.verificationCode,
          code: args.code,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.Settings(),
      );
    },
    MapRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.MapScreen(),
      );
    },
    UserPostsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserPostsScreenRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.UserPostsScreen(posts: args.posts),
      );
    },
    EditProfileScreenRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileScreenRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.EditProfileScreen(
          name: args.name,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.MainPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.Home(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.Profile(),
      );
    },
    AddPostFormRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.AddPostForm(),
      );
    },
  };

  @override
  List<_i19.RouteConfig> get routes => [
        _i19.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i19.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i19.RouteConfig(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        ),
        _i19.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i19.RouteConfig(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        ),
        _i19.RouteConfig(
          SignupRoute.name,
          path: 'signup',
        ),
        _i19.RouteConfig(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
        ),
        _i19.RouteConfig(
          VeificationRoute.name,
          path: 'veification',
        ),
        _i19.RouteConfig(
          PostDetailsScreenRoute.name,
          path: 'PostDetailsScreen',
        ),
        _i19.RouteConfig(
          ResetPasswordRoute.name,
          path: 'resetPassword',
        ),
        _i19.RouteConfig(
          SettingsRoute.name,
          path: 'Settings',
        ),
        _i19.RouteConfig(
          MapRoute.name,
          path: 'MapScreen',
        ),
        _i19.RouteConfig(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
        ),
        _i19.RouteConfig(
          EditProfileScreenRoute.name,
          path: 'EditProfileScreen',
        ),
        _i19.RouteConfig(
          MainRoute.name,
          path: 'main',
          children: [
            _i19.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i19.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainRoute.name,
            ),
            _i19.RouteConfig(
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
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.FirstInstall]
class AuthRoute extends _i19.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i3.AuthFirstInstall]
class AuthFirstInstallRoute extends _i19.PageRouteInfo<void> {
  const AuthFirstInstallRoute()
      : super(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        );

  static const String name = 'AuthFirstInstallRoute';
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i19.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.AuthButtons]
class AuthButtonsRoute extends _i19.PageRouteInfo<void> {
  const AuthButtonsRoute()
      : super(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        );

  static const String name = 'AuthButtonsRoute';
}

/// generated route for
/// [_i6.SignupScreen]
class SignupRoute extends _i19.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i19.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({_i20.Key? key})
      : super(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
          args: ForgotPasswordRouteArgs(key: key),
        );

  static const String name = 'ForgotPasswordRoute';
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.VeificationScreen]
class VeificationRoute extends _i19.PageRouteInfo<VeificationRouteArgs> {
  VeificationRoute({
    _i20.Key? key,
    required String code,
    required String verificationCode,
    String? typeForm,
  }) : super(
          VeificationRoute.name,
          path: 'veification',
          args: VeificationRouteArgs(
            key: key,
            code: code,
            verificationCode: verificationCode,
            typeForm: typeForm,
          ),
        );

  static const String name = 'VeificationRoute';
}

class VeificationRouteArgs {
  const VeificationRouteArgs({
    this.key,
    required this.code,
    required this.verificationCode,
    this.typeForm,
  });

  final _i20.Key? key;

  final String code;

  final String verificationCode;

  final String? typeForm;

  @override
  String toString() {
    return 'VeificationRouteArgs{key: $key, code: $code, verificationCode: $verificationCode, typeForm: $typeForm}';
  }
}

/// generated route for
/// [_i9.PostDetailsScreen]
class PostDetailsScreenRoute
    extends _i19.PageRouteInfo<PostDetailsScreenRouteArgs> {
  PostDetailsScreenRoute({
    required _i21.PostEntity post,
    required String name,
    required String phoneNumber,
  }) : super(
          PostDetailsScreenRoute.name,
          path: 'PostDetailsScreen',
          args: PostDetailsScreenRouteArgs(
            post: post,
            name: name,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'PostDetailsScreenRoute';
}

class PostDetailsScreenRouteArgs {
  const PostDetailsScreenRouteArgs({
    required this.post,
    required this.name,
    required this.phoneNumber,
  });

  final _i21.PostEntity post;

  final String name;

  final String phoneNumber;

  @override
  String toString() {
    return 'PostDetailsScreenRouteArgs{post: $post, name: $name, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordRoute extends _i19.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i20.Key? key,
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

  final _i20.Key? key;

  final String verificationCode;

  final String code;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, verificationCode: $verificationCode, code: $code}';
  }
}

/// generated route for
/// [_i11.Settings]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'Settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i12.MapScreen]
class MapRoute extends _i19.PageRouteInfo<void> {
  const MapRoute()
      : super(
          MapRoute.name,
          path: 'MapScreen',
        );

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i13.UserPostsScreen]
class UserPostsScreenRoute
    extends _i19.PageRouteInfo<UserPostsScreenRouteArgs> {
  UserPostsScreenRoute({required List<_i21.PostEntity>? posts})
      : super(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
          args: UserPostsScreenRouteArgs(posts: posts),
        );

  static const String name = 'UserPostsScreenRoute';
}

class UserPostsScreenRouteArgs {
  const UserPostsScreenRouteArgs({required this.posts});

  final List<_i21.PostEntity>? posts;

  @override
  String toString() {
    return 'UserPostsScreenRouteArgs{posts: $posts}';
  }
}

/// generated route for
/// [_i14.EditProfileScreen]
class EditProfileScreenRoute
    extends _i19.PageRouteInfo<EditProfileScreenRouteArgs> {
  EditProfileScreenRoute({
    required String name,
    required String phoneNumber,
  }) : super(
          EditProfileScreenRoute.name,
          path: 'EditProfileScreen',
          args: EditProfileScreenRouteArgs(
            name: name,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'EditProfileScreenRoute';
}

class EditProfileScreenRouteArgs {
  const EditProfileScreenRouteArgs({
    required this.name,
    required this.phoneNumber,
  });

  final String name;

  final String phoneNumber;

  @override
  String toString() {
    return 'EditProfileScreenRouteArgs{name: $name, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i15.MainPage]
class MainRoute extends _i19.PageRouteInfo<void> {
  const MainRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i16.Home]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i17.Profile]
class ProfileRoute extends _i19.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i18.AddPostForm]
class AddPostFormRoute extends _i19.PageRouteInfo<void> {
  const AddPostFormRoute()
      : super(
          AddPostFormRoute.name,
          path: 'add post form',
        );

  static const String name = 'AddPostFormRoute';
}
