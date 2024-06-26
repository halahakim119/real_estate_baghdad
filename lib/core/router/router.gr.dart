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
import 'package:auto_route/auto_route.dart' as _i20;
import 'package:flutter/material.dart' as _i21;

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
import '../../features/main/main_page.dart' as _i16;
import '../../features/map/view/map_screen.dart' as _i12;
import '../../features/posts/domain/entities/post_entity.dart' as _i22;
import '../../features/posts/home.dart' as _i17;
import '../../features/posts/presenation/view/pages/add_post_form.dart' as _i19;
import '../../features/posts/presenation/view/pages/edit_post_form.dart'
    as _i15;
import '../../features/posts/presenation/view/pages/post_details_screen.dart'
    as _i9;
import '../../features/posts/presenation/view/pages/user_posts_screen.dart'
    as _i13;
import '../../features/profile/edit_profile_screen.dart' as _i14;
import '../../features/profile/Profile.dart' as _i18;
import '../../features/profile/settings.dart' as _i11;
import '../../features/splash/auth_first_install.dart' as _i3;
import '../../features/splash/first_install.dart' as _i2;
import '../../features/splash/splash.dart' as _i1;
import '../utils/auth_buttons.dart' as _i5;

class AppRouter extends _i20.RootStackRouter {
  AppRouter([_i21.GlobalKey<_i21.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Splash(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstInstall(),
      );
    },
    AuthFirstInstallRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthFirstInstall(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.LoginScreen(),
      );
    },
    AuthButtonsRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.AuthButtons(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SignupScreen(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>(
          orElse: () => const ForgotPasswordRouteArgs());
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ForgotPasswordScreen(key: args.key),
      );
    },
    VeificationRoute.name: (routeData) {
      final args = routeData.argsAs<VeificationRouteArgs>();
      return _i20.MaterialPageX<dynamic>(
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
      return _i20.MaterialPageX<dynamic>(
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
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ResetPasswordScreen(
          key: args.key,
          verificationCode: args.verificationCode,
          code: args.code,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.Settings(),
      );
    },
    MapRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.MapScreen(),
      );
    },
    UserPostsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<UserPostsScreenRouteArgs>(
          orElse: () => const UserPostsScreenRouteArgs());
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.UserPostsScreen(posts: args.posts),
      );
    },
    EditProfileScreenRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.EditProfileScreen(),
      );
    },
    EditPostFormRoute.name: (routeData) {
      final args = routeData.argsAs<EditPostFormRouteArgs>();
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.EditPostForm(
          key: args.key,
          post: args.post,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.MainPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.Home(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.Profile(),
      );
    },
    AddPostFormRoute.name: (routeData) {
      return _i20.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.AddPostForm(),
      );
    },
  };

  @override
  List<_i20.RouteConfig> get routes => [
        _i20.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i20.RouteConfig(
          AuthRoute.name,
          path: 'auth',
        ),
        _i20.RouteConfig(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        ),
        _i20.RouteConfig(
          LoginRoute.name,
          path: 'login',
        ),
        _i20.RouteConfig(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        ),
        _i20.RouteConfig(
          SignupRoute.name,
          path: 'signup',
        ),
        _i20.RouteConfig(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
        ),
        _i20.RouteConfig(
          VeificationRoute.name,
          path: 'veification',
        ),
        _i20.RouteConfig(
          PostDetailsScreenRoute.name,
          path: 'PostDetailsScreen',
        ),
        _i20.RouteConfig(
          ResetPasswordRoute.name,
          path: 'resetPassword',
        ),
        _i20.RouteConfig(
          SettingsRoute.name,
          path: 'Settings',
        ),
        _i20.RouteConfig(
          MapRoute.name,
          path: 'MapScreen',
        ),
        _i20.RouteConfig(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
        ),
        _i20.RouteConfig(
          EditProfileScreenRoute.name,
          path: 'EditProfileScreen',
        ),
        _i20.RouteConfig(
          EditPostFormRoute.name,
          path: 'EditPostForm',
        ),
        _i20.RouteConfig(
          MainRoute.name,
          path: 'main',
          children: [
            _i20.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i20.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: MainRoute.name,
            ),
            _i20.RouteConfig(
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
class SplashRoute extends _i20.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.FirstInstall]
class AuthRoute extends _i20.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i3.AuthFirstInstall]
class AuthFirstInstallRoute extends _i20.PageRouteInfo<void> {
  const AuthFirstInstallRoute()
      : super(
          AuthFirstInstallRoute.name,
          path: 'auth first install',
        );

  static const String name = 'AuthFirstInstallRoute';
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.AuthButtons]
class AuthButtonsRoute extends _i20.PageRouteInfo<void> {
  const AuthButtonsRoute()
      : super(
          AuthButtonsRoute.name,
          path: 'AuthButtons',
        );

  static const String name = 'AuthButtonsRoute';
}

/// generated route for
/// [_i6.SignupScreen]
class SignupRoute extends _i20.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i7.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i20.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({_i21.Key? key})
      : super(
          ForgotPasswordRoute.name,
          path: 'forgotPassword',
          args: ForgotPasswordRouteArgs(key: key),
        );

  static const String name = 'ForgotPasswordRoute';
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final _i21.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.VeificationScreen]
class VeificationRoute extends _i20.PageRouteInfo<VeificationRouteArgs> {
  VeificationRoute({
    _i21.Key? key,
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

  final _i21.Key? key;

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
    extends _i20.PageRouteInfo<PostDetailsScreenRouteArgs> {
  PostDetailsScreenRoute({
    required _i22.PostEntity post,
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

  final _i22.PostEntity post;

  final String name;

  final String phoneNumber;

  @override
  String toString() {
    return 'PostDetailsScreenRouteArgs{post: $post, name: $name, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordRoute extends _i20.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i21.Key? key,
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

  final _i21.Key? key;

  final String verificationCode;

  final String code;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, verificationCode: $verificationCode, code: $code}';
  }
}

/// generated route for
/// [_i11.Settings]
class SettingsRoute extends _i20.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'Settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i12.MapScreen]
class MapRoute extends _i20.PageRouteInfo<void> {
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
    extends _i20.PageRouteInfo<UserPostsScreenRouteArgs> {
  UserPostsScreenRoute({List<_i22.PostEntity>? posts})
      : super(
          UserPostsScreenRoute.name,
          path: 'UserPostsScreen',
          args: UserPostsScreenRouteArgs(posts: posts),
        );

  static const String name = 'UserPostsScreenRoute';
}

class UserPostsScreenRouteArgs {
  const UserPostsScreenRouteArgs({this.posts});

  final List<_i22.PostEntity>? posts;

  @override
  String toString() {
    return 'UserPostsScreenRouteArgs{posts: $posts}';
  }
}

/// generated route for
/// [_i14.EditProfileScreen]
class EditProfileScreenRoute extends _i20.PageRouteInfo<void> {
  const EditProfileScreenRoute()
      : super(
          EditProfileScreenRoute.name,
          path: 'EditProfileScreen',
        );

  static const String name = 'EditProfileScreenRoute';
}

/// generated route for
/// [_i15.EditPostForm]
class EditPostFormRoute extends _i20.PageRouteInfo<EditPostFormRouteArgs> {
  EditPostFormRoute({
    _i21.Key? key,
    required _i22.PostEntity post,
  }) : super(
          EditPostFormRoute.name,
          path: 'EditPostForm',
          args: EditPostFormRouteArgs(
            key: key,
            post: post,
          ),
        );

  static const String name = 'EditPostFormRoute';
}

class EditPostFormRouteArgs {
  const EditPostFormRouteArgs({
    this.key,
    required this.post,
  });

  final _i21.Key? key;

  final _i22.PostEntity post;

  @override
  String toString() {
    return 'EditPostFormRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i16.MainPage]
class MainRoute extends _i20.PageRouteInfo<void> {
  const MainRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: 'main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i17.Home]
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i18.Profile]
class ProfileRoute extends _i20.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i19.AddPostForm]
class AddPostFormRoute extends _i20.PageRouteInfo<void> {
  const AddPostFormRoute()
      : super(
          AddPostFormRoute.name,
          path: 'add post form',
        );

  static const String name = 'AddPostFormRoute';
}
