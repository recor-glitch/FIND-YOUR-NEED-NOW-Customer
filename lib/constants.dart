import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kInvalidNumber = "Invalid Phone Number";

const String dummyProfile =
    'https://cdn-icons-png.flaticon.com/128/2922/2922510.png';
const String dummyProfilefailled =
    'https://cdn3.iconfinder.com/data/icons/toolbar-people/512/user_problem_man_male_person_profile-512.png';

//App Theme...
ThemeData darkTheme = ThemeData.dark();

ThemeData lightTheme = ThemeData.light();
