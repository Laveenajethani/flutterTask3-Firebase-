import 'package:api_task/screens/API.dart';
import 'package:api_task/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: API(),
    initialRoute: "home",
    routes: {
      "home": (context) => MyHome(),
      "api": (context) => API(),
    },
       
    debugShowCheckedModeBanner: false,
  ));
}
