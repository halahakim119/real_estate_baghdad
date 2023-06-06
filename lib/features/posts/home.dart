
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router/router.gr.dart';
import 'domain/repositories/image_repository.dart';
import 'presenation/logic/bloc/image_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ImageBloc>().add(PickImageEvent());
              },
              child: Text('Pick Image'),
            ),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is ImageLoading) {
                  return CircularProgressIndicator();
                } else if (state is ImageLoaded) {
                  return Column(
                    children: [
                      Image.file(File(state.image.path)),
                      ElevatedButton(
                        onPressed: () {
                          // Call the upload image function here
                          _uploadImage(context, state.image);
                        },
                        child: Text('Upload Image'),
                      ),
                    ],
                  );
                } else if (state is ImageError) {
                  return Text(state.errorMessage);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 35, 47, 103),
        onPressed: () {
          context.router.push(const MapRoute());
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void _uploadImage(BuildContext context, File image) async {
    // You can use the ImageRepository or create a dedicated UploadImageUseCase for this
    final imageRepository = context.read<ImageRepository>();
    final isUploaded = await imageRepository.uploadImage(image);

    if (isUploaded) {
      // Image uploaded successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image uploaded successfully'),
        ),
      );
    } else {
      // Failed to upload image
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image'),
        ),
      );
    }
  }
}