import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/router/router.gr.dart';
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
                context.read<ImageBloc>()..add(PickImageEvent());
              },
              child: Text('Pick Image'),
            ),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                if (state is ImageLoading) {
                  return CircularProgressIndicator();
                } else if (state is ImageLoaded) {
                  return Image.file(File(state.image.imagePath));
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
}
