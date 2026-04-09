import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Logincontroller extends GetxController {

  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse("http://localhost/my_project/login.php"),
        body: {
          "email": email,
          "password": password,
        },
      );

      final data = json.decode(response.body);

      if (data["status"] == "success") {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }

    } catch (e) {
      print("Login error: $e");
      isLoading.value = false;
      return false;
    }
  }
}