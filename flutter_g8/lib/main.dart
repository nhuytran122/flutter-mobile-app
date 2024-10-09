import 'package:flutter_g8/my_classroom.dart';
import 'package:flutter_g8/my_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_g8/my_idol.dart';
import 'package:flutter_g8/my_place.dart';
import 'package:flutter_g8/my_productlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyProductList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
