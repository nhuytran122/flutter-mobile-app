import 'package:flutter/material.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        height: 400,
        decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 7, 7)),
        child: Center(
            child: Icon(
          Icons.star,
          color: Colors.yellow,
          size: 200,
        )),
      ),
    );
  }
}
