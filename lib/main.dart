import 'package:customer_loyalty/firebase_options.dart';

import 'package:customer_loyalty/screens/web_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   name: 'aquarius-866e2',
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LoyalLoop',
      home: WebScreen(),
    );
  }
}
