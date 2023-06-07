import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart';

import '../users/data/models/user_model.dart';
import 'about_us_screen.dart';
import 'help_center_screen.dart';
import 'privacy_policy_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final userBox = Hive.box<UserModel>('userBox');

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

  Widget _buildElements(BuildContext context) {
    return Column(
      children: [
        _buildItem(
            iconData: Icons.headset_mic_rounded,
            progress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => HelpCenterScreen()));
            },
            title: "Help Center"),
        _buildItem(
            iconData: Icons.lock_outline,
            progress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()));
            },
            title: "Privacy and policy"),
        _buildItem(
            iconData: Icons.groups_outlined,
            progress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutUsScreen()));
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
          thickness: 0.3,
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
              userBox.isEmpty
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        _logout();
                        Navigator.pop(context);
                      },
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
    );
  }

  void _logout() async {
    final userBox = Hive.box<UserModel>('userBox');
    await userBox.clear();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  Future<void> selectImages() async {
    final PermissionStatus status = await Permission.photos.request();

    if (status.isGranted) {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      }
      setState(() {});
    } else if (status.isDenied) {
      // Permission denied
      // Handle accordingly (e.g., show a message or request again)
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied
      // Ask the user to go to settings and grant the permission manually
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Images from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    selectImages();
                  }),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.file(File(imageFileList![index].path),
                          fit: BoxFit.cover);
                    }),
              ))
            ],
          ),
        ));
  }
}
