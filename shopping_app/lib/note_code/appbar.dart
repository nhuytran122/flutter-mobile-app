import 'package:flutter/material.dart';
import 'package:shopping_app/components/appbar.dart';

CustomAppBar myAppBar(BuildContext context, String title) {
  return CustomAppBar(
    title: title,
    onBackPressed: () {
      Navigator.pop(context, true);
    },
  );
}
