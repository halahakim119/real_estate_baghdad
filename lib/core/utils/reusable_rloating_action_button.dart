import 'package:flutter/material.dart';

class ReusableFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const ReusableFloatingActionButton({
    required this.onPressed,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 1.0,
        ),
      ),
      backgroundColor: Color.fromARGB(104, 35, 47, 103),
      elevation: 0,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary
      ),
    );
  }
}
