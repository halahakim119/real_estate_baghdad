// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:unicons/unicons.dart';

import 'presenation/view/pages/post_widget.dart';

// import '../../core/router/router.gr.dart';

class Home extends StatefulWidget {
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

  bool _isPlaying = true; // Set to true to autoplay
  CarouselController _carouselController = CarouselController();

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
          Container(
            height: 160,
            child: CarouselSlider.builder(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 160,
                enableInfiniteScroll: true,
                autoPlay: _isPlaying,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 600),
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
                          color: Color.fromRGBO(134, 161, 76, 0.409),
                        ),
                        child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                UniconsLine.star,
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Baghdad',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: [
              InkWell(
                child: Container(
                  color: Colors.amber,
                  height: 20,
                  width: 20,
                ),
              ),
              InkWell(
                child: Container(
                  color: Colors.black,
                  height: 20,
                  width: 20,
                ),
              ),
              InkWell(
                child: Container(
                  color: Colors.blue,
                  height: 20,
                  width: 20,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (context, index) => PostWidget(
                    likesNum: 10,
                    dateAdded: DateTime(2023, 6, 5),
                    link: 'https://example.com',
                    images: ['image1.jpg', 'image2.jpg'],
                    province: 'Baghdad',
                    overview: 'This is the post overview',
                    size: 100.0,
                    price: 200.0,
                    postType: 'Sale',
                    categoryType: 'Real Estate',
                  ),
                ),
                SizedBox(height: 16),
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
