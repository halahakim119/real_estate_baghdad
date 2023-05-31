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
      color: const Color.fromARGB(255, 255, 255, 255),
      height: MediaQuery.of(context).size.height * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("${user?.followers.length ?? 0}"),
                  const Text("Followers"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 1,
                    color: const Color.fromARGB(255, 35, 47, 103),
                    width: 50,
                  ),
                  Text(" ${user?.following.length ?? 0}"),
                  const Text("Following"),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 1,
                    color: const Color.fromARGB(255, 35, 47, 103),
                    width: 50,
                  ),
                  Text("${user?.likes.length ?? 0}"),
                  const Text("Likes"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          alignment: Alignment.centerLeft,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            size: 20,
                          )),
                      Text(user?.name ?? ''),
                    ],
                  ),
                  Text(user?.number ?? ''),
                ],
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(
                    width: 1, color: Color.fromARGB(255, 35, 47, 103)),
              ),
            ),
            child: const Text(
              "Add New Post +",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 35, 47, 103)),
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
    );
  }
}
