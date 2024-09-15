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
    return Container(
      margin: EdgeInsets.all(10),
      child: ElevatedButton.icon(
          onPressed: () {
            print('Click the Elevated Button');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            // minimumSize: Size(240, 80),
            padding: EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 10,
            shadowColor: Colors.black.withOpacity(0.5),
            side: BorderSide(width: 3, color: Colors.yellow),
            // disabledBackgroundColor: Colors.black,
            // disabledForegroundColor: Colors.grey,
          ),
          icon: Icon(
            Icons.edit,
            size: 30,
          ),
          label: Text(
            'Elevated Button',
            style: TextStyle(fontSize: 28),
          )),
    );
  }
}
