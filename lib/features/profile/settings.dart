import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../core/injection/injection_container.dart';
import '../users/data/models/user_model.dart';
import '../users/presentation/logic/bloc/user_bloc.dart';
import 'about_us_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();
    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    super.dispose();
  }
void _onBoxChange() {
  getUserData();
}


  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  Widget _buildElements(BuildContext context) {
    return Column(
      children: [
        _buildItem(
            iconData: Icons.headset_mic_rounded,
            progress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HelpCenterScreen()));
            },
            title: "Help Center"),
        _buildItem(
            iconData: Icons.lock_outline,
            progress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyScreen()));
            },
            title: "Privacy and policy"),
        _buildItem(
            iconData: Icons.groups_outlined,
            progress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AboutUsScreen()));
            },
            title: "About Us"),
        const SizedBox(height: 16),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 35, 47, 103))),
                child: const AutoSizeText("English"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 35, 47, 103))),
                child: const AutoSizeText("Arabic"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 35, 47, 103))),
                child: const AutoSizeText("Kurdish"),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildItem(
      {required String title,
      required IconData iconData,
      required void Function()? progress}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(iconData, color: Theme.of(context).colorScheme.primary),
          title: Text(title),
          trailing: const Icon(
            Icons.keyboard_double_arrow_right_rounded,
            color: Color.fromARGB(255, 35, 47, 103),
          ),
          onTap: progress,
        ),
        const Divider(
          thickness: 0.3,
          color: Color.fromARGB(255, 35, 47, 103),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserDeleted){
            _deleteAccount();
          }
        },
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(UniconsLine.angle_left_b),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const AutoSizeText("Settings"),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary),
          body: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildElements(context),
                  const SizedBox(height: 30),
                  userBox.isEmpty
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            _logout();
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText("Log out"),
                              Icon(
                                Icons.output_rounded,
                                color: Color.fromARGB(255, 35, 47, 103),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  userBox.isEmpty
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BlocProvider(
                                  create: (context) => sl<UserBloc>(),
                                  child: BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this account forever?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              context.read<UserBloc>().add(
                                                  DeleteUserEvent(
                                                      user!.id, user!.token!));
                                              _deleteAccount();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text('Delete Account',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error)),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          const AutoSizeText("Follow us on"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    UniconsLine.facebook_f,
                                    size: 20,
                                    color: Color.fromARGB(255, 35, 47, 103),
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    UniconsLine.twitter_alt,
                                    size: 20,
                                    color: Color.fromARGB(255, 58, 116, 204),
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    UniconsLine.instagram,
                                    size: 20,
                                    color: Color.fromARGB(255, 35, 47, 103),
                                  ))
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logout() async {
    final userBox = Hive.box<UserModel>('userBox');
    await userBox.clear();
  }

  void _deleteAccount() async {
  if (!mounted) return; 
  final userBox = Hive.box<UserModel>('userBox');
  await userBox.clear();
  if (!mounted) return; 
  setState(() {
    getUserData();
  });
}

}
