import 'package:flutter/material.dart';

Future<void> navigateToScreenWithPara(
    BuildContext context, Widget screen, Function setState) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );

  if (result == true) {
    setState(() {});
  }
}

Future<void> navigateToScreenNamed(
    BuildContext context, String routeName, Function setState) async {
  final result = await Navigator.pushNamed(context, routeName);

  if (result == true) {
    setState(() {});
  }
}
