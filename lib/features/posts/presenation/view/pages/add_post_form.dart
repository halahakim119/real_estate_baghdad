// import 'dart:io';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:image_cropper/image_cropper.dart';
// import '../../../../../core/injection/injection_container.dart';
// import '../../../../authentication/presentation/view/pages/login_screen.dart';
// import '../../../domain/entities/post_entity.dart';
// import '../../logic/bloc/add_edit_delete_post_bloc.dart';
// import '../../../../../core/strings/strings.dart';
// import '../../../../users/data/models/user_model.dart';

// class AddPostForm extends StatefulWidget {
//   const AddPostForm({Key? key}) : super(key: key);

//   @override
//   _AddPostFormState createState() => _AddPostFormState();
// }

// class _AddPostFormState extends State<AddPostForm> {
//   final _formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   final sizeController = TextEditingController();
//   final priceController = TextEditingController();
//   final descriptionController = TextEditingController();

//   Color secondaryColor = Color.fromARGB(255, 224, 209, 151);

//   String? cityValue;
//   String? categoryTypeValue;
//   bool garageChecked = false;
//   bool gardenChecked = false;
//   bool swimmingPoolChecked = false;
//   bool electricity24HChecked = false;
//   bool water24HChecked = false;
//   bool installedACChecked = false;
//   bool dualTitleDeedChecked = false;
//   String? furnishingStatus;
//   String? type;
//   int bedroomNumber = 0;
//   int bathroomNumber = 0;

//   List<File> _images = [];

//   Future<void> pickImage(ImageSource source) async {
//     FocusScope.of(context).requestFocus(FocusNode());
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos
//     ].request();
//     PermissionStatus? statusCamera = statuses[Permission.camera];
//     PermissionStatus? statusStorage = statuses[Permission.storage];
//     PermissionStatus? statusPhotos = statuses[Permission.photos];
//     bool isGranted = statusCamera == PermissionStatus.granted &&
//         statusStorage == PermissionStatus.granted &&
//         statusPhotos == PermissionStatus.granted;
//     if (isGranted) {
//       try {
//         final picker = ImagePicker();
//         final image = await picker.pickImage(source: source);
//         if (image != null) {
//           File? croppedImage = await _cropImage(File(image.path));
//           if (croppedImage != null) {
//             if (_images.length < 4) {
//               setState(() {
//                 _images.add(croppedImage);
//               });
//             } else {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Maximum Limit Reached'),
//                     content: const Text('You can only select up to 4 images.'),
//                     actions: <Widget>[
//                       TextButton(
//                         child: const Text('OK'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//           }
//         }
//       } catch (e) {
//         print('Error picking image: $e');
//       }
//     } else {
//       bool isPermanentlyDenied =
//           statusCamera == PermissionStatus.permanentlyDenied ||
//               statusStorage == PermissionStatus.permanentlyDenied ||
//               statusPhotos == PermissionStatus.permanentlyDenied;
//       if (isPermanentlyDenied) {
//         _showSettingsDialog(context);
//       }
//     }
//   }

//   Future<File?> _cropImage(File image) async {
//     File? croppedFile = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       cropStyle: CropStyle.rectangle,
//       compressFormat: ImageCompressFormat.png,
//       compressQuality: 100,
//       androidUiSettings: const AndroidUiSettings(
//         toolbarTitle: 'Crop Image',
//         toolbarColor: Color.fromARGB(255, 35, 47, 103),
//         toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary
//         initAspectRatio: CropAspectRatioPreset.square,
//         lockAspectRatio: true,
//       ),
//       iosUiSettings: const IOSUiSettings(
//         title: 'Crop Image',
//       ),
//     );
//     return croppedFile;
//   }

