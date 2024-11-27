import 'package:flutter/material.dart';

final formkey = GlobalKey<FormState>();
@override
Widget build(BuildContext context) {
  // Build a Form widget using the formkey created above.
  return Form(
    key: formkey,
    child: Column(
      children: <Widget>[
      // Add TextFormFields and ElevatedButton here.
      ],
    ),
  );
}
