import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:real_estate_baghdad/features/posts/feed_screen.dart';

import '../authentication/presentation/view/pages/login_screen.dart';
import '../users/data/models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _logout() async {
    final userBox = Hive.box<UserModel>('userBox');
    await userBox.clear(); // Clear the user data
    setState(() {});
    FeedScreen();
  }

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<UserModel>('userBox');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          const Center(
            child: AutoSizeText(
              'Real Estate',
              style: TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 20,
                fontFamily: 'Lily_Script_One',
              ),
            ),
          ),
          const SizedBox(width: 10),
          userBox.isEmpty
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    _logout();
                  },
                ),
        ],
      ),
      body: Container(
        child: userBox.isEmpty
            ? LoginScreen()
            : Container(
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ProfileHeader(),
                    ProfileBody(),
                  ],
                )),
              ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 222, 222, 222),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [Text("data"), Text("data"), Text("data")],
                ),
                Column(
                  children: [Text("data"), Text("data"), Text("data")],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 35, 47, 103),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                      width: 1, color: Color.fromARGB(255, 35, 47, 103)),
                ),
              ),
              child: const Text(
                "Add New Post +",
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
            )
          ]),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.63,
      color: Color.fromARGB(255, 123, 153, 179),
      child: SingleChildScrollView(
        child: Column(children: [
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
        ]),
      ),
    );
  }
}
