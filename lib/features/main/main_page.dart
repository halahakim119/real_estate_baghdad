import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../core/router/router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          snap: true,
          automaticallyImplyLeading: false,
          title: const AutoSizeText(
            'Real Estate',
            style: TextStyle(
                color: Color.fromARGB(255, 35, 47, 103),
                fontSize: 24,
                fontFamily: 'Lily_Script_One'),
          ),
          centerTitle: true,
          leadingWidth: 80,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                   size: 25,
                  UniconsLine.search,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                   size: 20,
                  Icons.tune_rounded,
                  color: Color.fromARGB(255, 35, 47, 103),
                ),
              ),
            ],
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
          backgroundColor: Colors.white,
          elevation: 0,
          expandedHeight: 70,
          bottom: const PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                color: Color.fromARGB(255, 138, 78, 24),
              )),
        ),
      ],
      body: AutoTabsScaffold(
        routes: const [FeedRoute(), HomeRoute(), ProfileRoute()],
        bottomNavigationBuilder: (_, tabsRouter) {
          return CurvedNavigationBar(
            onTap: tabsRouter.setActiveIndex,
            color: const Color.fromARGB(255, 35, 47, 103),
            animationDuration: const Duration(milliseconds: 250),
            index: tabsRouter.activeIndex,
            buttonBackgroundColor: const Color.fromARGB(255, 35, 47, 103),
            backgroundColor: Colors.transparent,
            animationCurve: Curves.ease,
            items: const [
              Icon(UniconsLine.star, color: Colors.white),
              Icon(UniconsLine.home_alt, color: Colors.white),
              Icon(UniconsLine.user, color: Colors.white),
            ],
          );
        },
      ),
    ));
  }
}
