import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myproject/pages.dart/model/order.dart';

class AddOrderController extends GetxController {
  TextEditingController orderIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  GoogleMapController? mapController;
  LatLng currentLocation = const LatLng(0, 0);
  LatLng selectedLocation = const LatLng(0, 0);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  @override
  Future<void> onInit() async {
    orderCollection = firestore.collection('order');
    super.onInit();
  }

  void addOrder(BuildContext context) {
    try {
      if (nameController.text.isEmpty ||
          orderIdController.text.isEmpty ||
          amountController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Pleas fil filed')));
        return;
      } else {
        DocumentReference doc = orderCollection.doc(orderIdController.text);
        MyOrder order = MyOrder(
          id: doc.id,
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          latitude: selectedLocation!.latitude.toDouble(),
          longtitude: selectedLocation!.longitude.toDouble(),
          amount: double.parse(amountController.text),
        );
        final orderJson = order.toJson();
        doc.set(orderJson);
        clearTextFields();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order added successfully')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to add order')));
      rethrow;
    }
  }

  clearTextFields() {
    orderIdController.clear();
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    amountController.clear();
  }
}