//   void _showSettingsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Permission Required'),
//           content: const Text(
//               'Please grant camera and storage permissions from settings.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Settings'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 openAppSettings();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void deleteImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   void _clearFormFields() {
//     titleController.clear();
//     sizeController.clear();
//     priceController.clear();
//     descriptionController.clear();
//     cityValue = null;
//     categoryTypeValue = null;
//     garageChecked = false;
//     gardenChecked = false;
//     swimmingPoolChecked = false;
//     electricity24HChecked = false;
//     water24HChecked = false;
//     installedACChecked = false;
//     dualTitleDeedChecked = false;
//     furnishingStatus = null;
//     bedroomNumber = 0;
//     bathroomNumber = 0;
//     _images.clear();
//     type = null;
//   }

//   @override
//   void dispose() {
//     userBox.listenable().removeListener(_onBoxChange);
//     super.dispose();
//   }

//   void _onBoxChange() {
//     setState(() {
//       getUserData();
//     });
//   }

//   UserModel? user;
//   final userBox = Hive.box<UserModel>('userBox');

//   @override
//   void initState() {
//     super.initState();

//     getUserData();
//     userBox.listenable().addListener(_onBoxChange);
//   }

//   void getUserData() {
//     if (!userBox.isEmpty) {
//       user = userBox.getAt(0);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: AutoSizeText(
//           'Add A New Post',
//           style: TextStyle(
//             color: Color.fromARGB(255, 35, 47, 103),
//             fontFamily: 'Lily_Script_One',
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.onPrimary
//         elevation: 0,
//         toolbarHeight: 70,
//         bottom: PreferredSize(
//           preferredSize: Size.zero,
//           child: Divider(
//             height: 1,
//             color: Color.fromARGB(255, 138, 78, 24),
//           ),
//         ),
//         actions: [],
//       ),
//       body: userBox.isEmpty
//           ? LoginScreen()
//           : BlocProvider(
//               create: (context) => sl<AddEditDeletePostBloc>(),
//               child: BlocBuilder<AddEditDeletePostBloc, AddEditDeletePostState>(
//                 builder: (context, state) {
//                   return Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Form(
//                         key: _formKey, // Add the form key to the Form widget
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             const Text(
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.grey),
//                               softWrap: true,
//                               textAlign: TextAlign.justify,
//                               "Please provide accurate details and adhere to our policies when submitting your post. Select appropriate options, check relevant checkboxes, and ensure truthful descriptions, prices, and sizes.",
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             const Text("Add image/s"),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             _images.isEmpty
//                                 ? SizedBox(height: 10)
//                                 : CarouselSlider(
//                                     items: _images.map(
//                                       (image) {
//                                         final imageWidget = Image.file(
//                                           image,
//                                           fit: BoxFit.cover,
//                                         );
//                                         return Stack(
//                                           children: [
//                                             imageWidget,
//                                             Positioned(
//                                                 top: 5,
//                                                 right: 5,
//                                                 child: CircleAvatar(
//                                                   backgroundColor:
//                                                       secondaryColor,
//                                                 )),
//                                             Positioned(
//                                               top: 1,
//                                               right: 1,
//                                               child: IconButton(
//                                                 icon: const Icon(Icons.delete),
//                                                 color: Theme.of(context).colorScheme.onPrimary
//                                                 onPressed: () => deleteImage(
//                                                     _images.indexOf(image)),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ).toList(),
//                                     options: CarouselOptions(
//                                       height: 230,
//                                       enlargeCenterPage: true,
//                                       enableInfiniteScroll: false,
//                                     ),
//                                   ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 50,
//                                     margin: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: secondaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     width: 100,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.photo_library),
//                                       onPressed: () =>
//                                           pickImage(ImageSource.gallery),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     height: 50,
//                                     margin: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: secondaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     width: 100,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.camera),
//                                       onPressed: () =>
//                                           pickImage(ImageSource.camera),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             TextFormField(
//                               controller: titleController,
//                               keyboardType: TextInputType.text,
//                               decoration: const InputDecoration(
//                                 labelText: 'Title',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter the title';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             TextFormField(
//                               controller: sizeController,
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 labelText: 'Size',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter the size';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             TextFormField(
//                               controller: priceController,
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 labelText: 'Price',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter the price';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             TextFormField(
//                               controller: descriptionController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Description',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             DropdownButtonFormField<String>(
//                               value: cityValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   cityValue = value ?? '';
//                                 });
//                                 // Handle city selection
//                               },
//                               decoration: const InputDecoration(
//                                 labelText: 'Province',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                               items: provinces
//                                   .map(
//                                     (city) => DropdownMenuItem(
//                                       value: city,
//                                       child: Text(city),
//                                     ),
//                                   )
//                                   .toList(),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the province';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             DropdownButtonFormField<String>(
//                               value: categoryTypeValue,
//                               onChanged: (value) {
//                                 setState(() {
//                                   categoryTypeValue = value ?? '';
//                                 });
//                                 // Handle category type selection
//                               },
//                               decoration: const InputDecoration(
//                                 labelText: 'Category Type',
//                                 contentPadding:
//                                     EdgeInsets.only(top: 5, left: 5, bottom: 5),
//                                 border: OutlineInputBorder(),
//                               ),
//                               items: categoryTypes
//                                   .map(
//                                     (type) => DropdownMenuItem(
//                                       value: type,
//                                       child: Text(type),
//                                     ),
//                                   )
//                                   .toList(),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please select the category type';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             if (categoryTypeValue == 'Other') ...[
//                               const SizedBox(height: 10),
//                               TextFormField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     categoryTypeValue = value;
//                                   });
//                                 },
//                                 decoration: const InputDecoration(
//                                   labelText: 'Enter Category Type',
//                                   contentPadding: EdgeInsets.only(
//                                       top: 5, left: 5, bottom: 5),
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter the category type';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ],
//                             const SizedBox(height: 10),
//                             CheckboxListTile(
//                               title: const Text('Garage'),
//                               value: garageChecked,
//                               activeColor: secondaryColor,
//                               onChanged: (value) {
//                                 setState(() {
//                                   garageChecked = value ?? false;
//                                 });
//                                 // Handle garage checkbox
//                               },
//                             ),
//                             CheckboxListTile(
//                               title: const Text('Garden'),
//                               activeColor: secondaryColor,
//                               value: gardenChecked,
//                               onChanged: (value) {
//                                 setState(() {
//                                   gardenChecked = value ?? false;
//                                 });
//                                 // Handle garden checkbox
//                               },
//                             ),
//                             CheckboxListTile(
//                               title: const Text('Electricity 24H'),
//                               activeColor: secondaryColor,
//                               value: electricity24HChecked,
//                               onChanged: (value) {
//                                 setState(() {
//                                   electricity24HChecked = value ?? false;
//                                 });
//                                 // Handle electricity 24H checkbox
//                               },
//                             ),
//                             CheckboxListTile(
//                               title: const Text('Water 24H'),
//                               activeColor: secondaryColor,
//                               value: water24HChecked,
//                               onChanged: (value) {
//                                 setState(() {
//                                   water24HChecked = value ?? false;
//                                 });
//                                 // Handle water 24H checkbox
//                               },
//                             ),
//                             CheckboxListTile(
//                               title: const Text('Installed AC'),
//                               activeColor: secondaryColor,
//                               value: installedACChecked,
//                               onChanged: (value) {
//                                 setState(() {
//                                   installedACChecked = value ?? false;
//                                 });
//                                 // Handle installed AC checkbox
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: RadioListTile<String>(
//                                     title: const Text(
//                                       'Furnished',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     activeColor: secondaryColor,
//                                     value: 'furnished',
//                                     groupValue: furnishingStatus,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         furnishingStatus = value ?? '';
//                                       });
//                                       // Handle furnished radio button
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: RadioListTile<String>(
//                                     title: const Text(
//                                       'unfurnished',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     activeColor: secondaryColor,
//                                     value: 'Unfurnished',
//                                     groupValue: furnishingStatus,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         furnishingStatus = value ?? '';
//                                       });
//                                       // Handle not furnished radio button
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: RadioListTile<String>(
//                                     title: const Text(
//                                       'SALE',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     activeColor: secondaryColor,
//                                     value: 'SALE',
//                                     groupValue: type,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         type = value ?? '';
//                                       });
//                                       // Handle furnished radio button
//                                     },
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: RadioListTile<String>(
//                                     title: const Text(
//                                       'RENT',
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                     activeColor: secondaryColor,
//                                     value: 'RENT',
//                                     groupValue: type,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         type = value ?? '';
//                                       });
//                                       // Handle not furnished radio button
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             const Text('Bedroom Number'),
//                             Slider(
//                               activeColor: secondaryColor,
//                               thumbColor: secondaryColor,
//                               inactiveColor: Colors.grey.shade200,
//                               value: bedroomNumber.toDouble(),
//                               min: 0,
//                               max: 10,
//                               label: bedroomNumber.toString(),
//                               divisions: 10,
//                               onChanged: (value) {
//                                 setState(() {
//                                   bedroomNumber = value.toInt();
//                                 });
//                                 // Handle bedroom number slider
//                               },
//                             ),
//                             const SizedBox(height: 10),
//                             const Text('Bathroom Number'),
//                             Slider(
//                               activeColor: secondaryColor,
//                               thumbColor: secondaryColor,
//                               inactiveColor: Colors.grey.shade200,
//                               value: bathroomNumber.toDouble(),
//                               min: 0,
//                               max: 10,
//                               label: bathroomNumber.toString(),
//                               divisions: 10,
//                               onChanged: (value) {
//                                 setState(() {
//                                   bathroomNumber = value.toInt();
//                                 });
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             Wrap(
//                               crossAxisAlignment: WrapCrossAlignment.center,
//                               alignment: WrapAlignment.spaceBetween,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _clearFormFields();
//                                     });
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                       fixedSize: Size(
//                                           MediaQuery.of(context).size.width *
//                                               0.4,
//                                           30),
//                                       backgroundColor: secondaryColor),
//                                   child: const Text('clear'),
//                                 ),
//                                 BlocBuilder<AddEditDeletePostBloc,
//                                     AddEditDeletePostState>(
//                                   builder: (context, state) {
//                                     return ElevatedButton(
//                                       onPressed: () {
//                                         if (_formKey.currentState!.validate()) {
//                                           PostEntity postEntity = PostEntity(
//                                             title: titleController.text,
//                                             images: _images,
//                                             province: cityValue ?? '',
//                                             overview:
//                                                 descriptionController.text,
//                                             furnishingStatus:
//                                                 furnishingStatus ?? '',
//                                             postType: type ?? '',
//                                             categoryType:
//                                                 categoryTypeValue ?? '',
//                                             bathroomNum: bathroomNumber,
//                                             bedroomNum: bedroomNumber,
//                                             size: double.tryParse(
//                                                     sizeController.text) ??
//                                                 0,
//                                             price: double.tryParse(
//                                                     priceController.text) ??
//                                                 0,
//                                             garden: gardenChecked,
//                                             garage: garageChecked,
//                                             electricity24H:
//                                                 electricity24HChecked,
//                                             water24H: water24HChecked,
//                                             installedAC: installedACChecked,
//                                           );

//                                           AddEditDeletePostBloc
//                                               addEditDeletePostBloc =
//                                               sl<AddEditDeletePostBloc>();
//                                           addEditDeletePostBloc
//                                               .add(CreatePostEvent(postEntity));
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                           fixedSize: Size(
//                                               MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.4,
//                                               30),
//                                           backgroundColor: const Color.fromARGB(
//                                               255, 35, 47, 103)),
//                                       child: const Text('Submit'),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../../core/injection/injection_container.dart';
// import '../../../../authentication/presentation/view/pages/login_screen.dart';
// import '../../../../users/data/models/user_model.dart';
// import '../../../domain/entities/post_entity.dart';
// import '../../logic/bloc/add_edit_delete_post_bloc.dart';
// import '../widgets/add_post_widgets.dart';

// class AddPostForm extends StatefulWidget {
//   const AddPostForm({Key? key}) : super(key: key);

//   @override
//   _AddPostFormState createState() => _AddPostFormState();
// }

// class _AddPostFormState extends State<AddPostForm> {
//   final _formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   final sizeController = TextEditingController();
//   final priceController = TextEditingController();
//   final descriptionController = TextEditingController();

//   Color secondaryColor = Color.fromARGB(255, 224, 209, 151);

//   String? cityValue;
//   String? categoryTypeValue;
//   bool garageChecked = false;
//   bool gardenChecked = false;
//   bool swimmingPoolChecked = false;
//   bool electricity24HChecked = false;
//   bool water24HChecked = false;
//   bool installedACChecked = false;
//   bool dualTitleDeedChecked = false;
//   String? furnishingStatus;
//   String? type;
//   int bedroomNumber = 0;
//   int bathroomNumber = 0;

//   List<File> _images = [];

//   Future<void> pickImage(ImageSource source) async {
//     FocusScope.of(context).requestFocus(FocusNode());
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos
//     ].request();
//     PermissionStatus? statusCamera = statuses[Permission.camera];
//     PermissionStatus? statusStorage = statuses[Permission.storage];
//     PermissionStatus? statusPhotos = statuses[Permission.photos];
//     bool isGranted = statusCamera == PermissionStatus.granted &&
//         statusStorage == PermissionStatus.granted &&
//         statusPhotos == PermissionStatus.granted;
//     if (isGranted) {
//       try {
//         final picker = ImagePicker();
//         final image = await picker.pickImage(source: source);
//         if (image != null) {
//           File? croppedImage = await _cropImage(File(image.path));
//           if (croppedImage != null) {
//             if (_images.length < 4) {
//               setState(() {
//                 _images.add(croppedImage);
//               });
//             } else {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text('Maximum Limit Reached'),
//                     content: const Text('You can only select up to 4 images.'),
//                     actions: <Widget>[
//                       TextButton(
//                         child: const Text('OK'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//           }
//         }
//       } catch (e) {
//         print('Error picking image: $e');
//       }
//     } else {
//       bool isPermanentlyDenied =
//           statusCamera == PermissionStatus.permanentlyDenied ||
//               statusStorage == PermissionStatus.permanentlyDenied ||
//               statusPhotos == PermissionStatus.permanentlyDenied;
//       if (isPermanentlyDenied) {
//         _showSettingsDialog(context);
//       }
//     }
//   }

//   Future<File?> _cropImage(File image) async {
//     File? croppedFile = await ImageCropper().cropImage(
//       sourcePath: image.path,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       cropStyle: CropStyle.rectangle,
//       compressFormat: ImageCompressFormat.png,
//       compressQuality: 100,
//       androidUiSettings: const AndroidUiSettings(
//         toolbarTitle: 'Crop Image',
//         toolbarColor: Color.fromARGB(255, 35, 47, 103),
//         toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary
//         initAspectRatio: CropAspectRatioPreset.square,
//         lockAspectRatio: true,
//       ),
//       iosUiSettings: const IOSUiSettings(
//         title: 'Crop Image',
//       ),
//     );
//     return croppedFile;
//   }

//   void _showSettingsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Permission Required'),
//           content: const Text(
//               'Please grant camera and storage permissions from settings.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Settings'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 openAppSettings();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void deleteImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }

//   void _clearFormFields() {
//     titleController.clear();
//     sizeController.clear();
//     priceController.clear();
//     descriptionController.clear();
//     cityValue = null;
//     categoryTypeValue = null;
//     garageChecked = false;
//     gardenChecked = false;
//     swimmingPoolChecked = false;
//     electricity24HChecked = false;
//     water24HChecked = false;
//     installedACChecked = false;
//     dualTitleDeedChecked = false;
//     furnishingStatus = null;
//     bedroomNumber = 0;
//     bathroomNumber = 0;
//     _images.clear();
//     type = null;
//   }

//   @override
//   void dispose() {
//     userBox.listenable().removeListener(_onBoxChange);
//     super.dispose();
//   }

//   void _onBoxChange() {
//     setState(() {
//       getUserData();
//     });
//   }

//   UserModel? user;
//   final userBox = Hive.box<UserModel>('userBox');

//   @override
//   void initState() {
//     super.initState();

//     getUserData();
//     userBox.listenable().addListener(_onBoxChange);
//   }

//   void getUserData() {
//     if (!userBox.isEmpty) {
//       user = userBox.getAt(0);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: AutoSizeText(
//           'Add A New Post',
//           style: TextStyle(
//             color: Color.fromARGB(255, 35, 47, 103),
//             fontFamily: 'Lily_Script_One',
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Theme.of(context).colorScheme.onPrimary
//         elevation: 0,
//         toolbarHeight: 70,
//         bottom: PreferredSize(
//           preferredSize: Size.zero,
//           child: Divider(
//             height: 1,
//             color: Color.fromARGB(255, 138, 78, 24),
//           ),
//         ),
//         actions: [],
//       ),
//       body: userBox.isEmpty
//           ? LoginScreen()
//           : BlocProvider(
//               create: (context) => sl<AddEditDeletePostBloc>(),
//               child: BlocBuilder<AddEditDeletePostBloc, AddEditDeletePostState>(
//                 builder: (context, state) {
//                   return Container(
//                     height: MediaQuery.of(context).size.height,
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             const AddPostFormText(),
//                             const SizedBox(height: 20),
//                             const AddPostFormImages(),
//                             const SizedBox(height: 10),
//                             _images.isEmpty
//                                 ? SizedBox(height: 10)
//                                 : CarouselSlider(
//                                     items: _images.map(
//                                       (image) {
//                                         final imageWidget = Image.file(
//                                           image,
//                                           fit: BoxFit.cover,
//                                         );
//                                         return Stack(
//                                           children: [
//                                             imageWidget,
//                                             Positioned(
//                                                 top: 5,
//                                                 right: 5,
//                                                 child: CircleAvatar(
//                                                   backgroundColor:
//                                                       secondaryColor,
//                                                 )),
//                                             Positioned(
//                                               top: 1,
//                                               right: 1,
//                                               child: IconButton(
//                                                 icon: const Icon(Icons.delete),
//                                                 color: Theme.of(context).colorScheme.onPrimary
//                                                 onPressed: () => deleteImage(
//                                                     _images.indexOf(image)),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ).toList(),
//                                     options: CarouselOptions(
//                                       height: 230,
//                                       enlargeCenterPage: true,
//                                       enableInfiniteScroll: false,
//                                     ),
//                                   ),
//                             const SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     height: 50,
//                                     margin: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: secondaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     width: 100,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.photo_library),
//                                       onPressed: () =>
//                                           pickImage(ImageSource.gallery),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     height: 50,
//                                     margin: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       color: secondaryColor,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     width: 100,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.camera),
//                                       onPressed: () =>
//                                           pickImage(ImageSource.camera),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             AddPostFormFields(
//                               titleController: titleController,
//                               sizeController: sizeController,
//                               priceController: priceController,
//                               descriptionController: descriptionController,
//                             ),
//                             const SizedBox(height: 10),
//                             const AddPostFormDropdowns(),
//                             const SizedBox(height: 10),
//                             const AddPostFormCheckboxes(),
//                             const SizedBox(height: 10),
//                             const AddPostFormRadioButtons(),
//                             const SizedBox(height: 10),
//                             const AddPostFormSliders(),
//                             const SizedBox(height: 10),
//                             AddPostFormClearSubmitButtons(
//                               onClearPressed: () {
//                                 setState(() {
//                                   _clearFormFields();
//                                 });
//                               },
//                               onSubmitPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   PostEntity postEntity = PostEntity(
//                                     title: titleController.text,
//                                     images: _images,
//                                     province: cityValue ?? '',
//                                     overview: descriptionController.text,
//                                     furnishingStatus: furnishingStatus ?? '',
//                                     postType: type ?? '',
//                                     categoryType: categoryTypeValue ?? '',
//                                     bathroomNum: bathroomNumber,
//                                     bedroomNum: bedroomNumber,
//                                     size:
//                                         double.tryParse(sizeController.text) ??
//                                             0,
//                                     price:
//                                         double.tryParse(priceController.text) ??
//                                             0,
//                                     garden: gardenChecked,
//                                     garage: garageChecked,
//                                     electricity24H: electricity24HChecked,
//                                     water24H: water24HChecked,
//                                     installedAC: installedACChecked,
//                                   );

//                                   AddEditDeletePostBloc addEditDeletePostBloc =
//                                       sl<AddEditDeletePostBloc>();
//                                   addEditDeletePostBloc
//                                       .add(CreatePostEvent(postEntity));
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }

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
import '../../../../authentication/presentation/view/pages/login_screen.dart';
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

  Color secondaryColor = Color.fromARGB(255, 224, 209, 151);

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

  List<File> _images = [];
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
    if (!userBox.isEmpty) {
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
      androidUiSettings:  AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor:const Color.fromARGB(255, 35, 47, 103),
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

  void onSubmitPressed() {
    if (_formKey.currentState!.validate()) {
      // Retrieve form field values
      String title = titleController.text;
      String size = sizeController.text;
      String price = priceController.text;
      String description = descriptionController.text;
      String province = cityValue ?? '';
      String categoryType = categoryTypeValue ?? '';
      bool garage = garageChecked;
      bool garden = gardenChecked;
      bool electricity24H = electricity24HChecked;
      bool water24H = water24HChecked;
      bool installedAC = installedACChecked;

      // Create the PostEntity object
      PostEntity postEntity = PostEntity(
        title: title,
        images: _images,
        province: province,
        overview: description,
        furnishingStatus: furnishingStatus!,
        postType: type!,
        categoryType: categoryType,
        bathroomNum: bathroomNumber,
        bedroomNum: bedroomNumber,
        size: double.tryParse(size) ?? 0,
        price: double.tryParse(price) ?? 0,
        garden: garden,
        garage: garage,
        electricity24H: electricity24H,
        water24H: water24H,
        installedAC: installedAC,
      );

      // Pass the PostEntity object to the cubit for further processing
      AddEditDeletePostCubit addEditDeletePostCubit =
          sl<AddEditDeletePostCubit>();
      addEditDeletePostCubit.createPost(postEntity);
    }
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AutoSizeText(
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
            color: Color.fromARGB(255, 138, 78, 24),
          ),
        ),
        actions: [],
      ),
      body: userBox.isEmpty
          ? LoginScreen()
          : BlocProvider(
              create: (context) => sl<AddEditDeletePostCubit>(),
              child:
                  BlocConsumer<AddEditDeletePostCubit, AddEditDeletePostState>(
                listener: (context, state) {
                  state.maybeWhen(
                    created: (message) {
                      // Show success message and navigate to the desired screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      // Clear the form fields
                      _clearFormFields();
                    },
                    error: (failure) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(failure.toString()),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
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
                                ? SizedBox(height: 10)
                                : CarouselSlider(
                                    items: _images.map(
                                      (image) {
                                        final imageWidget = Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                        );
                                        return Stack(
                                          children: [
                                            imageWidget,
                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: CircleAvatar(
                                                backgroundColor: secondaryColor,
                                              ),
                                            ),
                                            Positioned(
                                              top: 1,
                                              right: 1,
                                              child: IconButton(
                                                icon: const Icon(Icons.delete),
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                onPressed: () => deleteImage(
                                                  _images.indexOf(image),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
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
                                      color: secondaryColor,
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
                                      color: secondaryColor,
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
                              onElectricity24HChecked: onElectricity24HChecked,
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
                              onBathroomNumberChanged: onBathroomNumberChanged,
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
                                      MediaQuery.of(context).size.width * 0.4,
                                      30,
                                    ),
                                    backgroundColor: secondaryColor,
                                  ),
                                  child: const Text('clear'),
                                ),
                                BlocBuilder<AddEditDeletePostCubit,
                                    AddEditDeletePostState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      onPressed: onSubmitPressed,
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                          30,
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 35, 47, 103),
                                      ),
                                      child: const Text('Submit'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
