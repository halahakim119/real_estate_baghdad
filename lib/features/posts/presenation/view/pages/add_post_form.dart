import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/injection/injection_container.dart';
import '../../../../../core/utils/auth_buttons.dart';
import '../../../../users/data/models/user_model.dart';
import '../../../domain/entities/post_entity.dart';
import '../../logic/cubit/add_edit_delete_post_cubit.dart';
import '../widgets/add_post_widgets.dart';

class AddPostForm extends StatefulWidget {
  const AddPostForm({Key? key}) : super(key: key);

  @override
  _AddPostFormState createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
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
  bool garageChecked = false;
  bool gardenChecked = false;
  bool electricity24HChecked = false;
  bool water24HChecked = false;
  bool installedACChecked = false;
  String? furnishingStatus = 'furnished';
  String? type = 'SALE';
  int bedroomNumber = 0;
  int bathroomNumber = 0;

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

    getUserData();
    userBox.listenable().addListener(_onBoxChange);
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
                automaticallyImplyLeading: false,
                title: const AutoSizeText(
                  'Add A New Post',
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
                        created: (message) {
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
                                title: const Text('failed to add post'),
                                content: Text(failure.message),
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
                              ),
                              const SizedBox(height: 10),
                              AddPostFormCheckboxes(
                                onGarageChecked: onGarageChecked,
                                onGardenChecked: onGardenChecked,
                                onElectricity24HChecked:
                                    onElectricity24HChecked,
                                onWater24HChecked: onWater24HChecked,
                                onInstalledACChecked: onInstalledACChecked,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormRadioButtons(
                                onFurnishingStatusSelected:
                                    onFurnishingStatusChanged,
                                onTypeSelected: onTypeChanged,
                              ),
                              const SizedBox(height: 10),
                              AddPostFormSliders(
                                onBedroomNumberChanged: onBedroomNumberChanged,
                                onBathroomNumberChanged:
                                    onBathroomNumberChanged,
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
                                      created: (message) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Retrieve form field values
                                              String title =
                                                  titleController.text;
                                              String size =
                                                  sizeController.text;
                                              String price =
                                                  priceController.text;
                                              String description =
                                                  descriptionController
                                                      .text;
                                              String province =
                                                  cityValue ?? '';
                                              String categoryType =
                                                  categoryTypeValue ?? '';
                                              bool garage = garageChecked;
                                              bool garden = gardenChecked;
                                              bool electricity24H =
                                                  electricity24HChecked;
                                              bool water24H =
                                                  water24HChecked;
                                              bool installedAC =
                                                  installedACChecked;

                                              // Create the PostEntity object
                                              PostEntity postEntity =
                                                  PostEntity(
                                                title: title,
                                                images: _images,
                                                province: province,
                                                description: description,
                                                furnishingStatus:
                                                    furnishingStatus!,
                                                type: type!,
                                                category: categoryType,
                                                bathroomNumber:
                                                    bathroomNumber,
                                                bedroomNumber:
                                                    bedroomNumber,
                                                size:
                                                    int.tryParse(size) ?? 0,
                                                price:
                                                    int.tryParse(price) ??
                                                        0,
                                                garden: garden,
                                                garage: garage,
                                                electricity24h:
                                                    electricity24H,
                                                water24h: water24H,
                                                installedAC: installedAC,
                                              );

                                              context.read<
                                                  AddEditDeletePostCubit>()
                                                ..createPost(postEntity);
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
                                            backgroundColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                          ),
                                          child: const Text('Submit'),
                                        );
                                      },
                                      loading: () {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 50),
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
                                              bool garage = garageChecked;
                                              bool garden = gardenChecked;
                                              bool electricity24H =
                                                  electricity24HChecked;
                                              bool water24H = water24HChecked;
                                              bool installedAC =
                                                  installedACChecked;

                                              // Create the PostEntity object
                                              PostEntity postEntity =
                                                  PostEntity(
                                                title: title,
                                                images: _images,
                                                province: province,
                                                description: description,
                                                furnishingStatus:
                                                    furnishingStatus!,
                                                type: type!,
                                                category: categoryType,
                                                bathroomNumber: bathroomNumber,
                                                bedroomNumber: bedroomNumber,
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
                                                ..createPost(postEntity);
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
