import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';
import '../authentication/presentation/view/pages/login_screen.dart';
import '../authentication/presentation/view/pages/signup_screen.dart';

class AuthFirstInstall extends StatefulWidget {
  const AuthFirstInstall({Key? key}) : super(key: key);

  @override
  State<AuthFirstInstall> createState() => _AuthFirstInstallState();
}

class _AuthFirstInstallState extends State<AuthFirstInstall> {
  int selectedButtonIndex = -1;

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  Widget _buildButton(int index, String label) {
    return Visibility(
      visible: selectedButtonIndex == -1,
      child: GestureDetector(
        onTap: () {
          _onButtonPressed(index);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 130,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 35, 47, 103),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          child: Center(
            child: AutoSizeText(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedButtonIndex != -1
          ? Colors.white
          : const Color.fromARGB(255, 35, 47, 103),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: selectedButtonIndex == -1,
                child: Image.asset(
                  'assets/images/house.png',
                  height: 160,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: selectedButtonIndex == -1,
                  child: const Center(
                  child: AutoSizeText(
                    'Real Estate',
                    style: TextStyle(
                      fontSize: 32,
                      color:  Colors.white,
                      fontFamily: 'Lily_Script_One',
                    ),
                  ),
                ),
                ),
                
                const SizedBox(height: 10),
                Visibility(
                  visible: selectedButtonIndex != -1,
                  child: selectedButtonIndex == 0
                      ? Expanded(child: LoginScreen())
                      : Expanded(child: SignupScreen()),
                ),
                Visibility(
                  visible: selectedButtonIndex == -1,
                  child: Column(
                    children: [
                      _buildButton(0, 'Login'),
                      _buildButton(1, 'Sign Up'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.router.push(MainRoute());
                      },
                      child: AutoSizeText(
                        'Skip',
                        style: TextStyle(
                          color: selectedButtonIndex != -1
                              ? const Color.fromARGB(255, 35, 47, 103)
                              : Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router.pop();
                      },
                      child: AutoSizeText(
                        'Back',
                        style: TextStyle(
                          color: selectedButtonIndex != -1
                              ? const Color.fromARGB(255, 35, 47, 103)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
