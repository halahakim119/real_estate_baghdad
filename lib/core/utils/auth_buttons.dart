import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../router/router.gr.dart';

class AuthButtons extends StatefulWidget {
  const AuthButtons({super.key});

  @override
  State<AuthButtons> createState() => _AuthButtonsState();
}

class _AuthButtonsState extends State<AuthButtons> {
  void _onButtonPressed(int index) {
    index == 0
        ? context.router.push(const LoginRoute())
        : context.router.push(const SignupRoute());
  }

  Widget _buildButton(int index, String label) {
    return GestureDetector(
      onTap: () {
        _onButtonPressed(index);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: AutoSizeText(
            label,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Column(
              children: [
                AutoSizeText(
                  'Real Estate',
                  style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontFamily: 'Lily_Script_One'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                _buildButton(0, 'Login'),
                _buildButton(1, 'Sign Up'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
