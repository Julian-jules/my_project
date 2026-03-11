import 'package:get/get.dart';
import 'package:myproject/views/homescreen.dart';
import 'package:myproject/views/login.dart';
import 'package:myproject/views/signup.dart';
import 'package:myproject/views/password.dart';

var routes = {
  GetPage(name: "/login", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignUp()),
  GetPage(name: "/homescreen", page: () => Homescreen()),
  GetPage(name: "/password", page: () => ResetPasswordScreen()),
};
