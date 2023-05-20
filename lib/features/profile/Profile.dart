import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:real_estate_baghdad/core/router/router.gr.dart';

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
    context.router.popAndPush(const MainRoute());
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
                  icon: Icon(Icons.logout,color: Colors.amber,),
                  onPressed: () {
                    _logout();
                  },
                ),
        ],
      ),
      body: Container(
        child: userBox.isEmpty ? LoginScreen() : HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
