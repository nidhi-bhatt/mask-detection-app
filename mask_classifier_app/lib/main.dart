import 'package:flutter/material.dart';
import 'package:mask_classifier/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
