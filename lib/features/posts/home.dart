import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/router/router.gr.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          
          context.router.push(const MapRoute());
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
