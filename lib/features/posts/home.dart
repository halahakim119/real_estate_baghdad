// import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'presenation/view/pages/post_widget.dart';

// import '../../core/router/router.gr.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> images = [
    'assets/images/a.jpg',
    'assets/images/b.jpg',
    'assets/images/c.jpg',
    'assets/images/d.jpg',
    'assets/images/h.jpg'
  ];

  final bool _isPlaying = true; // Set to true to autoplay
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carouselController.startAutoPlay();
    });
  }

  @override
  void dispose() {
    _carouselController
        .stopAutoPlay(); // Stop autoplay when disposing the state
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 160,
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 160,
                enableInfiniteScroll: true,
                autoPlay: _isPlaying,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 600),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {},
              ),
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        images[index],
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(35, 47, 103, 0.5),
                        ),
                        child: const Text(
                          'Baghdad',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                    color: const Color.fromRGBO(35, 47, 103, 0.2),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1,
                      ),
                      color: const Color.fromRGBO(227, 215, 202, 0.5)),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 1,
                    ),
                    color: const Color.fromRGBO(134, 161, 76, 0.2),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ),
            ],
          ),
          const Divider(),
         
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (context, index) => PostWidget(
                    likesNum: 10,
                    dateAdded: DateTime(2023, 6, 5),
                    link: 'https://example.com',
                    images: const ['image1.jpg', 'image2.jpg'],
                    province: 'Baghdad',
                    overview: 'This is the post overview',
                    size: 100.0,
                    price: 200.0,
                    postType: 'Sale',
                    categoryType: 'Real Estate',
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   onPressed: () {
      //     context.router.push(const MapRoute());
      //   },
      //   child: Icon(Icons.arrow_forward),
      // ),
    );
  }
}
