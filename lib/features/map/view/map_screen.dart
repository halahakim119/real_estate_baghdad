import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/reusable_rloating_action_button.dart';
import '../controller/location_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  location.LocationData? currentLocation;
  final Set<Marker> _markers = {};
  TextEditingController searchController = TextEditingController();
  bool showCurrentLocation = false;
  FocusNode mapFocusNode = FocusNode();
  final String markerIdValue = 'selectedLocationMarker';
  bool showSuggestions = false;
  CameraPosition _cameraPosition =
      const CameraPosition(target: iraqLocation, zoom: 16);
  bool showMarker = false;
  String placeName = '';
  LatLng markerLatLng = const LatLng(0, 0);
  int maxSuggestions = 5; // Maximum number of suggestions to display
  int loadedSuggestions = 0; // Number of suggestions currently loaded

  @override
  void initState() {
    super.initState();
    getLocation();
    mapFocusNode = FocusNode();
    showSuggestions = false;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void clearSearch() {
    Get.find<LocationController>().clearPredictionList();
    mapFocusNode.requestFocus();
  }

  void addMarker() {
    setState(() {
      if (_markers.isNotEmpty) {
        Marker existingMarker = _markers.first;
        _markers.remove(existingMarker);
        _markers.add(existingMarker.copyWith(
          positionParam: _cameraPosition.target,
          infoWindowParam: InfoWindow(title: searchController.text),
        ));
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(markerIdValue),
            position: _cameraPosition.target,
            infoWindow: InfoWindow(title: searchController.text),
          ),
        );
      }
      showMarker = true;
    });
  }

  void deleteMarker() {
    setState(() {
      _markers.clear();
      showMarker = false;
      placeName = '';
      markerLatLng = const LatLng(0, 0);
    });
  }

  void saveLocation() {
    setState(() {
      placeName = searchController.text;
      markerLatLng = _markers.first.position;
      print('$placeName   $markerLatLng');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          appBar: AppBar(
            title:  AutoSizeText(
              'Real Estate',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                fontFamily: 'Lily_Script_One',
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary
          ),
          body: Stack(
            children: [
              GestureDetector(
                onTap: clearSearch,
                child: Listener(
                  onPointerDown: (_) => clearSearch(),
                  child: GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      onMapCreated: (controller) {
                        mapController = controller;
                        mapFocusNode.requestFocus();
                      },
                      markers: _markers,
                      buildingsEnabled: true,
                      mapType: MapType.normal,
                      rotateGesturesEnabled: true,
                      onCameraMove: (CameraPosition cameraPosition) {
                        setState(() {
                          _cameraPosition = cameraPosition;
                        });
                      }),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.411,
                left: MediaQuery.of(context).size.width * 0.453,
                child: Icon(
                  Icons.add,
                  size: 30,
                  weight: 0.2,
                  color: Colors.grey.shade400,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: TypeAheadField<String>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: searchController,
                            decoration: InputDecoration(
                              prefixIconColor:
                                  Theme.of(context).colorScheme.primary,
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 35, 47, 103),
                              ),
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                color: Theme.of(context).colorScheme.primary,
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  searchPlace();
                                },
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return await locationController.searchLocation(
                                context, pattern);
                          },
                          itemBuilder: (context, String suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          noItemsFoundBuilder: (context) {
                            if (locationController.errorMessage.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  locationController.errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          onSuggestionSelected: (String suggestion) {
                            searchController.text = suggestion;
                            searchPlace();
                          },
                        ),
                      ),
                      if (locationController.errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            locationController.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      else if (locationController.predictionList.isNotEmpty &&
                          showSuggestions)
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount: locationController.predictionList.length,
                            itemBuilder: (context, index) {
                              Prediction prediction =
                                  locationController.predictionList[index];
                              return ListTile(
                                title: Text(prediction.description!),
                                onTap: () {
                                  searchController.text =
                                      prediction.description!;
                                  searchPlace();
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                left: 10,
                child: Visibility(
                  visible: showMarker,
                  child: ReusableFloatingActionButton(
                    onPressed: saveLocation,
                    icon: Icons.check,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 10,
                child: ReusableFloatingActionButton(
                  onPressed: navigateToCurrentLocation,
                  icon: Icons.my_location,
                ),
              ),
              Positioned(
                bottom: 80,
                left: 10,
                child: ReusableFloatingActionButton(
                  onPressed: addMarker,
                  icon: Icons.add_location,
                ),
              ),
              Positioned(
                bottom: 140,
                left: 10,
                child: ReusableFloatingActionButton(
                  onPressed: deleteMarker,
                  icon: Icons.delete,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> searchPlace() async {
    final String searchText = searchController.text;

    if (searchText.isEmpty) {
      return;
    }

    try {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(searchText);

      if (locations.isNotEmpty) {
        String name = searchText;
        geocoding.Location location = locations.first;

        setState(() {
          _cameraPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 16,
          );
          addMarker();
          saveLocation();
          searchController.text = name;
          showSuggestions = false;
        });

        mapController
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
      }
    } catch (e) {
      print('Error searching place: $e');
    }
  }

  void onSuggestionSelected(String suggestion) {
    searchController.text = suggestion;
    searchPlace();
  }

  void loadMoreSuggestions() {
    setState(() {
      maxSuggestions += 5; // Increase the maximum number of suggestions to load
    });
  }

  Future<void> navigateToCurrentLocation() async {
    try {
      location.LocationData currentLocationData =
          await location.Location().getLocation();

      final List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              currentLocationData.latitude!, currentLocationData.longitude!);
      if (placemarks.isNotEmpty) {
        final geocoding.Placemark placemark = placemarks.first;
        final String city = placemark.locality ?? '';
        final String country = placemark.country ?? '';
        final String address = '$city, $country';
        searchController.text =
            address; // Set the search bar text to the address
      }

      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
            currentLocationData.latitude!,
            currentLocationData.longitude!,
          ),
          15,
        ),
      );
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> getLocation() async {
    try {
      final location.Location locationService = location.Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      location.LocationData locationData;

      // Check if location services are enabled
      serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      // Check if the user has granted permission to access their location
      permissionGranted = await Permission.locationWhenInUse.status;
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await Permission.locationWhenInUse.request();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      // Get the current location
      locationData = await locationService.getLocation();

      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);

      mapController.animateCamera(CameraUpdate.newLatLng(latLng));
      setState(() {
        currentLocation = locationData;
        showCurrentLocation = true;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}
