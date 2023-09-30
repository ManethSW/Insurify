import 'package:flutter/material.dart';

//User Provider Class
class UserData extends ChangeNotifier {
  String? fname;
  String? lname;
  String? email;
  String? phoneNo;
  DateTime? dob;
  Image? profilePic;

  UserData(
      {required this.fname,
      required this.lname,
      required this.email,
      required this.phoneNo,
      required this.dob,
      this.profilePic});

  void setData({
    String? fname,
    String? lname,
    String? email,
    String? phoneNo,
    DateTime? dob,
  }) {
    this.fname = fname;
    this.lname = lname;
    this.email = email;
    this.dob = dob;
    this.phoneNo = phoneNo;
    notifyListeners();
  }

  void setProfilePic({
    Image? profilePic,
  }) {
    this.profilePic = profilePic;
    notifyListeners();
  }
}

//User Provider Class
class UserDataProvider extends ChangeNotifier {
  final UserData _userData = UserData(
    fname: 'Maneth',
    lname: 'Weerasinghe',
    email: 'manethweerasinghe@gmail.com',
    phoneNo: '0778880661',
    dob: DateTime.now(),
    profilePic: null,
  );

  UserData get userData => _userData;
}
