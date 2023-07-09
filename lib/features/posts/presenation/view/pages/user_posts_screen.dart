import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../core/router/router.gr.dart';

import '../../../../users/data/models/user_model.dart';
import '../../../domain/entities/post_entity.dart';

class UserPostsScreen extends StatefulWidget {
  final List<PostEntity>? posts;

  const UserPostsScreen({ this.posts});

  @override
  _UserPostsScreenState createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  
  bool _isGridView = true;
  int _currentIndex = 0;
  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);

    super.dispose();
  }

  void _onBoxChange() {
    setState(() {
      getUserData();
    });
  }

  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');

  @override
  void initState() {
    super.initState();

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
             context.router.popAndPush(const ProfileRoute());
            },
          ),

        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _isGridView ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.posts?.length ?? 0,
      itemBuilder: (context, index) {
        final post = widget.posts![index];
        return GestureDetector(
          onTap: () {
            context.router.push(PostDetailsScreenRoute(
                post: post, name: user!.name, phoneNumber: user!.phoneNumber));
          },
          child: Card(
            elevation: 5,
            child: Stack(
              children: [
                post.photosURL!.length == 1
                    ? Image.network(
                        post.photosURL![0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1.0,
                          aspectRatio: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                          pageSnapping: true,
                        ),
                        items: post.photosURL!.map((url) {
                          return Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                      ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(35, 47, 103, 0.5),
                    ),
                    child: AutoSizeText(
                      post.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(10),
      itemCount: widget.posts?.length ?? 0,
      itemBuilder: (context, index) {
        final post = widget.posts![index];
        return GestureDetector(
          onTap: () {
            context.router.push(PostDetailsScreenRoute(
                post: post, name: user!.name, phoneNumber: user!.phoneNumber));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        aspectRatio: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: post.photosURL!.map((url) {
                        return ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black54,
                        ),
                        child: Text(
                          '${_currentIndex + 1}/${post.photosURL!.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Price: ${post.price}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Size: ${post.size}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Description: ${post.description}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Province: ${post.province}'),
                      ),
                      // Add more details as needed
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: [IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            // Handle like button pressed
                          },
                        ),
                         Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${post.likeby==null?0:post.likeby!.length}'),
                      ),]
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // Handle comment button pressed
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
