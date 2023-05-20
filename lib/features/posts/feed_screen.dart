import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../authentication/presentation/view/pages/login_screen.dart';
import '../users/data/models/user_model.dart';

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
            ? LoginScreen()
            : Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      FeedHeader(),
                      FeedBody(),
                    ],
                  ),
                ),
              ),
      ),
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

class FeedHeader extends StatelessWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 222, 222, 222),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [Text("data")],
      ),
    );
  }
}

class FeedBody extends StatelessWidget {
  const FeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.63,
      color: const Color.fromARGB(255, 123, 153, 179),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              height: 50,
            ),
            Container(
              color: Colors.black,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              height: 50,
            ),
            Container(
              color: Colors.amber,
              height: 50,
            ),
            Container(
              color: Colors.black,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              height: 50,
            ),
            Container(
              color: Colors.amber,
              height: 50,
            ),
            Container(
              color: Colors.black,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              height: 50,
            ),
            Container(
              color: Colors.amber,
              height: 50,
            ),
            Container(
              color: Colors.black,
              height: 50,
            ),
            Container(
              color: Colors.blue,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
