import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';

class AuthFirstInstall extends StatefulWidget {
  const AuthFirstInstall({super.key});

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
    final bool isSelected = selectedButtonIndex == index;
    final bool isLoginSelected = selectedButtonIndex == 0;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          context.router.push(LoginRoute());
        } else {
          context.router.push(SignupRoute());
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 130,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 35, 47, 103),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 1,
          ),
        ),
        child: Center(
          child: isLoginSelected
              ? const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                )
              : AutoSizeText(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 47, 103),
      body: Stack(
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
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: AutoSizeText(
                    'Real Estate',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Lily_Script_One'),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    _buildButton(0, 'Login'),
                    _buildButton(1, 'Sign Up'),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.router.push(const MainRoute());
                          },
                          child: const AutoSizeText('Skip',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7),
                        GestureDetector(
                          onTap: () {
                            context.router.pop();
                          },
                          child: const AutoSizeText('Back',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
