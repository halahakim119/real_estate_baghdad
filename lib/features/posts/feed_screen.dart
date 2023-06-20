import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/utils/auth_buttons.dart';
import '../users/data/models/user_model.dart';
import 'presenation/view/pages/post_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final userBox = Hive.box<UserModel>('userBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: userBox.isEmpty
              ? const AuthButtons()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: 50,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PostWidget(
                          likesNum: 10,
                          dateAdded: DateTime(2023, 6, 5),
                          link: 'https://example.com',
                          images: const ['image1.jpg', 'image2.jpg'],
                          province: 'Baghdad',
                          overview: 'This is the post overview',
                          size: 100,
                          price: 200,
                          postType: 'Sale',
                          categoryType: 'Real Estate',
                        )),
                  ),
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    userBox.listenable().addListener(_onBoxChange);
  }

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {});
  }
}
