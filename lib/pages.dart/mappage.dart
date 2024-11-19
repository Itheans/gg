import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/pages.dart/add_order/add_order.dart';
import 'package:myproject/pages.dart/sitter_work_page/sitter_work_page.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Get.to(const AddOrderPage());
              },
              child: const Text('Client App'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: () {
                Get.to(const SitterWorkPage());
              },
              child: const Text('Delivery Boy App'),
            ),
          ],
        ),
      ),
    );
  }
}
