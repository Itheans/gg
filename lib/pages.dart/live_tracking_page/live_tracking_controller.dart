import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:myproject/pages.dart/model/order.dart';

class LiveTrackingController extends GetxController {
  MyOrder? myOrder;
  String orderId = '0000';

  LatLng destination = const LatLng(10.2929726, 76.1645936);
  LatLng sitterLocation = const LatLng(10.3225, 76.1526);
  GoogleMapController? mapController;
  BitmapDescriptor markerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
  double remainingDistance = 0.0;
  final Location location = Location();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderTrackingCollection;

  @override
  void onInit() {
    orderTrackingCollection = firestore.collection(('ordertracking'));
    addCustomMarker();
    super.onInit();
  }

  void addCustomMarker() {
    ImageConfiguration configuration =
        const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 1);

    BitmapDescriptor.fromAssetImage(
            configuration, 'assets/images/food_icon.png')
        .then((value) {
      markerIcon = value;
    });
  }

  void updateCurrentLocation(double latitude, double longtitude) {
    destination = LatLng(latitude, longtitude);
    update();
  }

  void statTracking(String orderId) {
    try {
      orderTrackingCollection.doc(orderId).snapshots().listen((snapshot) {
        if (snapshot.exists) {
          var trackingData = snapshot.data() as Map<String, dynamic>;
          double latitude = trackingData['latitude'];
          double longtitude = trackingData['longtitude'];
          updateUIWithlocation(latitude, longtitude);
          print('Latest lacation: $latitude, $longtitude');
        } else {
          print('No tracking data available for order ID: $orderId');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  void updateUIWithlocation(double latitude, double longtitude) {
    sitterLocation = LatLng(latitude, longtitude);

    mapController?.animateCamera(CameraUpdate.newLatLng(sitterLocation));
    calculateRemainingDistance();
  }

  void calculateRemainingDistance() {
    double distance = Geolocator.distanceBetween(sitterLocation.latitude,
        sitterLocation.longitude, destination.latitude, destination.longitude);

    double distanceInkm = distance / 1000;
    remainingDistance = distanceInkm;
    print('Remaining Distance: $distanceInkm kilometers');
    update();
  }
}
