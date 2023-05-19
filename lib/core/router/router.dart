import 'package:auto_route/auto_route.dart';
import '../../features/authentication/presentation/view/pages/login_screen.dart';
import '../../features/authentication/presentation/view/pages/signup_screen.dart';
import '../../features/splash/first_install.dart';
import '../../features/splash/no_internet.dart';

import '../../features/main/main_page.dart';
import '../../features/posts/Profile.dart';
import '../../features/posts/feed.dart';
import '../../features/posts/home.dart';
import '../../features/splash/auth_first_install.dart';
import '../../features/splash/splash.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/',
      name: 'SplashRoute',
      page: Splash,
    ),
    AutoRoute(
      path: 'auth',
      name: 'AuthRoute',
      page: FirstInstall,
    ),
    AutoRoute(
      path: 'auth first install',
      name: 'AuthFirstInstallRoute',
      page: AuthFirstInstall,
    ),
    AutoRoute(
      path: 'login',
      name: 'LoginRoute',
      page: LoginScreen,
    ),
    AutoRoute(
      path: 'signup',
      name: 'SignupRoute',
      page: SignupScreen,
    ),
    AutoRoute(
      path: 'main',
      name: 'MainRoute',
      page: MainPage,
      children: [
        AutoRoute(
          path: 'feed',
          name: 'FeedRoute',
          page: Feed,
        ),
        AutoRoute(
          path: 'home',
          name: 'HomeRoute',
          page: Home,
        ),
        AutoRoute(
          path: 'profile',
          name: 'ProfileRoute',
          page: Profile,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
