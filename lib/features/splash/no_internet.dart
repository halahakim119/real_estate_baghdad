import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 47, 103),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Real Estate',
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'Lily_Script_One'),
              ),
              const SizedBox(height: 10),
              const AutoSizeText('No internet',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 3,
                    fontFamily: 'Lily_Script_One',
                    color: Colors.white,
                  )),
              LoadingBouncingLine.circle(
                backgroundColor: Colors.white,
                duration: const Duration(milliseconds: 2500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
