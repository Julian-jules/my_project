import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/controllers/cartcontroller.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;
  var orderPlaced = false.obs;
  final box = GetStorage();

  Future<void> checkout(String phone) async {
    final cartController = Get.find<CartController>();
    final user = box.read("user");

    if (user == null) {
      Get.snackbar("Error", "Please log in first",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (phone.isEmpty) {
      Get.snackbar("Error", "Please enter your M-Pesa phone number",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final total = cartController.totalPrice;
      final items = jsonEncode(cartController.cartItems.toList());
      final userId = user["id"].toString();
      final username = user["username"] ?? "Unknown";

      // ─── Step 1: Send STK Push ────────────────────────────
      final mpesaResponse = await http.post(
        Uri.parse("http://localhost/my_project/mpesa.php"),
        body: {
          "phone": phone,
          "amount": total.toStringAsFixed(0),
          "order_id": DateTime.now().millisecondsSinceEpoch.toString(),
        },
      );

      final mpesaData = jsonDecode(mpesaResponse.body);

      if (mpesaData["status"] != "success") {
        Get.snackbar("Payment Failed ❌", mpesaData["message"],
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      final checkoutId = mpesaData["checkout_id"];

      // ─── Step 2: Save Order ───────────────────────────────
      final orderResponse = await http.post(
        Uri.parse("http://localhost/my_project/place_order.php"),
        body: {
          "user_id": userId,
          "username": username,
          "items": items,
          "total": total.toString(),
          "phone": phone,
          "checkout_id": checkoutId,
        },
      );

      final orderData = jsonDecode(orderResponse.body);

      if (orderData["status"] == "success") {
        orderPlaced.value = true;
        cartController.cartItems.clear();
        cartController.saveCart();
        Get.snackbar(
          "Order Placed! 🎉",
          "Check your phone for M-Pesa prompt",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        Get.back();
      } else {
        Get.snackbar("Error ❌", orderData["message"],
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error ❌", "Something went wrong: $e",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}