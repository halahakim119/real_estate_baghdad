import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               AutoSizeText(
                'Real Estate',
                style: TextStyle(
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontFamily: 'Lily_Script_One'),
              ),
              const SizedBox(height: 10),
               AutoSizeText('No internet',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 3,
                    fontFamily: 'Lily_Script_One',
                    color: Theme.of(context).colorScheme.onPrimary
                  )),
              LoadingBouncingLine.circle(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                duration: const Duration(milliseconds: 2500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
