import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myproject/pages.dart/buttomnav.dart';
import 'package:myproject/pages.dart/chat.dart';
import 'package:myproject/pages.dart/chatpage.dart';
import 'package:myproject/pages.dart/firebase_options.dart';
import 'package:myproject/pages.dart/home.dart';
import 'package:myproject/pages.dart/login.dart';
import 'package:myproject/pages.dart/mappage.dart';
import 'package:myproject/pages.dart/onboard.dart';
import 'package:myproject/pages.dart/order_list/order_list.dart';
import 'package:myproject/pages.dart/sigup.dart';
import 'package:myproject/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}
