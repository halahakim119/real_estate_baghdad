import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.favorite_border,
                size: 25,
                color: Color.fromARGB(255, 35, 47, 103),
              ),
              SizedBox(width: 5),
              Text(
                "123",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.share,
                size: 25,
                color: Color.fromARGB(255, 35, 47, 103),
              ),
              SizedBox(width: 8),
              Icon(
                UniconsLine.tag,
                size: 25,
                color: Color.fromARGB(255, 35, 47, 103),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.comment,
                size: 25,
                color: Color.fromARGB(255, 35, 47, 103),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
