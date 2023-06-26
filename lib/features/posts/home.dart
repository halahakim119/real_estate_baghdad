// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:auto_route/auto_route.dart';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU'
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
          const SizedBox(height: 20),
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
                      child: Image.network(
                        images[index],
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
                          color: const Color.fromRGBO(35, 47, 103, 0.8),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Categories(
                  imagePath: 'assets/images/houseCategory.png',
                  onTap: () {},
                  title: 'House',
                  height: 90,
                  width: 90,
                ),
                Categories(
                  imagePath: 'assets/images/restaurantCategory.png',
                  onTap: () {},
                  title: 'Restaurant',
                  height: 80,
                  width: 75,
                ),
                Categories(
                  imagePath: 'assets/images/warehouseCategory.png',
                  onTap: () {},
                  title: 'WareHouse',
                  height: 80,
                  width: 75,
                ),
                Categories(
                  imagePath: 'assets/images/villaCategory.png',
                  onTap: () {},
                  title: 'Villa',
                  height: 100,
                  width: 110,
                ),
                Categories(
                  imagePath: 'assets/images/farmCategory.png',
                  onTap: () {},
                  title: 'Farm',
                  height: 80,
                  width: 70,
                ),
                Categories(
                  imagePath: 'assets/images/apartmentCategory.png',
                  onTap: () {},
                  title: 'Apartment',
                  height: 80,
                  width: 80,
                ),
                Categories(
                  imagePath: 'assets/images/condominiumCategory.png',
                  onTap: () {},
                  title: 'Condominium',
                  height: 70,
                  width: 70,
                ),
                Categories(
                  imagePath: 'assets/images/garageCategory.png',
                  onTap: () {},
                  title: 'Garage',
                  height: 65,
                  width: 120,
                ),
                Categories(
                  imagePath: 'assets/images/retailCategory.png',
                  onTap: () {},
                  title: 'Retail',
                  height: 70,
                  width: 70,
                ),
                Categories(
                  imagePath: 'assets/images/hotelCategory.png',
                  onTap: () {},
                  title: 'Hotel',
                  height: 70,
                  width: 70,
                ),
                Categories(
                  imagePath: 'assets/images/landCategory.png',
                  onTap: () {},
                  title: 'Land',
                  height: 90,
                  width: 80,
                ),
                Categories(
                  imagePath: 'assets/images/residentalCategory.png',
                  onTap: () {},
                  title: 'Residental',
                  height: 70,
                  width: 70,
                ),
                Categories(
                  imagePath: 'assets/images/officeCategory.png',
                  onTap: () {},
                  title: 'Office',
                  height: 85,
                  width: 80,
                ),
                Categories(
                  imagePath: 'assets/images/resortCategory.png',
                  onTap: () {},
                  title: 'Resort',
                  height: 80,
                  width: 70,
                ),
              ],
            ),
          ),
          const Divider(),
          const Wrap(alignment: WrapAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,

                  // Add more text styles as needed
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'See All',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,

                  // Add more text styles as needed
                ),
              ),
            ),
          ]),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
                Trending(
                    onTap: () {},
                    imagePath:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR53NnP4NAy2x_4YTkBofobWXawoH-A6rIB9ixSUPgIxNLvTvSp4skg_QDfB77PhMxSDys&usqp=CAU',
                    title: 'Hotel 5 starts'),
              ],
            ),
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
                    size: 100,
                    price: 200,
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

class Categories extends StatefulWidget {
  void Function()? onTap;
  String imagePath;
  String title;
  int height;
  int width;
  Categories({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.title,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final random = Random();
    final hue = random.nextInt(60) + 180;
    final pastelColor =
        HSLColor.fromAHSL(1.0, hue.toDouble(), 1, 0.7).toColor();
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(right: 50, top: 10, bottom: 10, left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: pastelColor.withOpacity(0.5), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Shadow offset
                ),
              ],
            ),
            height: 40,
            width: 100,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 45),
                child: AutoSizeText(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -10,
            right: 10,
            child: Image.asset(
              widget.imagePath,
              height: widget.height.toDouble(),
              width: widget.width.toDouble(),
            ),
          )
        ],
      ),
    );
  }
}

class Trending extends StatefulWidget {
  void Function()? onTap;
  String imagePath;
  String title;

  Trending({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(35, 47, 103, 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 45),
                    child: AutoSizeText(
                      widget.title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
