import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/router/router.gr.dart';
import '../authentication/presentation/view/pages/login_screen.dart';
import '../users/data/models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final userBox = Hive.box<UserModel>('userBox');
  void _logout() async {
    await userBox.clear(); // Clear the user data
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.settings,
            color: Color.fromARGB(255, 35, 47, 103),
          ),
          onPressed: () {
            context.router.push(SettingsRoute());
          },
        ),
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
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 35, 47, 103),
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
  const ProfileHeader({Key? key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    final userBox = Hive.box<UserModel>('userBox');
    if (!userBox.isEmpty) {
      user = userBox.getAt(0);
    }
  }

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
                children: [
                  Text("Name: ${user?.name ?? ''}"),
                  Text("Number: ${user?.number ?? ''}"),
                ],
              ),
              Column(
                children: [
                  Text("Followers: ${user?.followers.length ?? 0}"),
                  Text("Following: ${user?.following.length ?? 0}"),
                  Text("Likes: ${user?.likes.length ?? 0}"),
                ],
              ),
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
          ),
        ],
      ),
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
    );
  }
}
