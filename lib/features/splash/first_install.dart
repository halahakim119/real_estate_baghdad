import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';

class FirstInstall extends StatefulWidget {
  const FirstInstall({super.key});

  @override
  State<FirstInstall> createState() => _FirstInstallState();
}

class _FirstInstallState extends State<FirstInstall> {
  int selectedButtonIndex = -1;

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  Widget _buildButton(int index, String label) {
    final bool isSelected = selectedButtonIndex == index;

    return GestureDetector(
      onTap: () => _onButtonPressed(index),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Center(
            child: AutoSizeText(
          label,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        )),
      ),
    );
  }

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
          //     child: Image.asset(
          //       'assets/images/house.png',
          //       height: 160,
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),

          Positioned.fill(
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      _buildButton(0, 'Arabic'),
                      _buildButton(1, 'English'),
                      _buildButton(2, 'Kurdish'),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.router.push(const AuthFirstInstallRoute());
                    },
                    child: AutoSizeText(
                      'Next',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
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
