import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:http/http.dart' as http;

const LatLng iraqLocation = LatLng(33.3152, 44.3661);

class LocationController extends GetxController {
  late Placemark _pickPlaceMark;
  Placemark get pickPlaceMark => _pickPlaceMark;
  List<Prediction> predictionList = [];
  void clearPredictionList() {
    predictionList.clear();
    update();
  }

  void updatePredictionList(List<Prediction> newPredictionList) {
    predictionList = newPredictionList;
    update();
  }

  String errorMessage = '';

  Future<List<String>> searchLocation(
    BuildContext context,
    String text,
  ) async {
    if (text.isNotEmpty) {
      try {
        var data = await getLocationData(text);
        if (data != null) {
          predictionList = data.map<Prediction>((prediction) {
            return Prediction.fromJson(prediction);
          }).toList();
          errorMessage = '';
        } else {
          predictionList = [];
          errorMessage =
              'Could not find any result for the supplied address or coordinates.';
        }
      } catch (_) {
        errorMessage =
            'Could not find any result for the supplied address or coordinates.';
        predictionList = [];
      }
    } else {
      predictionList = [];
      errorMessage = '';
    }
    return predictionList
        .map((prediction) => prediction.description!)
        .toList();
  }

  Future<List<dynamic>> getLocationData(String text) async {
    final response = await http.get(
      Uri.parse(
          "http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        return data['predictions'];
      } else {
        throw Exception('Error: ${data['status']}');
      }
    } else {
      throw Exception('Failed to retrieve location data.');
    }
  }
}
