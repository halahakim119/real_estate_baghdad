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
            child: AutoSizeText(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        )),
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
                    _buildButton(0, 'Arabic'),
                    _buildButton(1, 'English'),
                    _buildButton(2, 'Kurdish'),
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
                        const AutoSizeText('Next',
                            style: TextStyle(color: Colors.white)),
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
