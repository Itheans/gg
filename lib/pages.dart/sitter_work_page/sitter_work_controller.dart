import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:myproject/pages.dart/model/order.dart';

class SitterWorkController extends GetxController {
  TextEditingController orderIdController = TextEditingController();

  final Location location = Location();

  String sitterAddress = '';
  String phoneNumber = '';
  String amountToCollect = '0';
  double customerLatitude = 37.7749;
  double customerLongtitude = -122.4194;
  bool showSitterInfo = false;
  bool isSitterStarted = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference orderCollection;
  late final CollectionReference orderTrackingCollection;

  @override
  void onInit() {
    super.onInit();
    orderCollection = firestore.collection('order');
    orderTrackingCollection = firestore.collection('orderTracking');
    getLocationPermision();
  }

  getOrderById() async {
    try {
      String orderId = orderIdController.text;
      QuerySnapshot querySnapshot =
          await orderCollection.where('id', isEqualTo: orderId).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        MyOrder? order = MyOrder.fromJson(data);
        if (order != null) {
          sitterAddress = order.address ?? '';
          phoneNumber = order.phone ?? '';
          amountToCollect = order.amount.toString();
          customerLatitude = order.latitude ?? 0;
          customerLongtitude = order.longtitude ?? 0;
          showSitterInfo = true;
        }
        update();
      } else {
        Get.snackbar('Error', 'Order not fount');
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    }
  }

  Future<void> getLocationPermision() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void startSitter() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(
          'Location changed: ${currentLocation.latitude}, ${currentLocation.longitude}');
      //? Update order tracking location changes
      saveOrUpdateMyOrderLocation(orderIdController.text,
          currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });
    location.enableBackgroundMode(enable: true);
  }

  Future<void> saveOrUpdateMyOrderLocation(
      String orderId, double latitude, double longtitude) async {
    try {
      final DocumentReference docRef = orderTrackingCollection.doc(orderId);

      await firestore.runTransaction((transection) async {
        final DocumentSnapshot snapshot = await transection.get(docRef);

        if (snapshot.exists) {
          transection.update(docRef, {
            'latitude': latitude,
            'longtitude': longtitude,
          });
        } else {
          transection.set(docRef, {
            'orderId': orderId,
            'latitude': latitude,
            'longtitude': longtitude,
          });
        }
      });
    } catch (e) {
      print('Error saving or updating order location: $e');
    }
  }
}
