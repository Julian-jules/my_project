import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myproject/config/routes.dart';
import 'package:myproject/views/login.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes.toList(),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}
