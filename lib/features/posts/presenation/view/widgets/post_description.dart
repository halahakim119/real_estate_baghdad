import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  final String overview;
  final int likesNum;
  final double price;
  final double size;
  final String postType;
  final String categoryType;

  const PostDescription({
    required this.overview,
    required this.likesNum,
    required this.price,
    required this.size,
    required this.postType,
    required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Text(
              'Overview: $overview',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
            Text(
              'Likes: $likesNum',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
            Text(
              'Price: $price',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
            Text(
              'Size: $size',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
            Text(
              'Post Type: $postType',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
            Text(
              'Category Type: $categoryType',
              style: const TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}