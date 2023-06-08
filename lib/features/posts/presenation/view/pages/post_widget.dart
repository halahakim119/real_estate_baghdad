
import 'package:flutter/material.dart';


import '../widgets/post_description.dart';
import '../widgets/post_footer.dart';
import '../widgets/post_header.dart';

class PostWidget extends StatelessWidget {
  final int likesNum;
  final DateTime dateAdded;
  final String link;
  final List<String> images;
  final String province;
  final String overview;
  final double size;
  final double price;
  final String postType;
  final String categoryType;

  const PostWidget({
    required this.likesNum,
    required this.dateAdded,
    required this.link,
    required this.images,
    required this.province,
    required this.overview,
    required this.size,
    required this.price,
    required this.postType,
    required this.categoryType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(dateAdded: dateAdded),
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary
            ),
            alignment: Alignment.center,
            child: images.isNotEmpty
                ? Icon(
                    Icons.image,
                    size: 48,
                    color: Colors.grey.shade400,
                  )
                : const Icon(
                    Icons.image,
                    size: 48,
                    color: Colors.grey,
                  ),
          ),
          PostDescription(
              overview: overview,
              likesNum: likesNum,
              postType: postType,
              price: price,
              size: size,
              categoryType: categoryType),
          PostFooter()
        ],
      ),
    );
  }
}
