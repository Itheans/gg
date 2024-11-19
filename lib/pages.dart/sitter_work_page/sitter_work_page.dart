import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/pages.dart/sitter_work_page/sitter_work_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SitterWorkPage extends StatelessWidget {
  const SitterWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SitterWorkController>(
      init: SitterWorkController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sitter Work App'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Image.network(
                  'C:\Users\ithean\Downloads\ProjectCs\images/cat.png',
                  width: 200,
                  height: 200,
                ),
                const Text(
                  'Enter myOrder ID:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: controller.orderIdController,
                  decoration: const InputDecoration(
                    hintText: 'MyOrder ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !controller.showSitterInfo,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.getOrderById();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white),
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: controller.showSitterInfo,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Sitter Address: ${controller.sitterAddress}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Number: ${controller.phoneNumber}',
                            style: TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () {
                              launch('tel:${controller.phoneNumber}');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Amount to Collect: \$ ${controller.amountToCollect}',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'http://www.google.com/map?q=${controller.customerLatitude},${controller.customerLongtitude}'));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white),
                            icon: Icon(Icons.location_on),
                            label: Text('Show Location'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.startSitter();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Start Sitter'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
