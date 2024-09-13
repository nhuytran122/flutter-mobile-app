import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: MyWidget(),
    ),
  ));
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'For decades, conventional wisdom held that reading comprehension '
      'depended on the acquisition of isolatable, teachable, and generalizable '
      'skills, such as “finding the main idea.” This notion led to the widespread '
      'adoption of many dubious practices, often united in the “workshop model,” '
      'including giving students their choice of books that supposedly matched their '
      'reading level, devoting large stretches of class time to “sustained silent '
      'independent reading,” and focusing too much attention on reading comprehension '
      '“skills and strategies.',
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.justify,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.5,
    );
  }
}
