import 'package:flutter/material.dart';

//User Provider Class
class UserData extends ChangeNotifier {
  String? fname;
  String? lname;
  String? email;
  String? phoneNo;
  DateTime? dob;
  String? gender;

  UserData(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phoneNo,
      required this.dob,
      required this.gender});

  void setData({
    String? fname,
    String? lname,
    String? email,
    String? phoneNo,
    DateTime? dob,
    String? gender,
  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.dob = dob;
    this.phoneNo = phoneNo;
    this.gender = gender;
    notifyListeners();
  }
}

//User Provider Class
class UserDataProvider extends ChangeNotifier {
  final UserData _userData = UserData(
    fname: '',
    lname: '',
    email: '',
    phoneNo: '',
    dob: DateTime.now(),
    gender: ''
  );

  UserData get userData => _userData;
}
