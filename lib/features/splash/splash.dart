import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/injection/injection_container.dart';
import '../../core/network/internet_checker.dart';
import '../../core/router/router.gr.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    sl<InternetChecker>().run();
    Future.delayed(const Duration(seconds: 2), () async {
      // checkFirstLaunch();
      context.router.push(const AuthRoute());
    });
  }

  void checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      context.router.push(const AuthRoute());
    } else {
      context.router.popAndPush(const MainRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 47, 103),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/house.png',
                  height: 160,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Text(
                  'Real Estate',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Lily_Script_One'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoSizeText {}
