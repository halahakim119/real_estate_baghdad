import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_baghdad/core/router/router.gr.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome to the home page'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 35, 47, 103),
        onPressed: () {
          context.router.push(const MapRoute());
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
