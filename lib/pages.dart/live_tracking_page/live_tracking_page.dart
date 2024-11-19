import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myproject/pages.dart/live_tracking_page/live_tracking_controller.dart';
import 'package:myproject/pages.dart/model/order.dart';

class LiveTrackingPage extends StatelessWidget {
  const LiveTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arg = Get.arguments;
    MyOrder order = arg['order'];

    return GetBuilder<LiveTrackingController>(
        init: LiveTrackingController(),
        builder: (controller) {
          controller.myOrder = order;
          controller.updateCurrentLocation(order.latitude!, order.longtitude!);
          controller.statTracking(order.id!);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Order Tracking'),
            ),
            body: Stack(
              children: [
                GoogleMap(
                    mapType: MapType.normal,
                    onMapCreated: (mpCtrl) {
                      controller.mapController = mpCtrl;
                    },
                    initialCameraPosition: CameraPosition(
                      target: controller.sitterLocation,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('destination'),
                        position: controller.destination,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue),
                        infoWindow: InfoWindow(
                          title: 'Destination',
                          snippet:
                              'Lat: ${controller.destination.latitude}, Lng: ${controller.destination.longitude}',
                        ),
                      ),
                      Marker(
                          markerId: const MarkerId('sitter'),
                          position: controller.sitterLocation,
                          icon: controller.markerIcon,
                          infoWindow: InfoWindow(
                              title: 'Sitter',
                              snippet:
                                  'Lat: ${controller.sitterLocation.latitude}, Lng: ${controller.sitterLocation.longitude}'))
                    }),
                Positioned(
                  top: 16.0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "Renaining Distance: ${controller.remainingDistance.toStringAsFixed(2)} kilometers",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
