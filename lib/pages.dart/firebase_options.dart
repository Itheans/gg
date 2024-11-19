import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: "AIzaSyBPVAvC6jzHCb3gjS30_Gp-HuQzsiRSHHU",
        appId: "1:365501726038:android:877335f116dc518cc56af7",
        messagingSenderId: "365501726038",
        projectId: "projectcs-ba6e3",
      )
    : const FirebaseOptions(
        apiKey: "AIzaSyAEQiZ25b5Sx6eJegZsnnphOcxsCkp7ZaE",
        appId: "1:365501726038:android:877335f116dc518cc56af7",
        messagingSenderId: "365501726038",
        projectId: "projectcs-ba6e3",
      );
