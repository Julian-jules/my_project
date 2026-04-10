import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> login(String email, String password) async {
    var url = Uri.parse("http://localhost/my_project/login.php");

    try {
      isLoading.value = true;

    var response = await http.post(url, body: {
      "email": email,
      "password": password,
    });

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } else {
      print("Server error: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error connecting to server: $e");
    return false;
  } finally {
    isLoading.value = false;
  }
  }
}