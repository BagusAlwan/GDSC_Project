import 'package:flutter/cupertino.dart';
import 'package:gdsc/models/user.dart';
import 'package:gdsc/resources/authMethod.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<User> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
    return user;
  }
}
