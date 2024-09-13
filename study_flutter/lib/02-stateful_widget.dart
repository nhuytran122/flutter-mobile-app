import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(body: Center(child: MyWidget2(false))),
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class MyWidget2 extends StatefulWidget {
  final bool loading;

  MyWidget2(this.loading);

  @override
  State<MyWidget2> createState() {
    return _MyWidget2State();
  }
}

class _MyWidget2State extends State<MyWidget2> {
  late bool _localLoading;

//run ngay sau khi MyWidget2 run, run trước hàm build
  @override
  void initState() {
    super.initState();
    _localLoading = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return _localLoading
        ? CircularProgressIndicator()
        : FloatingActionButton(onPressed: onClickButton);
  }

  void onClickButton() {
    setState(() {
      _localLoading = true;
    });
  }
}
