import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myproject/views/login.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var username = "".obs;
  var email = "".obs;
  var isEditing = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = box.read("user");
    if (user != null) {
      username.value = user["username"] ?? "Crochet Lover";
      email.value = user["email"] ?? "";
    }
  }

  Future<void> updateUsername(String newUsername) async {
    isLoading.value = true;
    try {
      final user = box.read("user");
      final userId = user["id"].toString();

      var response = await http.post(
        Uri.parse("http://localhost/my_project/update_username.php"),
        body: {
          "id": userId,
          "username": newUsername,
        },
      );

      var data = json.decode(response.body);

      if (data["status"] == "success") {
        username.value = newUsername;

        // ✅ Update stored user data
        final updatedUser = Map<String, dynamic>.from(user);
        updatedUser["username"] = newUsername;
        box.write("user", updatedUser);

        Get.snackbar("Success ✅", "Username updated successfully!",
            snackPosition: SnackPosition.BOTTOM);
        isEditing.value = false;
      } else {
        Get.snackbar("Error ❌", data["message"] ?? "Update failed",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error ❌", "Could not connect to server",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    box.erase();
    Get.offAll(() => const LoginScreen());
  }
}