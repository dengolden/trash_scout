import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;

  void setEmailPassword(String email, String password) {
    _email = email;
    _password = password;
    notifyListeners();
  }
}
