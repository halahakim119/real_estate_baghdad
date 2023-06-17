import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';
import '../../core/utils/auth_buttons.dart';

class AuthFirstInstall extends StatefulWidget {
  const AuthFirstInstall({Key? key}) : super(key: key);

  @override
  State<AuthFirstInstall> createState() => _AuthFirstInstallState();
}

class _AuthFirstInstallState extends State<AuthFirstInstall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          // Positioned.fill(
          //   bottom: 0,
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Visibility(
          //       visible: selectedButtonIndex == -1,
          //       child: Image.asset(
          //         'assets/images/house.png',
          //         height: 160,
          //         fit: BoxFit.fitHeight,
          //       ),
          //     ),
          //   ),
          // ),

          const AuthButtons(),
          Positioned.fill(
            bottom: 30,
            right: 10,
            left: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                spacing: MediaQuery.of(context).size.width * 0.6,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.router.push(const MainRoute());
                    },
                    child: AutoSizeText(
                      'Skip',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.pop();
                    },
                    child: AutoSizeText(
                      'Back',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
