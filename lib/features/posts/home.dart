import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: 50,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Color.fromARGB(255, 149, 62, 231),
          ),
        ),
      ),
    );
  }
}
