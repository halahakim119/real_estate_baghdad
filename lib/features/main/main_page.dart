import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../core/router/router.gr.dart';
import '../users/data/models/user_model.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  Widget build(BuildContext context) {
    final bool isUserBoxEmpty = userBox.isEmpty;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ProfileRoute(),
        AddPostFormRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        final activeTabName = tabsRouter.current.name;
        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              if (isUserBoxEmpty
                  ? (activeTabName == 'ProfileRoute' ||
                      activeTabName == 'AddPostFormRoute')
                  : (activeTabName == 'ProfileRoute' ||
                      activeTabName == 'AddPostFormRoute')) {
                return [];
              } else {
                return [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    automaticallyImplyLeading: false,
                    title: const AutoSizeText(
                      'Real Estate',
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 47, 103),
                        fontSize: 24,
                        fontFamily: 'Lily_Script_One',
                      ),
                    ),
                    centerTitle: true,
                    leading: SizedBox(
                      width: 80,
                      child: Stack(
                        children: [
                          Positioned(
                            left: -5,
                            top: 10,
                            child: IconButton(
                              onPressed: () {},
                              splashRadius: 15,
                              icon: const Icon(
                                size: 25,
                                UniconsLine.search,
                                color: Color.fromARGB(255, 35, 47, 103),
                              ),
                            ),
                          ),
                          Positioned(
                            right: -15,
                            top: 10,
                            child: IconButton(
                              splashRadius: 15,
                              onPressed: () {},
                              icon: const Icon(
                                size: 20,
                                Icons.tune_rounded,
                                color: Color.fromARGB(255, 35, 47, 103),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          size: 25,
                          UniconsLine.chat,
                          color: Color.fromARGB(255, 35, 47, 103),
                        ),
                      ),
                    ],
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    elevation: 0,
                    toolbarHeight: 70,
                    bottom: PreferredSize(
                      preferredSize: Size.zero,
                      child: Divider(
                        height: 1,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  )
                ];
              }
            },
            body: child,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            onTap: (index) => tabsRouter.setActiveIndex(index),
            color: Theme.of(context).colorScheme.primary,
            animationDuration: const Duration(milliseconds: 250),
            index: tabsRouter.activeIndex,
            buttonBackgroundColor: (isUserBoxEmpty
                    ? (activeTabName == 'ProfileRoute' ||
                        activeTabName == 'AddPostFormRoute')
                    : (activeTabName == 'ProfileRoute'))
                ? Colors.white // Change the color to blue for the Profile tab
                : Theme.of(context).colorScheme.primary,
            backgroundColor: (isUserBoxEmpty
                    ? (activeTabName == 'ProfileRoute' ||
                        activeTabName == 'AddPostFormRoute')
                    : (activeTabName == 'ProfileRoute'))
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            animationCurve: Curves.ease,
            items: [
              Icon(
                UniconsLine.home_alt,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              Icon(
                UniconsLine.user,
                color: (isUserBoxEmpty
                        ? (activeTabName == 'ProfileRoute')
                        : (activeTabName == 'ProfileRoute'))
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
              ),
              Icon(UniconsLine.plus,
                  color: isUserBoxEmpty
                      ? (activeTabName == 'AddPostFormRoute')
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimary),
            ],
          ),
        );
      },
    );
  }
}
