import 'package:get/get.dart';
import 'package:myproject/views/login.dart';

class ProfileController extends GetxController {
  var username = "Crochet Lover".obs;
  var bio = "Sharing my love for yarn 🧶".obs;

  void logout() {
    Get.offAll(() => const LoginScreen());
  }
}
