import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../core/router/router.gr.dart';
import '../authentication/presentation/view/pages/login_screen.dart';
import '../users/data/models/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (!userBox.isEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: userBox.isEmpty
              ? LoginScreen()
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ProfileHeader(user: user),
                    ProfileBody(user: user),
                  ],
                ),
        ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  final UserModel? user;
  ProfileHeader({
    required this.user,
  });
  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 47, 103),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      "NAME",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.user?.name ?? 'no data',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      "NUMBER",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.user?.number ?? 'no data',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                context.router.push(SettingsRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  final UserModel? user;
  ProfileBody({
    required this.user,
  });

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      margin: EdgeInsets.all(25),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final maxCrossAxisCount = _getCrossAxisCount(screenWidth, 50);

          return GridView.count(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: maxCrossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            children: [
              _buildIconButton(UniconsLine.user, () {}, "following",
                  "${widget.user?.following.length ?? 0}"),
              _buildIconButton(UniconsLine.users_alt, () {}, "followers",
                  "${widget.user?.followers.length ?? 0}"),
              _buildIconButton(Icons.favorite_border_outlined, () {}, "Likes",
                  "${widget.user?.likes.length ?? 0}"),
              _buildIconButton(UniconsLine.newspaper, () {}, "Posts",
                  "${widget.user?.posts.length ?? 0}"),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconButton(IconData iconData, onPressed, data, details) {
    final random = Random();
    final hue = random.nextInt(60) + 180;
    final pastelColor =
        HSLColor.fromAHSL(1.0, hue.toDouble(), 1, 0.7).toColor();

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: pastelColor,
            icon: Icon(iconData),
            onPressed: onPressed,
          ),
          Text(
            data,
            style: TextStyle(color: pastelColor),
          ),
          Text(
            details,
            style: TextStyle(color: pastelColor),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(double screenWidth, double containerSize) {
    if (screenWidth >= 500) {
      return 4;
    } else if (screenWidth >= 400) {
      return 3;
    } else if (screenWidth >= 200) {
      return 2;
    } else {
      return 1;
    }
  }
}
