import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/router/router.gr.dart';
import '../../../../../core/utils/formatPostDate.dart';
import '../../../../users/data/models/user_model.dart';
import '../../../domain/entities/post_entity.dart';
import '../../logic/cubit/add_edit_delete_post_cubit.dart';

class PostDetailsScreen extends StatefulWidget {
  final PostEntity post;
  final String name;
  final String phoneNumber;

  const PostDetailsScreen({
    required this.post,
    required this.name,
    required this.phoneNumber,
  });

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
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
    final postId = widget.post.id;
    final retrievedPost = user?.posts.firstWhere((post) => post.id == postId);

    if (retrievedPost == null) {
      return const Center(child: Text('Post not found'));
    }
    return BlocProvider(
      create: (context) => sl<AddEditDeletePostCubit>(),
      child: BlocConsumer<AddEditDeletePostCubit, AddEditDeletePostState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            deleted: (message) {
              context.router
                  .popAndPush(UserPostsScreenRoute(posts: user?.posts));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        items: retrievedPost.photosURL!
                            .map(
                              (url) => Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList(),
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
                            '${_currentIndex + 1}/${retrievedPost.photosURL!.length} ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              // Handle like button pressed
                            },
                          ),
                          Text(
                            retrievedPost.likeby == null
                                ? '0'
                                : retrievedPost.likeby!.length.toString(),
                          ),
                        ],
                      ),
                      Text(
                        formatPostDate(retrievedPost.createdAt!),
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const Divider(),
                  Center(
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text('\$   ${retrievedPost.price}'),
                        Text(retrievedPost.province),
                        Text(
                          retrievedPost.type.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.end,
                      children: [
                        const Icon(
                          Icons.expand,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('${retrievedPost.size}'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: 1,
                          height: 25,
                          color: Colors.black,
                        ),
                        const Icon(
                          Icons.bed,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('${retrievedPost.bedroomNumber}'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: 1,
                          height: 25,
                          color: Colors.black,
                        ),
                        const Icon(
                          Icons.bathtub_outlined,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('${retrievedPost.bathroomNumber}'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      retrievedPost.title,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Overview',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      retrievedPost.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Text(
                                'category: ${retrievedPost.category}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Bedroom: ${retrievedPost.bedroomNumber}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'SwimmingPool: ${retrievedPost.swimmingPool}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Garage: ${retrievedPost.garage}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Garden: ${retrievedPost.garden}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                '24 H Electricity: ${retrievedPost.electricity24h}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                '24 H Water: ${retrievedPost.water24h}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            Text(
                              'Area: ${retrievedPost.size}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Bathroom: ${retrievedPost.bathroomNumber}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Furnishing: ${retrievedPost.furnishingStatus}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Installed AC: ${retrievedPost.installedAC}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          );
                        },
                      );

                      // Delay for 5 seconds
                      await Future.delayed(Duration(seconds: 1));

                      // Hide loading indicator
                      Navigator.of(context).pop();

                      // Navigate to EditPostFormRoute
                      context.router.push(EditPostFormRoute(post: widget.post));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text('Edit post'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BlocProvider(
                            create: (context) => sl<AddEditDeletePostCubit>(),
                            child: BlocBuilder<AddEditDeletePostCubit,
                                AddEditDeletePostState>(
                              builder: (context, state) {
                                return AlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this post?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<AddEditDeletePostCubit>()
                                          ..deletePost(
                                              widget.post.id!, user!.token!);
                                        Navigator.of(context).pop();
                                        context.router.popUntil(
                                          (route) =>
                                              route.settings.name !=
                                              PostDetailsScreenRoute.name,
                                        );
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: const Text('Delete post'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
