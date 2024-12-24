import 'package:flutter/material.dart';
import 'package:shopping_app/entity/user.dart';

class UserProvider with ChangeNotifier {
  User? _userData;

  User? get userData => _userData;

  void setUserData(User? data) {
    _userData = data;
    notifyListeners();
  }
}
