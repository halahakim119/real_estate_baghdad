import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  Widget _buildElements(BuildContext context) {
    return Column(
      children: [
        _buildItem(
            iconData: Icons.headset_mic_rounded,
            progress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Settings()));
            },
            title: "Help Center"),
        _buildItem(
            iconData: Icons.lock_outline,
            progress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Settings()));
            },
            title: "Privacy and policy"),
        _buildItem(
            iconData: Icons.groups_outlined,
            progress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Settings()));
            },
            title: "About Us"),
        _buildItem(
            iconData: Icons.call,
            progress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Settings()));
            },
            title: "Contact Us"),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          leading: Icon(
            iconData,
            color: const Color.fromARGB(255, 35, 47, 103),
          ),
          title: Text(title),
          trailing: const Icon(
            Icons.keyboard_double_arrow_right_rounded,
            color: Color.fromARGB(255, 35, 47, 103),
          ),
          onTap: progress,
        ),
        const Divider(
          color: Color.fromARGB(255, 35, 47, 103),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: const Color.fromARGB(255, 35, 47, 103),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildElements(context),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AutoSizeText("Log out"),
                    Icon(
                      Icons.output_rounded,
                      color: Color.fromARGB(255, 35, 47, 103),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
    );
  }
}
