import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hr/constant.dart';
import 'package:intl/intl.dart';

class LocationController extends GetxController {
  RxString? currentAddress = "Location not found".obs;
  Position? currentPosition;
  RxBool isLoading = false.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      flutterToastMsg(
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        flutterToastMsg('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      flutterToastMsg(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    isLoading.value = true;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      lat.value = currentPosition!.latitude;
      long.value = currentPosition!.longitude;
      _getAddressFromLatLng(currentPosition!);
      isLoading.value = false;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress!.value =
          '${place.street}, ${place.locality}, ${place.subAdministrativeArea},${"\n"}${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
