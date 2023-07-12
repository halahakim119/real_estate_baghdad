import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicons/unicons.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../core/router/router.gr.dart';
import '../../core/utils/auth_buttons.dart';
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
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: userBox.isEmpty
            ? const AuthButtons()
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ProfileHeader(
                      user: user,
                    ),
                    SizedBox(
                      height: 80,
                      child: WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [
                              const Color.fromRGBO(75, 101, 206, 1),
                              const Color.fromRGBO(96, 130, 255, 1),
                            ],
                            [
                              const Color.fromRGBO(54, 73, 155, 1),
                              const Color.fromRGBO(75, 101, 206, 1),
                            ],
                            [
                              const Color.fromRGBO(35, 47, 103, 1),
                              const Color.fromRGBO(54, 73, 155, 1),
                            ],
                          ],
                          durations: [5000, 4000, 3000],
                          heightPercentages: [0.20, 0.4, 0.6],
                          blur: const MaskFilter.blur(BlurStyle.solid, 10),
                        ),
                        waveAmplitude: 0,
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        size: const Size(double.infinity, double.infinity),
                      ),
                    ),
                    Expanded(child: ProfileBody(user: user)),
                  ],
                ),
              ),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  final UserModel? user;
  const ProfileHeader({
    super.key,
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
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 5),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                direction: Axis.vertical,
                children: [
                  Row(
                    children: [
                      Text(
                        "NAME",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.user?.name ?? 'no data',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          context.router.push(EditProfileScreenRoute());
                        },
                        child: Icon(Icons.edit,
                            size: 18,
                            color: Theme.of(context).colorScheme.onPrimary),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "NUMBER",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.user?.phoneNumber ?? 'no data',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.onPrimary),
                onPressed: () {
                  context.router.push(const SettingsRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileBody extends StatefulWidget {
  final UserModel? user;
  const ProfileBody({
    super.key,
    required this.user,
  });

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final maxCrossAxisCount = _getCrossAxisCount(screenWidth, 50);

          return GridView.count(
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
              _buildIconButton(UniconsLine.newspaper, () {
                context.router.push(UserPostsScreenRoute());
              }, "Posts", "${widget.user?.posts ?? 0}"),
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

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: pastelColor,
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
        ),
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
