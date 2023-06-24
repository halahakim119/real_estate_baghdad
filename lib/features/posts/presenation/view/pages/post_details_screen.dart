import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:real_estate_baghdad/features/posts/presenation/logic/cubit/add_edit_delete_post_cubit.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/utils/formatPostDate.dart';
import '../../../../users/data/models/user_model.dart';
import '../../../domain/entities/post_entity.dart';

class PostDetailsScreen extends StatefulWidget {
  final PostEntity post;
  final String name;
  final String phoneNumber;

  const PostDetailsScreen(
      {required this.post, required this.name, required this.phoneNumber});

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
    return BlocProvider(
      create: (context) => sl<AddEditDeletePostCubit>(),
      child: BlocConsumer<AddEditDeletePostCubit, AddEditDeletePostState>(
        listener: (context, state) {
          state.maybeWhen(
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              deleted: (message) {
                context.router.pop();
              },
              orElse: () {});
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
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    )
                  ]),
            ),
            body: SingleChildScrollView(
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
                        items: widget.post.photosURL!.map((url) {
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
                            '${_currentIndex + 1}/${widget.post.photosURL!.length} ',
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
                          Text(widget.post.likeby == null
                              ? '0'
                              : widget.post.likeby!.length.toString())
                        ],
                      ),
                      Text(
                        formatPostDate(widget.post.createdAt!),
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Wrap(
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    direction: Axis.vertical,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text('Edit')),
                                      Container(
                                        height: 0.5,
                                        color: Colors.grey,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            context
                                                .read<AddEditDeletePostCubit>()
                                                ..deletePost(widget.post.id!,
                                                    user!.token!);
                                          },
                                          child: const Text('Delete post'))
                                    ]),
                              );
                            },
                          );
                        },
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
                        Text('\$   ${widget.post.price}'),
                        Text(widget.post.province),
                        Text(
                          widget.post.type.toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
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
                          child: Text('${widget.post.size}'),
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
                          child: Text('${widget.post.bedroomNumber}'),
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
                          child: Text('${widget.post.bathroomNumber}'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Title',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.post.title,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Overview',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.post.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Details',
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                                softWrap: true,
                                'category: ${widget.post.category}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Bedroom: ${widget.post.bedroomNumber}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'SwimmingPool: ${widget.post.swimmingPool}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Garage: ${widget.post.garage}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Garden: ${widget.post.garden}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                '24 H Electricity: ${widget.post.electricity24h}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                '24 H Water: ${widget.post.water24h}',
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
                              'Area: ${widget.post.size}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Bathroom: ${widget.post.bathroomNumber}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Furnishing: ${widget.post.furnishingStatus}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Installed AC: ${widget.post.installedAC}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
