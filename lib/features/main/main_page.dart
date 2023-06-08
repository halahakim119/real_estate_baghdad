import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../core/router/router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [FeedRoute(), HomeRoute(), ProfileRoute(),AddPostFormRoute()],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        final activeTabName = tabsRouter.current.name;

        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              if (activeTabName == 'ProfileRoute' || activeTabName == 'AddPostFormRoute') {
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
                    bottom: const PreferredSize(
                      preferredSize: Size.zero,
                      child: Divider(
                        height: 1,
                        color: Color.fromARGB(255, 138, 78, 24),
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
            buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.ease,
            items: const [
              Icon(UniconsLine.star, color: Colors.white),
              Icon(UniconsLine.home_alt, color: Colors.white),
              Icon(UniconsLine.user, color: Colors.white),
               Icon(UniconsLine.plus, color: Colors.white),
            ],
          ),
        );
      },
    );
  }
}
