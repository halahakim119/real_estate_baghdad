import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/utils/auth_buttons.dart';
import '../../../../users/data/models/user_model.dart';
import '../../../domain/entities/post_entity.dart';
import '../../logic/cubit/add_edit_delete_post_cubit.dart';
import '../widgets/add_post_widgets.dart';

class EditPostForm extends StatefulWidget {
  final PostEntity post;

  const EditPostForm({super.key, required this.post});

  @override
  _EditPostFormState createState() => _EditPostFormState();
}

class _EditPostFormState extends State<EditPostForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  // Add separate ScrollControllers for the SingleChildScrollView and CarouselSlider
  final _singleChildScrollViewController = ScrollController();
  // final _carouselSliderController = CarouselController();

  String? cityValue;
  String? categoryTypeValue;
  bool? garageChecked;
  String? provinceValue;
  bool? gardenChecked;
  bool? electricity24HChecked;
  bool? water24HChecked;
  bool? installedACChecked;
  String? furnishingStatus;
  String? type;
  int? bedroomNumber;
  int? bathroomNumber;
  String? postId;

  final List<File> _images = [];
  @override
  void dispose() {
    userBox.listenable().removeListener(_onBoxChange);
    _singleChildScrollViewController.dispose();

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
    _initializeFormValues();
  }

  Future<void> _initializeFormValues() async {
    // Set initial values for text controllers
    titleController.text = widget.post.title;
    sizeController.text = widget.post.size.toString();
    priceController.text = widget.post.price.toString();
    descriptionController.text = widget.post.description;

    // Set initial values for other state variables
    cityValue = widget.post.province;
    postId = widget.post.id;
    categoryTypeValue = widget.post.category;
    garageChecked = widget.post.garage;
    gardenChecked = widget.post.garden;
    provinceValue = widget.post.province;
    electricity24HChecked = widget.post.electricity24h;
    water24HChecked = widget.post.water24h;
    installedACChecked = widget.post.installedAC;
    furnishingStatus = widget.post.furnishingStatus;
    type = widget.post.type;
    bedroomNumber = widget.post.bedroomNumber;
    bathroomNumber = widget.post.bathroomNumber;

    getUserData();

    await _loadImages();
    userBox.listenable().addListener(_onBoxChange);
  }

  Future<void> _loadImages() async {
    List<File> downloadedImages = [];
    for (String imageUrl in widget.post.photosURL!) {
      File? imageFile = await _downloadImage(imageUrl);
      if (imageFile != null) {
        downloadedImages.add(imageFile);
      }
    }
    setState(() {
      _images.addAll(downloadedImages);
    });
  }

  Future<File?> _downloadImage(String imageUrl) async {
    try {
      http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Directory appDir = await getApplicationDocumentsDirectory();
        String imagePath =
            '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        File imageFile = File(imagePath);
        await imageFile.writeAsBytes(response.bodyBytes);
        return imageFile;
      } else {
        print('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
    return null;
  }

  void getUserData() {
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();
    bool isGranted = statuses[Permission.camera]?.isGranted == true &&
        statuses[Permission.storage]?.isGranted == true &&
        statuses[Permission.photos]?.isGranted == true;
    if (isGranted) {
      try {
        final picker = ImagePicker();
        final image = await picker.pickImage(source: source);
        if (image != null) {
          File? croppedImage = await _cropImage(File(image.path));
          if (croppedImage != null) {
            if (_images.length < 4) {
              setState(() {
                _images.add(croppedImage);
              });
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Maximum Limit Reached'),
                    content: const Text('You can only select up to 4 images.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        }
      } catch (e) {
        print('Error picking image: $e');
      }
    } else {
      bool isPermanentlyDenied =
          statuses[Permission.camera]?.isPermanentlyDenied == true ||
              statuses[Permission.storage]?.isPermanentlyDenied == true ||
              statuses[Permission.photos]?.isPermanentlyDenied == true;
      if (isPermanentlyDenied) {
        _showSettingsDialog(context);
      }
    }
  }

  Future<File?> _cropImage(File image) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: const Color.fromARGB(255, 35, 47, 103),
        toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Image',
      ),
    );
    return croppedFile;
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Please grant camera and storage permissions from settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _clearFormFields() {
    titleController.clear();
    sizeController.clear();
    priceController.clear();
    descriptionController.clear();
    provinceValue = null;
    cityValue = null;
    categoryTypeValue = null;
    garageChecked = false;
    gardenChecked = false;
    electricity24HChecked = false;
    water24HChecked = false;
    installedACChecked = false;
    furnishingStatus = 'furnished';
    bedroomNumber = 0;
    bathroomNumber = 0;
    _images.clear();
    type = 'SALE';
  }

  void onProvinceSelected(String? value) {
    setState(() {
      cityValue = value;
    });
  }

  void onCategoryTypeSelected(String? value) {
    setState(() {
      categoryTypeValue = value;
    });
  }

  void onGarageChecked(bool value) {
    setState(() {
      garageChecked = value;
    });
  }

  void onGardenChecked(bool value) {
    setState(() {
      gardenChecked = value;
    });
  }

  void onElectricity24HChecked(bool value) {
    setState(() {
      electricity24HChecked = value;
    });
  }

  void onWater24HChecked(bool value) {
    setState(() {
      water24HChecked = value;
    });
  }

  void onInstalledACChecked(bool value) {
    setState(() {
      installedACChecked = value;
    });
  }

  void onFurnishingStatusChanged(String? value) {
    setState(() {
      furnishingStatus = value;
    });
  }

  void onTypeChanged(String? value) {
    setState(() {
      type = value;
    });
  }

  void onBedroomNumberChanged(int value) {
    setState(() {
      bedroomNumber = value;
    });
  }

  void onBathroomNumberChanged(int value) {
    setState(() {
      bathroomNumber = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: userBox.isEmpty
            ? null
            : AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                automaticallyImplyLeading: true,
                title: const AutoSizeText(
                  'Edit  Post',
                  style: TextStyle(
                    color: Color.fromARGB(255, 35, 47, 103),
                    fontFamily: 'Lily_Script_One',
                  ),
                ),
                centerTitle: true,
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
              ),
        body: userBox.isEmpty
            ? const AuthButtons()
            : BlocProvider(
                create: (context) => sl<AddEditDeletePostCubit>(),
                child: BlocConsumer<AddEditDeletePostCubit,
                    AddEditDeletePostState>(
                  listener: (context, state) {
                    state.maybeWhen(
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        updated: (message) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content: Text(message),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        error: (failure) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('failed to update post'),
                                content: Text(failure),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        orElse: () {});
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        controller: _singleChildScrollViewController,
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const AddPostFormText(),
                              const SizedBox(height: 20),
                              const AddPostFormImages(),
                              const SizedBox(height: 10),
                              _images.isEmpty
                                  ? const SizedBox(height: 10)
                                  : CarouselSlider.builder(
                                      itemCount: _images.length,
                                      itemBuilder: (context, index, _) {
                                        final image = _images[index];
                                        return Stack(
                                          children: [
                                            Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                              ),
                                            ),
                                            Positioned(
                                              top: 1,
                                              right: 1,
                                              child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                onPressed: () =>
                                                    deleteImage(index),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      options: CarouselOptions(
                                        height: 230,
                                        enlargeCenterPage: true,
                                        enableInfiniteScroll: false,
                                      ),
                                    ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 100,
                                      child: IconButton(
                                        icon: const Icon(Icons.photo_library),
                                        onPressed: () =>
                                            pickImage(ImageSource.gallery),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 100,
                                      child: IconButton(
                                        icon: const Icon(Icons.camera),
                                        onPressed: () =>
                                            pickImage(ImageSource.camera),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              AddPostFormFields(
                                titleController: titleController,
                                sizeController: sizeController,
                                priceController: priceController,
                                descriptionController: descriptionController,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormDropdowns(
                                onProvinceSelected: onProvinceSelected,
                                onCategoryTypeSelected: onCategoryTypeSelected,
                                initialCategoryTypeValue: categoryTypeValue,
                                initialProvinceValue: provinceValue,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormCheckboxes(
                                onGarageChecked: onGarageChecked,
                                onGardenChecked: onGardenChecked,
                                onElectricity24HChecked:
                                    onElectricity24HChecked,
                                onWater24HChecked: onWater24HChecked,
                                onInstalledACChecked: onInstalledACChecked,
                                initialElectricity24HChecked:
                                    electricity24HChecked,
                                initialGarageChecked: garageChecked,
                                initialGardenChecked: gardenChecked,
                                initialInstalledACChecked: installedACChecked,
                                initialWater24HChecked: water24HChecked,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormRadioButtons(
                                onFurnishingStatusSelected:
                                    onFurnishingStatusChanged,
                                onTypeSelected: onTypeChanged,
                                initialFurnishingStatus: furnishingStatus!,
                                initialType: type!,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormSliders(
                                onBedroomNumberChanged: onBedroomNumberChanged,
                                onBathroomNumberChanged:
                                    onBathroomNumberChanged,
                                initialBathroomNumber: bathroomNumber,
                                initialBedroomNumber: bedroomNumber,
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _clearFormFields();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                          30,
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: const Text('clear'),
                                    ),
                                    state.maybeWhen(
                                      updated: (message) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Retrieve form field values
                                              String title =
                                                  titleController.text;
                                              String size = sizeController.text;
                                              String price =
                                                  priceController.text;
                                              String description =
                                                  descriptionController.text;
                                              String province = cityValue ?? '';
                                              String categoryType =
                                                  categoryTypeValue ?? '';
                                              bool garage = garageChecked!;
                                              bool garden = gardenChecked!;
                                              bool electricity24H =
                                                  electricity24HChecked!;
                                              bool water24H = water24HChecked!;
                                              bool installedAC =
                                                  installedACChecked!;

                                              // Create the PostEntity object
                                              PostEntity postEntity =
                                                  PostEntity(
                                                id: postId,
                                                title: title,
                                                images: _images,
                                                province: province,
                                                description: description,
                                                furnishingStatus:
                                                    furnishingStatus!,
                                                type: type!,
                                                category: categoryType,
                                                bathroomNumber: bathroomNumber!,
                                                bedroomNumber: bedroomNumber!,
                                                size: int.tryParse(size) ?? 0,
                                                price: int.tryParse(price) ?? 0,
                                                garden: garden,
                                                garage: garage,
                                                electricity24h: electricity24H,
                                                water24h: water24H,
                                                installedAC: installedAC,
                                              );

                                              context.read<
                                                  AddEditDeletePostCubit>()
                                                ..updatePost(postEntity);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              30,
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          child: const Text('Submit'),
                                        );
                                      },
                                      loading: () {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        );
                                      },
                                      orElse: () {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Retrieve form field values
                                              String title =
                                                  titleController.text;
                                              String size = sizeController.text;
                                              String price =
                                                  priceController.text;
                                              String description =
                                                  descriptionController.text;
                                              String province = cityValue ?? '';
                                              String categoryType =
                                                  categoryTypeValue ?? '';
                                              bool garage =
                                                  garageChecked ?? false;
                                              bool garden =
                                                  gardenChecked ?? false;
                                              bool electricity24H =
                                                  electricity24HChecked ??
                                                      false;
                                              bool water24H =
                                                  water24HChecked ?? false;
                                              bool installedAC =
                                                  installedACChecked ?? false;

                                              // Create the PostEntity object
                                              PostEntity postEntity =
                                                  PostEntity(
                                                id: postId,
                                                title: title,
                                                images: _images,
                                                province: province,
                                                description: description,
                                                furnishingStatus:
                                                    furnishingStatus!,
                                                type: type!,
                                                category: categoryType,
                                                bathroomNumber: bathroomNumber!,
                                                bedroomNumber: bedroomNumber!,
                                                size: int.tryParse(size) ?? 0,
                                                price: int.tryParse(price) ?? 0,
                                                garden: garden,
                                                garage: garage,
                                                electricity24h: electricity24H,
                                                water24h: water24H,
                                                installedAC: installedAC,
                                              );

                                              context.read<
                                                  AddEditDeletePostCubit>()
                                                ..updatePost(postEntity);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              30,
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          child: const Text('Submit'),
                                        );
                                      },
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
