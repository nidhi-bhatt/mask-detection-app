import 'package:flutter/material.dart';
import 'package:mask_classification_app/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
