import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myproject/config/routes.dart';
import 'package:myproject/views/homescreen.dart';
import 'package:myproject/views/login.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  final box = GetStorage();
  final isLoggedIn = box.read("isLoggedIn") ?? false; // default to false if not set

  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes.toList(),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Homescreen() : LoginScreen(), 
    ),
  );
}