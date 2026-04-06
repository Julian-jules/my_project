import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/views/homescreen.dart';
import 'package:myproject/views/login.dart';
import 'package:myproject/views/signup.dart';
import 'package:myproject/views/password.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => LoginScreen()),
        GetPage(name: "/homescreen", page: () => HomeScreen()),
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/password", page: () => ResetPasswordScreen()),
      ],
    ),
  );
}
